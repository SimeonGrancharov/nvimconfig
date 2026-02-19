return {
  "SimeonGrancharov/claude-cost.nvim",
  branch = "use-session-key",
  config = function()
    require("claude-cost").setup()
  end,
}
