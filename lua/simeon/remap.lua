vim.g.mapleader = ","

local keymap = vim.keymap

-- don't copy to buffer when char is deleted
keymap.set("n", "x", '"_x')


-- split windows
keymap.set("n", "<leader>sh", "<C-w>s")     -- split horizontally
keymap.set("n", "<leader>sv", "<C-w>v")     -- split vertically
keymap.set("n", "<leader>sw", "<C-w>=")     -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current window
