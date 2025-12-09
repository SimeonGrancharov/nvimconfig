-- smart_grep using explicit input prompt (no function-in-options)
local function smart_grep()
  -- prompt the user ourselves so we can parse the input reliably
  local ok, query = pcall(vim.fn.input, "Rg❯ ")
  if not ok then
    vim.notify("Input aborted", vim.log.levels.WARN)
    return
  end
  if not query or query:match("^%s*$") then
    return
  end

  -- trim leading/trailing whitespace
  query = query:gsub("^%s+", ""):gsub("%s+$", "")

  local search_text = query
  local opts = { cwd = vim.fn.getcwd() } -- default cwd

  -- if starts with @ then search from project root
  if search_text:match("^@%s*") then
    search_text = search_text:gsub("^@%s*", "")

    -- find git root (preferred) or fallback to cwd
    local git_root = nil
    local ok, out = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
    if ok and out and type(out) == "table" and out[1] and out[1] ~= "" then
      git_root = out[1]
    end
    if git_root and vim.loop.fs_stat(git_root) then
      opts.cwd = git_root
    else
      -- fallback: walk up and look for .git or .gitignore
      local function find_up(start)
        local dir = vim.fn.fnamemodify(start, ":p")
        while dir and dir ~= "/" do
          if vim.loop.fs_stat(vim.fs.joinpath(dir, ".git")) or vim.loop.fs_stat(vim.fs.joinpath(dir, ".gitignore")) then
            return dir
          end
          local parent = vim.fn.fnamemodify(dir, ":h")
          if parent == dir then break end
          dir = parent
        end
        return nil
      end
      local root = find_up(vim.fn.getcwd())
      if root then opts.cwd = root end
    end
  end

  -- final safety: ensure search_text is non-empty
  if not search_text or search_text:match("^%s*$") then
    vim.notify("Empty search (after @ prefix). Aborting.", vim.log.levels.WARN)
    return
  end

  -- call fzf-lua grep with a proper string + cwd
  require("fzf-lua").grep(vim.tbl_extend("force", {
    search = search_text,
  }, opts))
end

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>ff', function() require('fzf-lua').files({ cwd = vim.fn.getcwd() }) end, desc = "Find files" },
    { '<leader>fg', function() require('fzf-lua').git_files({ cwd = vim.fn.getcwd() }) end, desc = "Find git files" },
    { '<leader>fs', function() smart_grep() end, desc = "Grep search" },
    { '<ESC>', function() require('fzf-lua').buffers() end, desc = "Switch buffers" },
  },

  config = function()
    local actions = require('fzf-lua.actions')

    -- Set highlights on colorscheme load
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

    -- Apply highlights immediately
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
