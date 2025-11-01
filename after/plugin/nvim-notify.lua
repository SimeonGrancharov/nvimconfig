-- Configure nvim-notify
local notify = require("notify")

notify.setup({
  background_colour = "#000000",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 5000,
  top_down = true
})

-- Filter out background color warnings
local banned_messages = { "background" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg and msg:match(banned) then
      return
    end
  end
  notify(msg, ...)
end
