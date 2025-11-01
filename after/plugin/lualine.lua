-- 🧩 Safe macOS battery component for Lualine
local function get_battery_status()
  local ok, uname = pcall(function() return vim.loop.os_uname().sysname end)
  if not ok or uname ~= "Darwin" then
    return "guz"
  end

  local handle = io.popen("pmset -g batt 2>/dev/null")
  if not handle then
    print("Battery: handle is nil")
    return ""
  end

  local result = handle:read("*a") or ""
  handle:close()


  local percent = result:match("(%d+)%%")
  local status = result:match(";%s*(%a+);")

  if not percent then
    print("Battery: no percent found")
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

  color = function()
    local percent = last_battery_percent
    if percent < 20 then
      return { fg = "#ff5555" }  -- red
    elseif percent < 50 then
      return { fg = "#f1fa8c" }  -- yellow
    else
      return { fg = "#50fa7b" }  -- green
    end
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
  color = { fg = "#89b4fa" },  -- blue
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
  color = { fg = "#f9e2af" },  -- yellow
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
  color = { fg = "#f38ba8", gui = "bold" },  -- red and bold
}

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { "mode", macro_component },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 4 }, lsp_component, search_component },
    lualine_x = { battery_component, "|", time_component },
    lualine_y = { "progress", "location" },
    lualine_z = {
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
      },
    },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
