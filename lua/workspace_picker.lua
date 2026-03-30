local M = {}

-- Find project root (where .git lives)
local function find_project_root(start)
  start = vim.fn.fnamemodify(start, ":p")
  while start ~= "/" do
    if vim.loop.fs_stat(start .. "/.git") then
      return start
    end
    start = vim.fn.fnamemodify(start .. "/..", ":p")
  end
  return vim.fn.getcwd()
end

-- Find the "web" root (apps/ + packages/)
local function find_web_root(start)
  start = vim.fn.fnamemodify(start, ":p")
  while start ~= "/" do
    if vim.loop.fs_stat(start .. "/apps") or vim.loop.fs_stat(start .. "/packages") then
      return start
    end
    start = vim.fn.fnamemodify(start .. "/..", ":p")
  end
  return nil
end

-- Build list: root + apps/* + packages/*
local function collect_workspaces()
  local cwd = vim.fn.getcwd()
  local project_root = find_project_root(cwd)
  local web_root = find_web_root(cwd) or (project_root .. "/web")

  local entries = {
    { label = "🏠 root", path = project_root },
  }

  local function scan(dir, icon)
    if not vim.loop.fs_stat(dir) then return end
    local handle = vim.loop.fs_scandir(dir)
    if not handle then return end

    while true do
      local name, t = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if t == "directory" then
        table.insert(entries, {
          label = icon .. " " .. name,
          path = dir .. "/" .. name,
        })
      end
    end
  end

  scan(web_root .. "/apps", "🚀")
  scan(web_root .. "/packages", "📦")

  return entries
end

-- ---------------------------------------------------------------------------
-- FZF PICKER
-- ---------------------------------------------------------------------------

function M.pick()
  local fzf = require("fzf-lua")

  local entries = collect_workspaces()
  if #entries == 0 then
    vim.notify("No workspaces found", vim.log.levels.WARN)
    return
  end

  -- Convert to fzf rows
  local fzf_list = {}
  for _, e in ipairs(entries) do
    table.insert(fzf_list, e.label)
  end

  fzf.fzf_exec(fzf_list, {
    prompt = "Workspaces❯ ",
    winopts = { height = 0.4, width = 0.45, row = 0.3 },
    actions = {
      ["default"] = function(selected)
        local label = selected[1]
        for _, e in ipairs(entries) do
          if e.label == label then
            vim.cmd("cd " .. vim.fn.fnameescape(e.path))
            vim.notify("CWD → " .. e.path)

            -- Auto-open package.json
            local pkg = e.path .. "/package.json"
            if vim.loop.fs_stat(pkg) then
              vim.cmd("edit " .. vim.fn.fnameescape(pkg))
            end

            return
          end
        end
      end,
    },
  })
end

-- Auto-change cwd when switching to a file in a different workspace
local function find_workspace_root(filepath)
  if not filepath or filepath == "" then return nil end

  local monorepo_root = find_web_root(vim.fn.fnamemodify(filepath, ":p:h"))
  if not monorepo_root then return nil end

  local path = vim.fn.fnamemodify(filepath, ":p:h")

  while path and path ~= "/" and path:find(monorepo_root, 1, true) == 1 do
    local parent = vim.fn.fnamemodify(path, ":h")
    local parent_name = vim.fn.fnamemodify(parent, ":t")

    if parent_name == "apps" or parent_name == "packages" then
      return path
    end

    if parent == path then break end
    path = parent
  end

  return nil
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("auto_workspace_cwd", { clear = true }),
  callback = function()
    local bufpath = vim.api.nvim_buf_get_name(0)
    if bufpath == "" or vim.bo.buftype ~= "" then return end

    local workspace_root = find_workspace_root(bufpath)
    if workspace_root and workspace_root ~= vim.fn.getcwd() then
      vim.cmd("cd " .. vim.fn.fnameescape(workspace_root))
    end
  end,
})

return M
