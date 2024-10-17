local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local typescript = require('typescript')

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

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")      -- rename file and update imports
    vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")    -- remove unused variables (not in youtube nvim video)
  end
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
    'tsserver',
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

typescript.setup({
  on_attach = on_attach,
})

lspconfig.cssls.setup {}
lspconfig.somesass_ls.setup {}
lspconfig.css_variables.setup {}
lspconfig.cssmodules_ls.setup {}
lspconfig.tsserver.setup {
  init_options = {
    preferences = {
      -- other preferences...
      importModuleSpecifierPreference = 'relative',
      -- importModuleSpecifierEnding = 'minimal',
    }
  }
}
