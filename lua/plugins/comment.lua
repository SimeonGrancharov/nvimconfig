return {
  "terrortylor/nvim-comment",
  config = function()
    require('nvim_comment').setup({
      comment_empty = false,
      create_mappings = false,
    })
  end,
  keys = {
    { '<leader>c ', ':CommentToggle<CR>', mode = 'n', desc = "Toggle comment" },
    { '<leader>c ', ':CommentToggle<CR>', mode = 'v', desc = "Toggle comment" },
  },
}
