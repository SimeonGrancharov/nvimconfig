return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline",
          format = {
            cmdline = { pattern = "^:", icon = "  ", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " 🔍 ", view = "cmdline_input" },
            search_up = { kind = "search", pattern = "^%?", icon = " 🔍 ", view = "cmdline_input" },
            filter = { pattern = "^:%s*!", icon = " $ ", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "  ", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰋖 " },
          },
        },
        messages = {
          enabled = false,
        },
        popupmenu = {
          enabled = false,
        },
        notify = {
          enabled = false,
        },
        lsp = {
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "background" },
                { find = "Background" },
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "telescope",
            },
            opts = { skip = true },
          },
        },
        views = {
          cmdline = {
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = {
                Normal = "NoiceCmdlineNormal",
                FloatBorder = "NoiceCmdlineBorder",
                Title = "NoiceCmdlineTitle",
              },
            },
          },
          cmdline_popup = {
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "NoiceCmdlineBorder",
                Title = "NoiceCmdlineTitle",
              },
              winblend = 0,
            },
          },
          cmdline_input = {
            position = {
              row = "100%",
              col = 0,
            },
            size = {
              width = "100%",
              height = "auto",
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "NoiceCmdlineBorder",
                Title = "NoiceCmdlineTitle",
                NormalFloat = "Normal",
              },
              winblend = 0,
            },
          },
          notify = {
            relative = "editor",
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = "auto",
              height = "auto",
            },
          },
        },
      })

      -- Custom border colors for cmdline (BMW M inspired)
      vim.api.nvim_set_hl(0, "NoiceCmdlineBorder", { fg = "#4DD4FF", bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#4DD4FF" })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#4DD4FF", bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = "#4DD4FF", bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = "#4DD4FF" })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#FF5370", bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlineTitle", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NoiceCmdlineNormal", { fg = "#ffffff", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NoiceCmdlineInput", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "@text.literal", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "@text.uri", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "@string.regex", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NoiceFormatSearch", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", { fg = "#4DD4FF", bold = true })
      vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = "#FFCC00" })
      vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#4DD4FF" })
      vim.api.nvim_set_hl(0, "CurSearch", { fg = "#000000", bg = "#4DD4FF" })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderInput", { fg = "#4DD4FF", bold = true })
    end,
  },
}
