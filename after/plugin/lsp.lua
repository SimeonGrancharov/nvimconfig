local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
-- local typescript = require('typescript')

local on_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
end

lsp.preset("recommended")

lsp.on_attach(on_attach)

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ["<C-c>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
})

-- formatting
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})


require('mason').setup({
  ensure_installed = {
    'prettier',
    'prettierd'
  }
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'html',
    'lua_ls',
    'cssls'
  },
  handlers = {
    lsp.default_setup,
  },
})


-- lspconfig.eslint.setup({
--   --- ...
--   on_attach = function(_, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
-- })

-- typescript.setup({
--   on_attach = on_attach,
-- })

lspconfig.cssls.setup {}
lspconfig.somesass_ls.setup {}
lspconfig.css_variables.setup {}
lspconfig.cssmodules_ls.setup {}
lspconfig.ts_ls.setup {
  init_options = {
    preferences = {
      -- other preferences...
      importModuleSpecifierPreference = 'relative',
      -- importModuleSpecifierEnding = 'minimal',
    }
  }
}

vim.api.nvim_set_hl(0, "NormalFloat", {
  bg = "#32302f", -- Gruvbox soft dark background (slightly transparent feel)
  fg = "#d5c4a1"  -- Gruvbox soft light foreground (matches soft contrast)
})

vim.api.nvim_set_hl(0, "FloatBorder", {
  bg = "#32302f", -- Match window background
  fg = "#bdae93"  -- Gruvbox soft gray for subtle borders
})

-- Optional: Additional Gruvbox soft-themed highlights
vim.api.nvim_set_hl(0, "FloatTitle", {
  bg = "#32302f",
  fg = "#fb4934", -- Gruvbox red for titles
  bold = true
})


-- Override vim's default floating window creation
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 80
  opts.max_height = opts.max_height or 20
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
