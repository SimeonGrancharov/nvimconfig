local M = {}

-- Custom rename function with popup at cursor
function M.rename()
  local curr_name = vim.fn.expand("<cword>")

  -- Create buffer for input
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { curr_name })

  -- Calculate width based on current word
  local width = math.max(#curr_name + 10, 30)

  -- Create floating window at cursor
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = width,
    height = 1,
    style = 'minimal',
    border = 'rounded',
    title = ' Rename ',
    title_pos = 'center',
  })

  -- Apply highlighting
  vim.api.nvim_set_option_value('winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder', { win = win })

  -- Start in insert mode and select all text
  vim.cmd('startinsert')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-a>', true, false, true), 'n', false)

  -- Enable arrow keys
  local opts = { buffer = buf, noremap = true, silent = true }
  vim.keymap.set('i', '<Left>', '<Left>', opts)
  vim.keymap.set('i', '<Right>', '<Right>', opts)

  -- Handle Enter to confirm rename
  vim.keymap.set('i', '<CR>', function()
    local new_name = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
    vim.api.nvim_win_close(win, true)

    if new_name and new_name ~= "" and new_name ~= curr_name then
      vim.lsp.buf.rename(new_name)
    end
  end, opts)

  -- Handle Escape to cancel
  vim.keymap.set('i', '<Esc>', function()
    vim.api.nvim_win_close(win, true)
  end, opts)
  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, noremap = true, silent = true })
end

-- Custom code action function with styled popup at cursor
function M.code_action()
  local params = vim.lsp.util.make_range_params()
  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
  }

  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local all_results = {}
  local responses_received = 0
  local total_clients = 0

  -- Count clients that support code actions
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/codeAction') then
      total_clients = total_clients + 1
    end
  end

  if total_clients == 0 then
    vim.notify('No code actions available', vim.log.levels.INFO)
    return
  end

  -- Request from all clients and collect results
  for _, client in ipairs(clients) do
    if client.supports_method('textDocument/codeAction') then
      client.request('textDocument/codeAction', params, function(err, result, ctx)
        responses_received = responses_received + 1

        if result and not vim.tbl_isempty(result) then
          vim.list_extend(all_results, result)
        end

        -- Once all clients have responded, show the popup
        if responses_received == total_clients then
          if vim.tbl_isempty(all_results) then
            vim.notify('No code actions available', vim.log.levels.INFO)
            return
          end

          -- Format actions for display
          local items = {}
          for i, action in ipairs(all_results) do
            local title = action.title:gsub('\r\n', '\\r\\n')
            title = title:gsub('\n', '\\n')
            table.insert(items, string.format("%d. %s", i, title))
          end

          -- Create buffer for menu
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)
          vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

          -- Calculate dimensions
          local width = 0
          for _, item in ipairs(items) do
            width = math.max(width, #item)
          end
          width = math.min(width + 2, 80)
          local height = math.min(#items, 15)

          -- Create floating window at cursor
          local float_win = vim.api.nvim_open_win(buf, true, {
            relative = 'cursor',
            row = 1,
            col = 0,
            width = width,
            height = height,
            style = 'minimal',
            border = 'rounded',
          })

          -- Apply highlighting
          vim.api.nvim_set_option_value('winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder', { win = float_win })

          -- Set up keymaps for selection
          local function select_action(index)
            vim.api.nvim_win_close(float_win, true)
            local action = all_results[index]
            if action.edit or type(action.command) == "table" then
              if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, 'utf-8')
              end
              if type(action.command) == "table" then
                vim.lsp.buf.execute_command(action.command)
              end
            else
              vim.lsp.buf.execute_command(action)
            end
          end

          -- Number key mappings
          for i = 1, math.min(#all_results, 9) do
            vim.keymap.set('n', tostring(i), function() select_action(i) end, { buffer = buf })
          end

          -- Enter to select current line
          vim.keymap.set('n', '<CR>', function()
            local line = vim.api.nvim_win_get_cursor(float_win)[1]
            select_action(line)
          end, { buffer = buf })

          -- Escape to close
          vim.keymap.set('n', '<Esc>', function()
            vim.api.nvim_win_close(float_win, true)
          end, { buffer = buf })
          vim.keymap.set('n', 'q', function()
            vim.api.nvim_win_close(float_win, true)
          end, { buffer = buf })
        end
      end, bufnr)
    end
  end
end

return M
