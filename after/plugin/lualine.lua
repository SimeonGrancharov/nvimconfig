require('lualine').setup({
  options = {
    theme = 'gruvbox-material'
  },
  sections = {
    lualine_y = {
      {
        'datetime',
        style = '%H:%M'
      }
    }
  }
})
