return {
  { -- monokai-pro
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        transparent_background = false,
        -- background_clear = {
        --   "nvim-tree", -- Прозрачный фон для nvim-tree
        -- },
      })
    end,
  },

  -- catppuccin
  { "catppuccin/nvim" },

  { -- sonokai
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_transparent_background = 1 -- или 2
    end,
  },

  -- gruvbox
  { 'ellisonleao/gruvbox.nvim' },

  -- nightfox 
  { 'EdenEast/nightfox.nvim' },

  -- tokyonight
  { 'folke/tokyonight.nvim' },

  -- kanagawa
  { 'rebelot/kanagawa.nvim' },

  -- onedark
  { 'navarasu/onedark.nvim' },

  -- everforest
  { 'sainnhe/everforest' },

  -- rose-pine
  { 'rose-pine/neovim' },

  -- -- oxocarbon
  -- { 'nyoom-engineering/oxocarbon.nvim' },

  -- nord
  { 'shaunsingh/nord.nvim' },

  -- dracula
  { 'Mofiqul/dracula.nvim' },

  -- doom-one
  { 'NTBBloodbath/doom-one.nvim' },
} 
