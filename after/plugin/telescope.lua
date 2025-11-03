-- TELESCOPE SETUP DISABLED - USING FZF-LUA INSTEAD
do return end

local builtin = require('telescope.builtin')
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')

local keymap = vim.keymap

-- More gentle way for navigation through results
local picker_mappings = {
  i = {
    ['<C-k>'] = telescope_actions.move_selection_previous,
    ['<C-j>'] = telescope_actions.move_selection_next,
    ['<ESC>'] = 'close'
  }
}

keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.git_files, {})
keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

keymap.set('n', '<ESC>', builtin.buffers, {})

-- Custom border colors for telescope (BMW M inspired)
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#4DD4FF", bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#4DD4FF", bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#3D8BFF", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#FF5370", bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#4DD4FF", bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#3D8BFF", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#FF5370", bold = true })

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules" },
    layout_strategy = 'bottom_pane',
    layout_config = {
      bottom_pane = {
        height = 0.5,
        prompt_position = "bottom",
      },
    },
    border = true,
    borderchars = {
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  },
  pickers = {
    git_files = {
      mappings = picker_mappings
    },
    find_files = {
      mappings = picker_mappings,
      hidden = true
    },
    grep_string = {
      mappings = picker_mappings
    },
    buffers = {
      initial_mode = 'normal',
      sort_lastused = true,
    }
  }
})


-- vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
