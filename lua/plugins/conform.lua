return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        css = { "oxfmt", "prettier", stop_after_first = true },
        scss = { "oxfmt", "prettier", stop_after_first = true },
        sass = { "oxfmt", "prettier", stop_after_first = true },
        javascript = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
        json = { "oxfmt", "prettier", stop_after_first = true },
        jsonc = { "oxfmt" },
        astro = { "oxfmt" },
        markdown = { "oxfmt" },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
