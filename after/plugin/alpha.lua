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
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀ ⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⡤⠤⠤⠤⢤⠀⠀⠀⠀⢀⠤⠤⠤⢤  ]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀  ⢸⠀⠀⢀⠔⠁⠀ ⠀⢸⠀ ]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀ ⠀⢸⢀⠔⠁⠀⠀⠀ ⠀⢸⠀ ]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀ ⠀⢸ ⠀]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⣠⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀ ⠀⢸⠀ ]],
[[⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⡠⠊⢸⠀⠀⠀⠀⠀⢀⢾⠀⠀⠀ ⠀⢸  ]],
[[⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⢸⠀⠀⠀⠀⢠⠃⢸⠀⠀⠀ ⠀⢸  ]],
[[⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠈⠉⠉⠉⠉⠉⠉  ]],
}


--v1
--
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⡤⠤⠤⠤⠤⢤⠈⠄⣁⠤⠤⠤⠤⣌⠁]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⢯⣿⠏⠀⠀⠀⠀⠰⡁⡰⠁⠀⠀⠀⠀⢸⠀⠁]],
-- [[⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣾⡽⣿⠃⠀⠀⠀⠀⠀⠀⡕⠁⠀⠀⠀⠀⠀⢨⠀⡁]],
-- [[⠀⠀⠀⠀⠀⢠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣳⣯⢿⡽⠃⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⢘⠠⠀]],
-- [[⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⢯⣿⣻⣾⠃⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⢸⠀⠂]],
-- [[⠀⠀⠀⣀⣾⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣽⣻⢷⡿⠁⠀⠀⠀⢀⢞⠀⠀⠀⠀⠀⢀⢾⠀⠀⠀⠀⢰⠈⠄]],
-- [[⠀⠀⢡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣞⣷⢿⡟⠀⠀⠀⠀⢠⠊⢸⠀⠀⠀⠀⢠⠊⢸⠀⠀⠀⠀⢨⠐⡀]],
-- [[⠀⠀⠌⢉⠉⠉⢁⠉⠉⡉⠉⡉⠉⠉⠉⠉⠉⡉⢀⠉⡈⢁⠉⡁⠐⡈⢁⠉⡈⢁⠡⠐⡈⢁⠉⡈⠡⢉⠐⡀]],

-- Apply colors to header lines (///M gradient)
-- Diagonal stripe pattern: follows the outer left diagonal of the flag

dashboard.section.header.opts.hl = {
  { { "Normal", 0, -1 } },  -- Line 1: empty spacing
  { { "BMWLightBlue", 0, 67}, { "BMWDarkBlue", 67, 82 }, { "BMWRed", 82, 101}},  -- Line 2: top border
  { { "BMWLightBlue", 0, 61}, { "BMWDarkBlue", 61, 76 }, { "BMWRed", 76, 98}, { "BMWWhite", 98, -1 }},  -- Line 3
  { { "BMWLightBlue", 0, 55}, { "BMWDarkBlue", 55, 70 }, { "BMWRed", 70, 92}, { "BMWWhite", 92, -1 }},  -- Line 4
  { { "BMWLightBlue", 0, 49}, { "BMWDarkBlue", 49, 64 }, { "BMWRed", 64, 86}, { "BMWWhite", 86, -1 }},  -- Line 5
  { { "BMWLightBlue", 0, 43}, { "BMWDarkBlue", 43, 58 }, { "BMWRed", 58, 80}, { "BMWWhite", 80, -1 }},  -- Line 6
  { { "BMWLightBlue", 0, 37}, { "BMWDarkBlue", 37, 52 }, { "BMWRed", 52, 74}, { "BMWWhite", 74, -1 }},  -- Line 7
  { { "BMWLightBlue", 0, 31}, { "BMWDarkBlue", 31, 46 }, { "BMWRed", 46, 68}, { "BMWWhite", 68, -1 }},  -- Line 8
  { { "BMWLightBlue", 0, 25}, { "BMWDarkBlue", 25, 40 }, { "BMWRed", 40, 62}, { "BMWWhite", 62, -1 }},  -- Line 9: bottom border
}

-- Menu
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- Footer
local function footer()
  return "Ultimate Driving Machine"
end

dashboard.section.footer.val = footer()

-- Layout
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

alpha.setup(dashboard.config)
