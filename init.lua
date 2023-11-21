-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.mousefocus = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 5
vim.opt.spell = true
vim.opt.spelllang = 'en_au'
vim.opt.splitright = true
-- vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamed'
vim.opt.formatoptions:remove { 't' }

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as <Leader> key
vim.g.mapleader = ','

-- Clear search highlighting
vim.keymap.set('n', '<CR>', vim.cmd.nohlsearch)

-- Window manipulation
vim.keymap.set('n', '<Leader>c', vim.cmd.close)
vim.keymap.set('n', '<Leader>q', vim.cmd.bdelete)
vim.keymap.set('n', '<Leader>s', vim.cmd.split)
vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit)

vim.keymap.set('n', '<Leader>]', vim.cmd.bnext)
vim.keymap.set('n', '<Leader>[', vim.cmd.bprev)

vim.keymap.set('n', '<Leader>wl', '<C-w><C-l>')
vim.keymap.set('n', '<Leader>wh', '<C-w><C-h>')
vim.keymap.set('n', '<Leader>wk', '<C-w><C-k>')
vim.keymap.set('n', '<Leader>wj', '<C-w><C-j>')
vim.keymap.set('n', '<Leader>w=', '<C-w>=')

-- ========================================================================== --
-- ==                             AUTOCOMMANDS                             == --
-- ========================================================================== --

vim.api.nvim_create_autocmd('BufRead',
  { desc = 'Restore last known cursor position when opening file'
  , pattern = '*'
  , callback = function()
      vim.api.nvim_create_autocmd('FileType',
        { pattern = '<buffer>'
        , once = true
        , command = 'if &ft !~# "commit|rebase" && line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe \'normal! g`"\' | endif'
        })
    end
  })

vim.api.nvim_create_autocmd('ColorScheme',
  { desc = "Clear cell background colour to significantly improve rendering speed"
  , callback = function()
      vim.cmd.highlight('Normal', 'guibg=clear')
      vim.cmd.highlight('NormalNC', 'guibg=clear')
    end
  })

vim.api.nvim_create_autocmd('OptionSet',
  { desc = 'Set appropriate colour scheme for light/dark background'
  , pattern = 'background'
  , nested = true -- also run ColorScheme autocmd
  , callback = function()
      if vim.opt.background:get() == 'light' then
        vim.cmd.colorscheme('base16-tomorrow')
      else
        vim.cmd.colorscheme('base16-tomorrow-night')
      end
    end
  })

if vim.env.TERM == 'xterm-kitty' then
  vim.api.nvim_create_autocmd({'VimEnter', 'FocusGained'},
    { desc = "Check terminal background colour and update colour scheme"
    , callback = function()
        -- requires allow_remote_control and listen_on options in kitty.conf to be set
        vim.fn.jobstart('kitty @ get-colors | grep "^background" | tr -s " " | cut -d " " -f2',
          { stdout_buffered = true
          , on_stdout = function(jobid, data, event)
              if data[1] == "#ffffff" then
                vim.opt.background = 'light'
              else
                vim.opt.background = 'dark'
              end
            end
          })
      end
    })
else
  vim.opt.background = 'light'
end

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

-- Plugin manager
-- Any lua file in ~/.config/nvim/lua/plugins/*.lua will be loaded
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)
require('lazy').setup('plugins')

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<Leader>tt', telescope.find_files, {})
-- vim.keymap.set('n', '<Leader>gg', telescope.git_files, {})
vim.keymap.set('n', '<Leader>tg', telescope.live_grep, {})
vim.keymap.set('n', '<Leader>tb', telescope.buffers, {})
vim.keymap.set('n', '<Leader>th', telescope.help_tags, {})
vim.keymap.set('n', '<Leader>tr', telescope.oldfiles, {})
-- vim.keymap.set('n', '<Leader>tc', telescope.colorscheme, {})

local lazygit = require('toggleterm.terminal').Terminal:new(
  { cmd = 'lazygit'
  , dir = 'git_dir'
  , direction = 'float'
  , hidden = true
  , on_open = function() end
  })
vim.keymap.set('n', '<Leader>xg', function() lazygit:toggle() end, { silent = true })

local process_viewer = require('toggleterm.terminal').Terminal:new(
  { cmd = 'btm'
  , direction = 'float'
  , hidden = true
  , on_open = function() end
  })
vim.keymap.set('n', '<Leader>xp', function() process_viewer:toggle() end, { silent = true })

