local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')

-- Custom BMW M inspired colors
vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = "#4DD4FF", bold = true })
vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = "#FF5370", bold = true })
vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { fg = "#3D8BFF", bold = true })
vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = "#FF5370", bold = true })

fzf.setup({
  winopts = {
    height = 0.5,
    width = 1.0,
    row = 1.0,
    border = "rounded",
    preview = {
      layout = "vertical",
      vertical = "down:50%",
    },
  },
  keymap = {
    builtin = {
      ["<Esc>"] = "hide",
    },
    fzf = {
      ["ctrl-j"] = "down",
      ["ctrl-k"] = "up",
      ["esc"] = "abort",
    },
  },
  files = {
    prompt = "Files❯ ",
    git_icons = true,
    file_icons = true,
    color_icons = true,
    winopts = {
      preview = {
        layout = "horizontal",
        horizontal = "right:50%",
      },
    },
  },
  grep = {
    prompt = "Rg❯ ",
    input_prompt = "Grep❯ ",
    winopts = {
      width = 1.0,
    },
  },
  buffers = {
    prompt = "Buffers❯ ",
    file_icons = true,
    color_icons = true,
  },
  git = {
    files = {
      prompt = "GitFiles❯ ",
    },
  },
})

-- Keymaps to match your telescope setup
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<leader>fs', fzf.grep, { desc = "Grep search" })
vim.keymap.set('n', '<ESC>', fzf.buffers, { desc = "Switch buffers" })
