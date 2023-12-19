return {
  { 'nvim-treesitter/nvim-treesitter'
  , build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  , config = function()
      require('nvim-treesitter.configs').setup
        { auto_install = true
        , highlight = { enable = true }
        }
    end
  },

  { 'nvim-telescope/telescope.nvim'
  , dependencies =
      { 'nvim-telescope/telescope-fzf-native.nvim'
      , 'nvim-tree/nvim-web-devicons'
      , 'nvim-lua/plenary.nvim'
      }
  , config = function()
      require('telescope').setup()
      require('telescope').load_extension('fzf')
    end
  },

  { 'nvim-telescope/telescope-file-browser.nvim'
  , dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { 'nvim-telescope/telescope-fzf-native.nvim'
  , build = 'make'
  , lazy = false
  },

  { 'kylechui/nvim-surround'
  , event = 'VeryLazy'
  , config = function()
      require('nvim-surround').setup()
    end
  },

  { 'tpope/vim-commentary'
  },

  { 'junegunn/vim-easy-align'
  , config = function()
      vim.keymap.set('v',        '<Enter>',    '<Plug>(EasyAlign)')
      vim.keymap.set('n',        'ga',         '<Plug>(EasyAlign)')
      vim.keymap.set({'n', 'v'}, '<Leader>at', ':EasyAlign /\\(::\\|=>\\|->\\)/<CR>') -- align (Haskell) type signatures
    end
  },

  { 'lewis6991/gitsigns.nvim'
  , config = function()
      require('gitsigns').setup
        { on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            -- Actions
            map('n', '<Leader>hs', gs.stage_hunk)
            map('n', '<Leader>hr', gs.reset_hunk)
            map('v', '<Leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('v', '<Leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('n', '<Leader>hS', gs.stage_buffer)
            map('n', '<Leader>hu', gs.undo_stage_hunk)
            map('n', '<Leader>hR', gs.reset_buffer)
            map('n', '<Leader>hp', gs.preview_hunk)
            map('n', '<Leader>hb', function() gs.blame_line{full=true} end)
            -- map('n', '<Leader>tb', gs.toggle_current_line_blame)
            map('n', '<Leader>hd', gs.diffthis)
            map('n', '<Leader>hD', function() gs.diffthis('~') end)
            -- map('n', '<Leader>td', gs.toggle_deleted)

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end
        }
    end
  },

  { 'neovim/nvim-lspconfig'
  , config = function()
      require('lspconfig').hls.setup
        { autostart = false
        , filetypes = { 'haskell', 'lhaskell', 'cabal' }
        }

      require('lspconfig').sourcekit.setup
        { autostart = true
        -- , filetypes = { 'c', 'cpp', 'swift' }
        }

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border = 'rounded' })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, { border = 'rounded' })

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d',        vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d',        vim.diagnostic.goto_next)
      vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          -- vim.keymap.set('n', '<Leader>f', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
        end,
      })
    end
  },

  { 'akinsho/toggleterm.nvim'
  , config = function()
      require('toggleterm').setup
        { open_mapping = [[<C-\>]]
        , size = function(term)
            if term.direction == 'horizontal' then
              return 12
            elseif term.direction == 'vertical' then
              return vim.fn.min({100, vim.opt.columns:get() * 0.5})
            end
          end
        , on_open = function(term)
            vim.opt_local.spell = false
            vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = term.bufnr })
          end
        }
    end
  },
}

