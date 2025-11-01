-- Noice setup for beautiful notifications and UI
require("noice").setup({
  cmdline = {
    enabled = false, -- Disable cmdline popup, use default vim cmdline
  },
  messages = {
    enabled = false, -- Enable messages (for notifications)
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use default bottom cmdline for search
    command_palette = false, -- keep cmdline at the bottom (default behavior)
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "background" },
          { find = "Background" },
        },
      },
      opts = { skip = true },
    },
  },
  views = {
    notify = {
      relative = "editor",
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = "auto",
        height = "auto",
      },
    },
  },
})
