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

-- v2
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤⠀⠀⣠⣤⣤⣤⣤⣤⣤⡤  ⡠⠤⠤⠤⢤⠀⠀⠀⠀⢀⠤⠤⠤⢤  ]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⡠⠊⠀⠀  ⢸⠀⠀⢀⠔⠁⠀ ⠀⢸⠀ ]],
-- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⡠⠊ ⠀⠀⠀ ⠀⢸⢀⠔⠁⠀⠀⠀ ⠀⢸⠀ ]],
-- [[⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⡠⠊⠀⠀ ⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀ ⠀⢸ ⠀]],
-- [[⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⡠⠊⠀⠀⠀⠀ ⠀⣠⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀ ⠀⢸⠀ ]],
-- [[⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⡠⠊⠀⠀⠀⠀⠀ ⡠⠊⢸⠀⠀⠀⠀⠀⢀⢾⠀⠀⠀ ⠀⢸  ]],
-- [[⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋⠀⣠⣾⣿⣿⣿⣿⣿⡿⠋ ⡠⠊⠀⠀⠀⠀⠀ ⡠⠊⠀⠀⢸⠀⠀⠀⠀⢠⠃⢸⠀⠀⠀ ⠀⢸  ]],
-- [[⠀⠉⠉⠉⠉⠉⠉⠉  ⠀⠉⠉⠉⠉⠉⠉⠉⠀ ⠀⠉⠉⠉⠉⠉⠉⠉   ⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠈⠉⠉⠉⠉⠉⠉  ]],

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
