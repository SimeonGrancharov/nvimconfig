local keymap = vim.keymap

-- don't copy to buffer when char is deleted
keymap.set("n", "x", '"_x')


-- split windows
keymap.set("n", "<leader>sh", "<C-w>s")     -- split horizontally
keymap.set("n", "<leader>sv", "<C-w>v")     -- split vertically
keymap.set("n", "<leader>sw", "<C-w>=")     -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current window

-- disable arrow keys to force hjkl usage
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")

keymap.set("i", "<Up>", "<Nop>")
keymap.set("i", "<Down>", "<Nop>")
keymap.set("i", "<Left>", "<Nop>")
keymap.set("i", "<Right>", "<Nop>")

keymap.set("v", "<Up>", "<Nop>")
keymap.set("v", "<Down>", "<Nop>")
keymap.set("v", "<Left>", "<Nop>")
keymap.set("v", "<Right>", "<Nop>")

-- terminal insert mode navigation (exclude fzf buffers)
local function term_nav(dir)
	return function()
		local ft = vim.bo.filetype
		if ft == "fzf" or ft == "FzfLua" then
			local key = "<C-" .. dir .. ">"
			return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", false)
		end
		vim.cmd("wincmd " .. dir)
	end
end

keymap.set("t", "<C-h>", term_nav("h"))
keymap.set("t", "<C-j>", term_nav("j"))
keymap.set("t", "<C-k>", term_nav("k"))
keymap.set("t", "<C-l>", term_nav("l"))
-- Tab Tab exits terminal insert mode
keymap.set("t", "<Tab><Tab>", "<C-\\><C-n>")

-- disable mouse scrolling
vim.opt.mouse = ""

-- floating terminal helper (one-shot, destroyed on exit)
local function float_term(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end)
    end,
  })

  vim.cmd("startinsert")
end

-- toggleable floating terminal (hides instead of closing, reuses buffer)
local toggle_terms = {}

local function float_win_opts()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  }
end

local function hide_float(cmd)
  local state = toggle_terms[cmd]
  if state and state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  end
end

local function setup_auto_hide(cmd)
  local state = toggle_terms[cmd]
  if not state or not state.buf then return end

  local group_name = "float_term_" .. cmd:gsub("%s", "_")
  local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
  state.augroup = augroup

  vim.api.nvim_create_autocmd("WinLeave", {
    group = augroup,
    buffer = state.buf,
    callback = function()
      vim.schedule(function() hide_float(cmd) end)
    end,
  })
end

local function toggle_float_term(cmd)
  local state = toggle_terms[cmd]

  -- If window is visible, hide it
  if state and state.win and vim.api.nvim_win_is_valid(state.win) then
    hide_float(cmd)
    return
  end

  -- If buffer is still alive, reopen it
  if state and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    state.win = vim.api.nvim_open_win(state.buf, true, float_win_opts())
    setup_auto_hide(cmd)
    vim.cmd("startinsert")
    return
  end

  -- First launch: create buffer, window, and start the process
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "hide"
  local win = vim.api.nvim_open_win(buf, true, float_win_opts())

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.schedule(function()
        local s = toggle_terms[cmd]
        if s then
          if s.augroup then
            vim.api.nvim_del_augroup_by_id(s.augroup)
          end
          if s.win and vim.api.nvim_win_is_valid(s.win) then
            vim.api.nvim_win_close(s.win, true)
          end
          if s.buf and vim.api.nvim_buf_is_valid(s.buf) then
            vim.api.nvim_buf_delete(s.buf, { force = true })
          end
        end
        toggle_terms[cmd] = nil
      end)
    end,
  })

  toggle_terms[cmd] = { buf = buf, win = win }
  setup_auto_hide(cmd)
  vim.cmd("startinsert")
end

keymap.set("n", "<leader>bt", function() float_term("btop") end, { desc = "Open btop" })
keymap.set({"n", "t"}, "<leader>gh", function() toggle_float_term("gh dash") end, { desc = "Toggle gh dash" })

-- focus floating window
keymap.set({"n", "t"}, "<C-f>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_set_current_win(win)
      vim.cmd("startinsert")
      return
    end
  end
end, { desc = "Focus floating window" })

-- console.log snippet
keymap.set("n", "<leader>cl", function()
    vim.api.nvim_put({ "console.log('[MONKA]', )" }, "l", true, false)
    vim.cmd("normal! f)i")
end, { desc = "Insert console.log" })
