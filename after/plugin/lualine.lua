require('lualine').setup({
  options = {
    theme = 'everforest'
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
