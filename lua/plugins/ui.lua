return {
  { 'RRethy/nvim-base16'
  },

  { 'tpope/vim-vinegar'
  },

  { 'nvim-lualine/lualine.nvim'
  , config = function()
      require('lualine').setup
        { options = { icons_enabled = false }
        , tabline = { lualine_a = { 'buffers' } }
        , sections =
          { lualine_c = { { 'filename', path = 1 } }
          , lualine_x = { 'encoding', 'filetype' }
          }
        }
    end
  },

  -- { 'goolord/alpha-nvim'
  -- , event = VimEnter
  -- , dependencies = { 'nvim-tree/nvim-web-devicons' }
  -- , config = function()
  --     require('alpha').setup(require('alpha.themes.dashboard').config)
  --   end
  -- }
}
