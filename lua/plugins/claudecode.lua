-- Terminal Neovim only sees the character grid (lines x columns), never the
-- monitor's pixels. Detect orientation from the grid's aspect ratio instead:
-- cells are ~2:1 (tall:wide), so a landscape laptop reports columns/lines ~4
-- while a portrait monitor reports ~1. This is font-size independent.
-- Portrait (vertical monitor) -> bottom panel; lots of height to spare.
-- Landscape (laptop)          -> right side panel; lots of width to spare.
local function is_portrait_screen()
  return vim.o.columns < vim.o.lines * 2.2
end

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
    terminal = is_portrait_screen()
        and {
          provider = "snacks",
          snacks_win_opts = {
            position = "bottom",
            height = 0.4,
            width = 0,
          },
        }
      or {
        provider = "snacks",
        snacks_win_opts = {
          position = "right",
          width = 0.4,
          height = 0,
        },
      },
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
