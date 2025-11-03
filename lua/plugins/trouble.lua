return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Set highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })
      end,
    })

    -- Apply immediately if colorscheme is already loaded
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })
    end)
  end,
  keys = {
    { "<leader>xx", function() require("trouble").toggle("preview_float") end },
    { "<leader>xw", function() require("trouble").toggle("loclist") end },
    { "<leader>xd", function() require("trouble").toggle("lsp") end },
    { "<leader>xq", function() require("trouble").toggle("quickfix") end },
    { "<leader>xl", function() require("trouble").toggle("loclist") end },
    { "gR", function() require("trouble").toggle("lsp_references") end },
  },
}
