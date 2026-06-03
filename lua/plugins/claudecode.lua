-- Neovim (terminal) can't read the monitor's pixel height, so use the row
-- count as a proxy: a portrait monitor reports far more rows than the laptop.
-- Tall screen  -> vertical split (side panel), editor keeps full height.
-- Short screen -> horizontal split (bottom panel), the previous behaviour.
local function is_tall_screen()
  return vim.o.lines > 80
end

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
    terminal = is_tall_screen()
        and {
          provider = "snacks",
          snacks_win_opts = {
            position = "right",
            width = 0.4,
            height = 0,
          },
        }
      or {
        provider = "snacks",
        snacks_win_opts = {
          position = "bottom",
          height = 0.4,
          width = 0,
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
