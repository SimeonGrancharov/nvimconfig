-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- fuzzy-finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    branch = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' } },
  }

  -- theme
  -- use { "catppuccin/nvim", as = "catppuccin" }
  use { "ellisonleao/gruvbox.nvim" }
  -- highlighting
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')


  -- unuseful stuff at all
  use 'nvim-lua/plenary.nvim'
  use 'ThePrimeagen/harpoon'

  -- undo history
  use 'mbbill/undotree'

  -- git stuff
  use 'tpope/vim-fugitive'

  -- colors highlighting
  use 'norcalli/nvim-colorizer.lua'

  -- the lsp stuff
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }

  -- Autocompletion
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'L3MON4D3/LuaSnip' }

  -- additional lsp configs
  -- use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- formatting on save
  -- use 'elentok/format-on-save.nvim'
  use 'stevearc/conform.nvim'

  -- pretty nice status line for nvim
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- smooooth operatooooor (scrolling)
  use 'karb94/neoscroll.nvim'

  -- tmux navigation
  use { "alexghergh/nvim-tmux-navigation" }

  -- sync the vim statusline with tmux
  use 'vimpostor/vim-tpipeline'

  -- vim surrounds
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- some wild commenting
  use 'terrortylor/nvim-comment'

  -- we have to have some kind of file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  use {
    'nvim-tree/nvim-web-devicons', -- optional
  }

  --autoclosing
  use("windwp/nvim-autopairs")                                 -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git hunks
  use('lewis6991/gitsigns.nvim')
  -- very useful popup with all problems
  use {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  }
  -- some tuned UI plugin
  use { 'stevearc/dressing.nvim' }

  use({
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  })

  use { 'folke/noice.nvim'}

  use {
    "j-hui/fidget.nvim",
    tag = "legacy", -- use "legacy" if you want the stable release
  }
end)
