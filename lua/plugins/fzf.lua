return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>ff', function() require('fzf-lua').files() end, desc = "Find files" },
    { '<leader>fg', function() require('fzf-lua').git_files() end, desc = "Find git files" },
    { '<leader>fs', function() require('fzf-lua').grep() end, desc = "Grep search" },
    { '<ESC>', function() require('fzf-lua').buffers() end, desc = "Switch buffers" },
  },
  config = function()
    local actions = require('fzf-lua.actions')

    -- Set highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = "#4DD4FF", bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = "#FF5370", bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { fg = "#3D8BFF", bold = true, bg = "none" })
        vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = "#FF5370", bold = true, bg = "none" })
      end,
    })

    -- Apply immediately if colorscheme is already loaded
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = "#4DD4FF", bold = true, bg = "none" })
      vim.api.nvim_set_hl(0, "FzfLuaTitle", { fg = "#FF5370", bold = true, bg = "none" })
      vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { fg = "#3D8BFF", bold = true, bg = "none" })
      vim.api.nvim_set_hl(0, "FzfLuaPreviewTitle", { fg = "#FF5370", bold = true, bg = "none" })
    end)

    require('fzf-lua').setup({
      winopts = {
        height = 0.85,
        width = 0.85,
        row = 0.5,
        col = 0.5,
        border = "rounded",
        preview = {
          layout = "flex",
        },
      },
      fzf_opts = {
        ['--layout'] = 'default',
        ['--info'] = 'inline',
        ['--padding'] = '1,2,1,2',
      },
      keymap = {
        builtin = {
          ["<Esc>"] = "hide",
          ["<C-x>"] = "file-split",
          ["<C-v>"] = "file-vsplit",
        },
        fzf = {
          ["ctrl-j"] = "down",
          ["ctrl-k"] = "up",
          ["esc"] = "abort",
        },
      },
      actions = {
        files = {
          ["default"] = actions.file_edit,
          ["ctrl-x"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
        },
      },
      files = {
        prompt = "Files❯ ",
        git_icons = true,
        file_icons = true,
        color_icons = true,
        winopts = {
          preview = {
            layout = "horizontal",
            horizontal = "right:50%",
          },
        },
      },
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep❯ ",
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,
        color_icons = true,
      },
      git = {
        files = {
          prompt = "GitFiles❯ ",
        },
      },
    })
  end,
}
