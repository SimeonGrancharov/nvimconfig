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
            return
          end
        end
      end,
    },
  })
end

return M
