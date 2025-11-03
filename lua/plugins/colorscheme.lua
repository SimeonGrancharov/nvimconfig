return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      highlight_groups = {
        -- Make fzf-lua transparent
        FzfLuaNormal = { bg = "none" },
        FzfLuaBorder = { bg = "none" },
        FzfLuaTitle = { bg = "none" },
        FzfLuaPreviewNormal = { bg = "none" },
        FzfLuaPreviewBorder = { bg = "none" },
        FzfLuaPreviewTitle = { bg = "none" },

        -- Make trouble transparent
        TroubleNormal = { bg = "none" },
        TroubleNormalNC = { bg = "none" },
        TroubleText = { bg = "none" },
        TroubleCount = { bg = "none" },
        TroubleCode = { bg = "none" },

        -- General floating windows
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")

      -- Force transparency after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Floating windows
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

          -- Trouble
          vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })

          -- fzf-lua
          vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "FzfLuaBorder", { bg = "none" })
          vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { bg = "none" })
        end,
      })

      -- Apply immediately
      vim.cmd("doautocmd ColorScheme")
    end,
  },
}
