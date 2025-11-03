return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Safe macOS battery component for Lualine
      local function get_battery_status()
        local ok, uname = pcall(function() return vim.loop.os_uname().sysname end)
        if not ok or uname ~= "Darwin" then
          return "guz"
        end

        local handle = io.popen("pmset -g batt 2>/dev/null")
        if not handle then
          return ""
        end

        local result = handle:read("*a") or ""
        handle:close()

        local percent = result:match("(%d+)%%")
        local status = result:match(";%s*(%a+);")

        if not percent then
          return ""
        end

        local icon = "🔋"
        if status == "charging" then
          icon = "⚡"
        elseif status == "charged" then
          icon = "🔌"
        end

        return string.format("%s %s%%%%", icon, percent)
      end

      -- Cache last known percent to avoid recursion
      local last_battery_percent = 100

      local battery_component = {
        function()
          local status = get_battery_status()
          if status ~= "" then
            local percent = tonumber(status:match("(%d+)%%"))
            if percent then last_battery_percent = percent end
          end
          return status
        end,
      }

      local time_component = {
        function()
          return "🕐 " .. os.date("%H:%M")
        end,
      }

      -- LSP Status component
      local lsp_component = {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end

          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end

          return "⚙️  " .. table.concat(names, ", ")
        end,
      }

      -- Search count component
      local search_component = {
        function()
          if vim.v.hlsearch == 0 then
            return ""
          end

          local ok, search = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
          if not ok or search.current == nil then
            return ""
          end

          if search.incomplete == 1 then
            return "🔍 ?/?"
          end

          return string.format("🔍 %d/%d", search.current, search.total)
        end,
      }

      -- Macro recording indicator
      local macro_component = {
        function()
          local reg = vim.fn.reg_recording()
          if reg == "" then
            return ""
          end
          return "⏺️  @" .. reg
        end,
      }

      -- BMW M Colors Theme
      local bmw_m_theme = {
        normal = {
          a = { bg = '#4DD4FF', fg = '#ffffff', gui = 'bold' },
          b = { bg = '#3D8BFF', fg = '#ffffff' },
          c = { bg = '#FF5370', fg = '#ffffff' },
          z = { bg = '#4DD4FF', fg = '#ffffff' },
          y = { bg = '#3D8BFF', fg = '#ffffff' },
          x = { bg = '#FF5370', fg = '#ffffff', gui = 'bold' },
        },
        insert = {
          a = { bg = '#4DD4FF', fg = '#ffffff', gui = 'bold' },
          b = { bg = '#3D8BFF', fg = '#ffffff' },
          c = { bg = '#FF5370', fg = '#ffffff' },
          z = { bg = '#4DD4FF', fg = '#ffffff' },
          y = { bg = '#3D8BFF', fg = '#ffffff' },
          x = { bg = '#FF5370', fg = '#ffffff', gui = 'bold' },
        },
        visual = {
          a = { bg = '#4DD4FF', fg = '#ffffff', gui = 'bold' },
          b = { bg = '#3D8BFF', fg = '#ffffff' },
          c = { bg = '#FF5370', fg = '#ffffff' },
          z = { bg = '#4DD4FF', fg = '#ffffff' },
          y = { bg = '#3D8BFF', fg = '#ffffff' },
          x = { bg = '#FF5370', fg = '#ffffff', gui = 'bold' },
        },
        replace = {
          a = { bg = '#4DD4FF', fg = '#ffffff', gui = 'bold' },
          b = { bg = '#3D8BFF', fg = '#ffffff' },
          c = { bg = '#FF5370', fg = '#ffffff' },
          z = { bg = '#4DD4FF', fg = '#ffffff' },
          y = { bg = '#3D8BFF', fg = '#ffffff' },
          x = { bg = '#FF5370', fg = '#ffffff', gui = 'bold' },
        },
        command = {
          a = { bg = '#4DD4FF', fg = '#ffffff', gui = 'bold' },
          b = { bg = '#3D8BFF', fg = '#ffffff' },
          c = { bg = '#FF5370', fg = '#ffffff' },
          z = { bg = '#4DD4FF', fg = '#ffffff' },
          y = { bg = '#3D8BFF', fg = '#ffffff' },
          x = { bg = '#FF5370', fg = '#ffffff', gui = 'bold' },
        },
        inactive = {
          a = { bg = '#2a2a2a', fg = '#606060', gui = 'bold' },
          b = { bg = '#2a2a2a', fg = '#606060' },
          c = { bg = '#1a1a1a', fg = '#606060' },
          z = { bg = '#1a1a1a', fg = '#606060' },
          y = { bg = '#2a2a2a', fg = '#606060' },
          x = { bg = '#2a2a2a', fg = '#606060' },
        },
      }

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = bmw_m_theme,
          section_separators = { left = '▓▒░', right = '░▒▓' },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = { "mode", macro_component },
          lualine_b = {
            "branch",
            {
              "diff",
              colored = true,
              diff_color = {
                added = { fg = "#ffffff" },
                modified = { fg = "#ffffff" },
                removed = { fg = "#ffffff" },
              },
            },
            "diagnostics"
          },
          lualine_c = { { "filename", path = 4 }, lsp_component, search_component },
          lualine_x = { battery_component, "|", time_component },
          lualine_y = { "progress", "location" },
          lualine_z = {
            function()
              return "///M"
            end
          },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })

      -- Red background for the window separator between splits
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#FF5370", fg = "#FF5370" })
      vim.api.nvim_set_hl(0, "VertSplit", { bg = "#FF5370", fg = "#FF5370" })
    end,
  }
}
