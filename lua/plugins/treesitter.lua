return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "css",
        "html",
        "json",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    lazy = false,
    opts = {
      enable = true,
      line_numbers = true,
      separator = "░",
    },
    keys = {
      {
        "<leader>sc",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "Navigate to start of context"
      },
    }
  }
}
