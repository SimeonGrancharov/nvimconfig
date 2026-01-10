return {
  -- Using local development version (symlinked)
  dir = "~/.local/share/nvim/site/pack/plugins/start/react-compiler-marker",

  -- Only load for React/JS/TS files
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },

  config = function()
    require("react-compiler-marker").setup({
      -- Force using the bundled/symlinked server (with our fixes)
      server = {
        path = vim.fn.expand("~/.local/share/nvim/site/pack/plugins/start/react-compiler-marker/server/server.bundle.js"),
      },

      -- Emoji markers
      emojis = {
        success = "✨",
        error = "🚫",
      },

      -- Auto-start the LSP server when opening React files
      autostart = true,
    })
  end,
}
