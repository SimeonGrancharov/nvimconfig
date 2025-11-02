local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- Define BMW M color highlight groups
-- BMW M colors: Light Blue, Dark Blue, Red, and White M
vim.api.nvim_set_hl(0, 'BMWLightBlue', { fg = '#1BADE3' })
vim.api.nvim_set_hl(0, 'BMWDarkBlue', { fg = '#0C4DA2' })
vim.api.nvim_set_hl(0, 'BMWRed', { fg = '#E4032E' })
vim.api.nvim_set_hl(0, 'BMWWhite', { fg = '#FFFFFF' })

-- BMW M Logo ASCII Art with colors (no extra top lines)
-- 32 in length
dashboard.section.header.val = {
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤  ⣠⣤⣤⣤⣤⣤⠀⠀⠀⠀⢀⣤⣤⣤⣤⣤⣤  ]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⠀ ]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀ ]],
[[⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ⠀]],
[[⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀ ]],
[[⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⡿⠋⢸⣿⣿⣿⣿⣿⣿⣿⡿⠋⢸⣿⣿⣿⣿⣿⣿  ]],
[[⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⢸⣿⣿⣿⣿⣿⡿⠋  ⢸⣿⣿⣿⣿⣿⣿  ]],
[[⠀⠉⠉⠉⠉⠉⠉⠉  ⠀⠉⠉⠉⠉⠉⠉⠉⠀ ⠀⠉⠉⠉⠉⠉⠉⠉   ⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉ ⠀  ⠈⠉⠉⠉⠉⠉⠉  ]],
}

-- Apply colors to header lines (///M gradient)
-- Three diagonal stripes: 1st=light blue, 2nd=dark blue, 3rd=red, M=white

dashboard.section.header.opts.hl = {
  { { "BMWLightBlue", 0, 62 }, { "BMWDarkBlue", 62, 97 }, { "BMWRed", 97, 121 }, { "BMWWhite", 121, -1 }},
  { { "BMWLightBlue", 0, 60 }, { "BMWDarkBlue", 60, 92 }, { "BMWRed", 92, 118 }, { "BMWWhite", 118, -1 }},
  { { "BMWLightBlue", 0, 56 }, { "BMWDarkBlue", 56, 82 }, { "BMWRed", 82, 112 }, { "BMWWhite", 112, -1 }},
  { { "BMWLightBlue", 0, 50 }, { "BMWDarkBlue", 50, 76 }, { "BMWRed", 76, 106 }, { "BMWWhite", 106, -1 }},
  { { "BMWLightBlue", 0, 44 }, { "BMWDarkBlue", 44, 70 }, { "BMWRed", 70, 100 }, { "BMWWhite", 100, -1 }},
  { { "BMWLightBlue", 0, 36 }, { "BMWDarkBlue", 36, 62 }, { "BMWRed", 62, 92 }, { "BMWWhite", 92, -1 }},
  { { "BMWLightBlue", 0, 28 }, { "BMWDarkBlue", 28, 58 }, { "BMWRed", 58, 88 }, { "BMWWhite", 88, -1 }},
  { { "BMWLightBlue", 0, 24 }, { "BMWDarkBlue", 24, 48 }, { "BMWRed", 48, 78 }, { "BMWWhite", 78, -1 }},
}

-- Dynamic footer with system info
local function get_footer()
  local datetime = os.date("📅    %d-%m-%Y         🕐    %H:%M")
  local version = vim.version()
  local nvim_version = string.format("🚀    Neovim  v%d.%d.%d", version.major, version.minor, version.patch)

  -- Get battery percentage (macOS)
  local battery_handle = io.popen("pmset -g batt | grep -Eo \"\\d+%\" | cut -d% -f1")
  local battery = battery_handle:read("*a")
  battery_handle:close()
  local battery_info = battery ~= "" and string.format("🔋    Battery:  %s%%", battery:gsub("\n", "")) or "🔋    Battery:  N/A"

  -- Get current directory
  local cwd = vim.fn.getcwd()
  local home = os.getenv("HOME")
  if cwd:find(home, 1, true) == 1 then
    cwd = "~" .. cwd:sub(#home + 1)
  end
  local dir_info = string.format("📁    %s", cwd)

  -- OS info
  local os_info = "💻    " .. vim.loop.os_uname().sysname .. "  " .. vim.loop.os_uname().release

  -- Plugin count
  local plugin_count = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/*/start/*", "", 1, 1)
  local plugins_info = string.format("📦    %d  plugins  loaded", plugin_count)

  -- Create info lines
  local info_lines = {
    datetime,
    nvim_version,
    battery_info,
    os_info,
    plugins_info,
    dir_info,
  }

  -- Find max width for border
  local max_width = 0
  for _, line in ipairs(info_lines) do
    -- Account for emoji taking more visual space
    local visual_length = vim.fn.strdisplaywidth(line)
    if visual_length > max_width then
      max_width = visual_length
    end
  end

  -- Add more padding for bigger appearance
  max_width = max_width + 20

  -- Build bordered output with double lines for emphasis
  local result = {}
  table.insert(result, "")
  table.insert(result, "")
  table.insert(result, "╔" .. string.rep("═", max_width) .. "╗")
  table.insert(result, "║" .. string.rep(" ", max_width) .. "║")
  table.insert(result, "║" .. string.rep(" ", max_width) .. "║")

  for _, line in ipairs(info_lines) do
    local visual_len = vim.fn.strdisplaywidth(line)
    local padding = max_width - visual_len - 10
    local padded_line = "║          " .. line .. string.rep(" ", padding) .. "║"
    table.insert(result, padded_line)
    table.insert(result, "║" .. string.rep(" ", max_width) .. "║")
    table.insert(result, "║" .. string.rep(" ", max_width) .. "║")
  end

  table.insert(result, "╚" .. string.rep("═", max_width) .. "╝")
  table.insert(result, "")
  table.insert(result, "")

  return result
end

dashboard.section.footer.val = get_footer()

-- Layout (without buttons)
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.footer,
}

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

alpha.setup(dashboard.config)
