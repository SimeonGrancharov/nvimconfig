local M = {}

-- Override vim.ui.input with custom floating window
function M.setup_input()
  vim.ui.input = function(opts, on_confirm)
    opts = opts or {}
    local default = opts.default or ""

    -- Create buffer for input
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default })

    -- Calculate width
    local width = math.max(#default + 10, 30)
    if opts.prompt then
      width = math.max(width, #opts.prompt + 5)
    end

    -- Create floating window at cursor
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'cursor',
      row = 1,
      col = 0,
      width = width,
      height = 1,
      style = 'minimal',
      border = 'rounded',
      title = opts.prompt and ' ' .. opts.prompt:gsub(':?%s*$', '') .. ' ' or ' Input ',
      title_pos = 'center',
    })

    -- Apply highlighting
    vim.api.nvim_set_option_value('winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder', { win = win })

    -- Start in insert mode with cursor at the end
    vim.schedule(function()
      vim.cmd('startinsert!')
    end)

    -- Enable arrow keys
    local keymap_opts = { buffer = buf, noremap = true, silent = true }
    vim.keymap.set('i', '<Left>', '<Left>', keymap_opts)
    vim.keymap.set('i', '<Right>', '<Right>', keymap_opts)

    -- Handle Enter to confirm
    vim.keymap.set('i', '<CR>', function()
      local input = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
      vim.api.nvim_win_close(win, true)
      if on_confirm then
        on_confirm(input)
      end
    end, keymap_opts)

    -- Handle Escape to cancel
    vim.keymap.set('i', '<Esc>', function()
      vim.api.nvim_win_close(win, true)
      if on_confirm then
        on_confirm(nil)
      end
    end, keymap_opts)
    vim.keymap.set('n', '<Esc>', function()
      vim.api.nvim_win_close(win, true)
      if on_confirm then
        on_confirm(nil)
      end
    end, { buffer = buf, noremap = true, silent = true })
  end
end

-- Override vim.ui.select with custom floating window
function M.setup_select()
  vim.ui.select = function(items, opts, on_choice)
    opts = opts or {}

    -- Format items for display
    local display_items = {}
    for i, item in ipairs(items) do
      local formatted
      if opts.format_item then
        formatted = opts.format_item(item)
      else
        formatted = tostring(item)
      end
      table.insert(display_items, string.format("%d. %s", i, formatted))
    end

    -- Create buffer for menu
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_items)
    vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

    -- Calculate dimensions
    local width = 0
    for _, item in ipairs(display_items) do
      width = math.max(width, #item)
    end
    width = math.min(width + 2, 80)
    local height = math.min(#display_items, 15)

    -- Create floating window at cursor
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'cursor',
      row = 1,
      col = 0,
      width = width,
      height = height,
      style = 'minimal',
      border = 'rounded',
      title = opts.prompt and ' ' .. opts.prompt .. ' ' or ' Select ',
      title_pos = 'center',
    })

    -- Apply highlighting
    vim.api.nvim_set_option_value('winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder', { win = win })

    -- Set up keymaps for selection
    local function select_item(index)
      vim.api.nvim_win_close(win, true)
      if on_choice then
        on_choice(items[index], index)
      end
    end

    -- Number key mappings
    for i = 1, math.min(#items, 9) do
      vim.keymap.set('n', tostring(i), function() select_item(i) end, { buffer = buf })
    end

    -- Enter to select current line
    vim.keymap.set('n', '<CR>', function()
      local line = vim.api.nvim_win_get_cursor(win)[1]
      select_item(line)
    end, { buffer = buf })

    -- Escape to cancel
    vim.keymap.set('n', '<Esc>', function()
      vim.api.nvim_win_close(win, true)
      if on_choice then
        on_choice(nil, nil)
      end
    end, { buffer = buf })
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(win, true)
      if on_choice then
        on_choice(nil, nil)
      end
    end, { buffer = buf })
  end
end

-- Setup both overrides
function M.setup()
  M.setup_input()
  M.setup_select()
end

return M
