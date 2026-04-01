return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local parsers = {
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
        "query",
        "markdown",
        "markdown_inline",
        "yaml",
      }

      require("nvim-treesitter").install(parsers)

      -- Enable treesitter highlighting for all installed parsers
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
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
