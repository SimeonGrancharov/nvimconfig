-- Set leader key BEFORE loading plugins
vim.g.mapleader = ","

-- Enable true color support
vim.opt.termguicolors = true

-- mode is shown in our statusline
vim.o.showmode = false
-- ruler is integrated in our statusline
vim.opt.ruler = false
-- global statusline (one statusline for all windows)
vim.o.laststatus = 3
-- fast update times - what's not to like
vim.opt.updatetime = 50

-- Tab set to two spaces

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- display line numbers
vim.opt.number = true

-- sane undo config
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- disable line wrapping
vim.opt.wrap = false

-- keep 20 rows always visible when scrolling
vim.opt.scrolloff = 20

-- always display sign column
vim.opt.signcolumn = 'yes'

-- login shell
vim.opt.shell = 'zsh --login'

-- Force transparent backgrounds for all floating windows
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })
  end,
})

-- Remove unused + organize imports on save (synchronous)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
--   pattern = { "*.ts", "*.tsx" },
--   callback = function()
--     local actions = { "source.removeUnused.ts", "source.organizeImports.ts" }
--
--     for _, actionKind in ipairs(actions) do
--       local params = vim.lsp.util.make_range_params()
--       params.context = { only = { actionKind } }
--
--       local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
--       if result then
--         for _, res in pairs(result) do
--           for _, action in pairs(res.result or {}) do
--             if action.edit then
--               vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
--             elseif type(action.command) == "table" then
--               vim.lsp.buf.execute_command(action.command)
--             end
--           end
--         end
--       end
--     end
--   end,
-- })

-- Auto-change cwd when switching to a file in a different workspace (monorepo only)
local function find_monorepo_root(start_path)
  local path = vim.fn.fnamemodify(start_path, ":p:h")

  -- Walk up to find a directory that contains apps/ or packages/
  while path and path ~= "/" do
    if vim.loop.fs_stat(path .. "/apps") or vim.loop.fs_stat(path .. "/packages") then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then break end
    path = parent
  end

  return nil
end

local function find_workspace_root(filepath)
  if not filepath or filepath == "" then return nil end

  -- First, check if we're inside a monorepo
  local monorepo_root = find_monorepo_root(filepath)
  if not monorepo_root then return nil end

  local path = vim.fn.fnamemodify(filepath, ":p:h")

  -- Now find the workspace within the monorepo (apps/* or packages/*)
  while path and path ~= "/" and path:find(monorepo_root, 1, true) == 1 do
    local parent = vim.fn.fnamemodify(path, ":h")
    local parent_name = vim.fn.fnamemodify(parent, ":t")

    -- Check if this is a workspace (direct child of apps/ or packages/)
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

    -- Skip if not a real file
    if bufpath == "" or vim.bo.buftype ~= "" then return end

    local workspace_root = find_workspace_root(bufpath)
    if workspace_root then
      local current_cwd = vim.fn.getcwd()

      -- Only change if we're in a different workspace
      if workspace_root ~= current_cwd then
        vim.cmd("cd " .. vim.fn.fnameescape(workspace_root))
      end
    end
  end,
})
