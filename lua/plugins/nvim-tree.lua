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
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    experimental = {
      actions = {
        open_file = {
          relative_path = true,
        },
      },
    },
  },
  keys = {
    { '<C-t>', function()
      local api = require('nvim-tree.api')
      api.tree.toggle({ path = vim.fn.getcwd() })
    end, desc = "Toggle file tree" },
  },
}
