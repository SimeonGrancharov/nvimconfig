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
      -- Custom rename function with arrow keys enabled
      local function custom_rename()
        local curr_name = vim.fn.expand("<cword>")

        vim.ui.input({
          prompt = "New name: ",
          default = curr_name,
        }, function(new_name)
          if new_name and new_name ~= "" and new_name ~= curr_name then
            vim.lsp.buf.rename(new_name)
          end
        end)

        -- Re-enable arrow keys in the rename popup
        vim.defer_fn(function()
          local bufnr = vim.api.nvim_get_current_buf()
          local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })

          if buftype == 'prompt' then
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('i', '<Left>', '<Left>', opts)
            vim.keymap.set('i', '<Right>', '<Right>', opts)
            vim.keymap.set('i', '<Up>', '<Up>', opts)
            vim.keymap.set('i', '<Down>', '<Down>', opts)
          end
        end, 10)
      end

      -- Function to organize imports and remove unused (except React)
      local function organize_and_remove_unused()
        local bufnr = vim.api.nvim_get_current_buf()

        local function get_actions_and_apply(kind, filter_fn)
          local params = {
            textDocument = vim.lsp.util.make_text_document_params(bufnr),
            range = {
              start = { line = 0, character = 0 },
              ['end'] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 }
            },
            context = {
              diagnostics = {},
              only = { kind }
            }
          }

          local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)

          if result then
            for _, response in pairs(result) do
              if response.result then
                for _, action in ipairs(response.result) do
                  if not filter_fn or filter_fn(action) then
                    if action.edit then
                      vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                    elseif action.command then
                      vim.lsp.buf.execute_command(action.command)
                    end
                  end
                end
              end
            end
          end
        end

        -- Step 1: Organize imports (no filter)
        get_actions_and_apply("source.organizeImports")

        -- Step 2: Remove unused imports (filter out React)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local react_lines = {}
        for i, line in ipairs(lines) do
          if line:match("from%s+['\"]react['\"]") or line:match("import%s+React") then
            react_lines[i - 1] = true  -- 0-indexed
          end
        end

        get_actions_and_apply("source.removeUnusedImports", function(action)
          if not action.edit then return true end

          local function is_import_line(line_num)
            local line = lines[line_num + 1] or ""
            return line:match("^import%s") or line:match("^%s*import%s")
          end

          -- Check documentChanges format
          if action.edit.documentChanges then
            for _, change in ipairs(action.edit.documentChanges) do
              if change.edits then
                for _, edit in ipairs(change.edits) do
                  local line_num = edit.range.start.line

                  -- Skip if not an import line (filtering out variable removals)
                  if not is_import_line(line_num) then
                    return false
                  end

                  -- Skip if it's a React import
                  if react_lines[line_num] then
                    return false
                  end
                end
              end
            end
          -- Check changes format
          elseif action.edit.changes then
            for _, edits in pairs(action.edit.changes) do
              for _, edit in ipairs(edits) do
                local line_num = edit.range.start.line

                -- Skip if not an import line (filtering out variable removals)
                if not is_import_line(line_num) then
                  return false
                end

                -- Skip if it's a React import
                if react_lines[line_num] then
                  return false
                end
              end
            end
          end

          return true
        end)
      end

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
        vim.keymap.set('n', '<leader>rn', custom_rename, opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        vim.keymap.set('n', '<leader>oi', organize_and_remove_unused, opts)
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

      -- Auto-organize and remove unused imports on save for TS/TSX files
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
        callback = function()
          organize_and_remove_unused()
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

      -- Enable all servers
      for _, server in ipairs({ 'lua_ls', 'ts_ls', 'cssls', 'html', 'eslint', 'css_variables', 'cssmodules_ls', 'eslint', 'html', 'prettier', 'somesass_ls', 'tailwindcss' }) do
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
