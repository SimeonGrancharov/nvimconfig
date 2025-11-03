return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    view = {
      width = 40,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
  keys = {
    { '<C-t>', ':NvimTreeToggle<CR>', desc = "Toggle file tree" },
  },
}
