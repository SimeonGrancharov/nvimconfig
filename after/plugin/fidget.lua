require("fidget").setup {
  -- Example options:
  text = {
    spinner = "dots",     -- animation style
  },
  align = {
    bottom = true,     -- align at bottom
    right = true,      -- align at right
  },
  window = {
    relative = "editor",     -- show relative to entire editor
  },
  fmt = {
    stack_upwards = false,     -- newer tasks near bottom
  },
}
