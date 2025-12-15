local M = {}

function M.setup()
  -- Diagnostic Signs (gutter icons)
  local signs = {
    Error = "",
    Warn  = "",
    Info  = "",
    Hint  = "",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Global diagnostic config
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      spacing = 2,
    },
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,

    float = {
      border = "rounded",
      focusable = false,
      source = "if_many",
      header = "",
      prefix = "",
    },
  })

  -- Rose-Pine Moon colors
  local colors = {
    bg    = "#2a273f", -- surface
    err   = "#eb6f92", -- love
    warn  = "#f6c177", -- gold
    info  = "#9ccfd8", -- foam
    hint  = "#c4a7e7", -- iris
    border = "#393552", -- overlay
  }

  -- Diagnostic text
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.err })
  vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = colors.warn })
  vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = colors.info })
  vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = colors.hint })

  -- Virtual text colors
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.err })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = colors.warn })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = colors.info })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = colors.hint })

  -- Floating popup styling
  vim.api.nvim_set_hl(0, "NormalFloat",  { bg = colors.bg })
  vim.api.nvim_set_hl(0, "FloatBorder",  { bg = colors.bg, fg = colors.border })
  vim.api.nvim_set_hl(0, "FloatTitle",   { bg = colors.bg, fg = colors.err, bold = true })
end

return M
