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

-- terminal insert mode navigation
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
-- Esc exits terminal insert mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- disable mouse scrolling
vim.opt.mouse = ""
