local trouble = require("trouble")

trouble.setup({
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
})

-- Lua
vim.keymap.set("n", "<leader>xx",
  function() trouble.toggle("preview_float") end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("lsp") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end)
