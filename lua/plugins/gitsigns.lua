return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
  },
  keys = {
    -- Navigation
    { ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() require('gitsigns').next_hunk() end)
      return '<Ignore>'
    end, expr = true, desc = "Next hunk" },
    { '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() require('gitsigns').prev_hunk() end)
      return '<Ignore>'
    end, expr = true, desc = "Previous hunk" },

    -- Actions
    { '<leader>hs', ':Gitsigns stage_hunk<CR>', mode = { 'n', 'v' }, desc = "Stage hunk" },
    { '<leader>hr', ':Gitsigns reset_hunk<CR>', mode = { 'n', 'v' }, desc = "Reset hunk" },
    { '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', desc = "Stage buffer" },
    { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = "Undo stage hunk" },
    { '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', desc = "Reset buffer" },
    { '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', desc = "Preview hunk" },
    { '<leader>hb', '<cmd>Gitsigns blame_line<CR>', desc = "Blame line" },
    { '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>', desc = "Toggle blame" },
    { '<leader>hd', '<cmd>Gitsigns diffthis<CR>', desc = "Diff this" },
    { '<leader>hD', function() require('gitsigns').diffthis('~') end, desc = "Diff this ~" },
    { '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', desc = "Toggle deleted" },

    -- Text object
    { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = { 'o', 'x' }, desc = "Select hunk" },
  },
}
