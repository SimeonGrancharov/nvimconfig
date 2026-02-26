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

-- btop floating terminal
keymap.set("n", "<leader>bt", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.fn.termopen("btop", {
    on_exit = function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end,
  })

  vim.cmd("startinsert")
end, { desc = "Open btop in floating window" })

-- console.log snippet
keymap.set("n", "<leader>cl", function()
    vim.api.nvim_put({ "console.log('[MONKA]', )" }, "l", true, false)
    vim.cmd("normal! f)i")
end, { desc = "Insert console.log" })
