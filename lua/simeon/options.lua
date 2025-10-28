-- mode is shown in our statusline
vim.o.showmode = false
-- ruler is integrated in our statusline
vim.opt.ruler = false
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
