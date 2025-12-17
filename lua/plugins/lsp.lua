return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup({
        ensure_installed = {
          'prettier',
          'prettierd'
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls',
          'eslint',
          'html',
          'lua_ls',
          'cssls'
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Setup custom UI overrides
      require('utils.ui').setup()

      -- LSP keymaps
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
      end

      -- Configure completion capabilities
      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup LspAttach autocmd for keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            on_attach(client, args.buf)
          end
        end,
      })

      -- Set default capabilities for all servers
      vim.lsp.config['*'] = {
        capabilities = cmp_capabilities,
      }

      -- Custom configs for specific servers
      vim.lsp.config.lua_ls = vim.tbl_deep_extend('force', vim.lsp.config.lua_ls or {}, {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      vim.lsp.config.ts_ls = vim.tbl_deep_extend('force', vim.lsp.config.ts_ls or {}, {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = 'non-relative',
          }
        }
      })

      -- Configure pylsp (Python LSP Server with Jedi)
      vim.lsp.config.pylsp = vim.tbl_deep_extend('force', vim.lsp.config.pylsp or {}, {
        settings = {
          pylsp = {
            plugins = {
              jedi = {
                extra_paths = { '.' },
                environment = vim.fn.getcwd() .. '/.venv/bin/python',
              },
              pylint = { enabled = false },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              mccabe = { enabled = false },
            },
          },
        },
      })

      -- Enable all servers
      for _, server in ipairs({ 'lua_ls', 'ts_ls', 'pylsp', 'cssls', 'html', 'eslint', 'css_variables', 'cssmodules_ls', 'eslint', 'html', 'prettier', 'somesass_ls', 'tailwindcss' }) do
        vim.lsp.enable(server)
      end

      -- Floating window styling
      vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "#32302f",
        fg = "#d5c4a1"
      })

      vim.api.nvim_set_hl(0, "FloatBorder", {
        bg = "#32302f",
        fg = "#bdae93"
      })

      vim.api.nvim_set_hl(0, "FloatTitle", {
        bg = "#32302f",
        fg = "#fb4934",
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
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
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
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },
}
