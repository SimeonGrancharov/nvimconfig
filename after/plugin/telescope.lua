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

telescope.setup({
  pickers = {
    find_files = {
      mappings = picker_mappings
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
