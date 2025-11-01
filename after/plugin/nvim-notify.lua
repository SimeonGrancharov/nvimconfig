-- Configure nvim-notify
local notify = require("notify")

notify.setup({
  background_colour = "Normal",  -- Use normal background instead of black
  fps = 60,  -- Smoother animations
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",  -- Default rendering with title on top
  stages = "static",  -- No animations to avoid flashing
  timeout = 5000,
  top_down = true
})

