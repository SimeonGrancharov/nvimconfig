
-- React Compiler Marker LSP configuration
-- Note: The server is not published as a standalone npm package
-- Using local build from the cloned repo
return {
  "neovim/nvim-lspconfig",
  config = function()
    local server_path = vim.fn.expand('~/work/react-compiler-marker/packages/server/bin/server.js')

    -- Auto-start on React files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      callback = function(args)
        local bufnr = args.buf
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_dir = vim.fs.root(fname, { 'package.json' })

        if not root_dir then
          return
        end

        -- Check if already attached
        local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'react_compiler_marker' })
        if #clients > 0 then
          return
        end

        -- Start the LSP client
        vim.lsp.start({
          name = 'react_compiler_marker',
          cmd = { 'node', server_path, '--stdio' },
          root_dir = root_dir,
          init_options = {
            tooltipFormat = 'markdown',  -- Use markdown instead of html
          },
          settings = {
            reactCompilerMarker = {
              successEmoji = '✨',
              errorEmoji = '🚫',
              babelPluginPath = 'node_modules/babel-plugin-react-compiler',
            },
          },
          on_attach = function(client, buf)
            -- Enable inlay hints
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })

            -- Add keybinding to show inlay hint tooltip
            vim.keymap.set('n', '<leader>ih', function()
              local params = vim.lsp.util.make_position_params()
              vim.lsp.buf_request(buf, 'textDocument/inlayHint', params, function(err, result, ctx, config)
                if err or not result then
                  vim.notify('No inlay hint at cursor', vim.log.levels.INFO)
                  return
                end

                -- Find inlay hint at cursor position
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                local line = cursor_pos[1] - 1
                local col = cursor_pos[2]

                for _, hint in ipairs(result) do
                  if hint.position.line == line and math.abs(hint.position.character - col) <= 2 then
                    if hint.tooltip then
                      local tooltip_text = type(hint.tooltip) == 'string' and hint.tooltip or hint.tooltip.value
                      vim.lsp.util.open_floating_preview({tooltip_text}, 'markdown', {
                        border = 'rounded',
                        focusable = true,
                      })
                      return
                    end
                  end
                end
                vim.notify('No tooltip found', vim.log.levels.INFO)
              end)
            end, { buffer = buf, desc = 'Show inlay hint tooltip' })
          end,
        })
      end,
    })
  end,
}
