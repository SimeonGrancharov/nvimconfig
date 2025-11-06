return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "antosha417/nvim-lsp-file-operations",
  },
  opts = {
    view = {
      width = 40,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    experimental = {
      actions = {
        open_file = {
          relative_path = true,
        },
      },
    },
  },
  keys = {
    { '<C-t>', ':NvimTreeToggle<CR>', desc = "Toggle file tree" },
  },
}
