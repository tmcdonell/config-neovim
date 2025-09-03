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
vim.opt.clipboard = 'unnamedplus'
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
              if data[1] ~= "" then
                if data[1] == "#ffffff" then
                  vim.opt.background = 'light'
                else
                  vim.opt.background = 'dark'
                end
              end
            end
          })
      end
    })
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
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
vim.keymap.set('n', '<Leader>tu', require('telescope').extensions.undo.undo, {})
vim.keymap.set('n', '<Leader>tf', require('telescope').extensions.file_browser.file_browser, {})

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

vim.keymap.set('n', '-', function() vim.cmd('Oil') end)

local dap = require("dap")
dap.adapters.gdb =
  { type = "executable"
  , command = "gdb"
  , args = { "--interpreter=dap", "--eval-command", "set pretty print on" }
  }
dap.configurations.c =
  { { name = "Launch"
    , type = "gdb"
    , request = "launch"
    , program = function()
        local path = vim.fn.input(
          { prompt = 'Path to executable: '
          , default = vim.fn.getcwd() .. '/'
          , completion = 'file'
        })
        return (path and path ~= "") and path or dap.ABORT
      end
    , cwd = "${workspaceFolder}"
    , stopAtBeginningOfMainSubprogram = true
    }
  , { name = "Select and attach to process"
    , type = "gdb"
    , request = "attach"
    , program = function()
        local path = vim.fn.input(
          { prompt = 'Path to executable: '
          , default = vim.fn.getcwd() .. '/'
          , completion = 'file'
        })
        return (path and path ~= "") and path or dap.ABORT
      end
    , pid = function()
        local name = vim.fn.input('Executable name (filter): ')
        return require("dap.utils").pick_process({ filter = name })
      end
    , cwd = '${workspaceFolder}'
    }
  , { name = 'Attach to gdbserver :1234'
    , type = 'gdb'
    , request = 'attach'
    , target = 'localhost:1234'
    , program = function()
        local path = vim.fn.input(
          { prompt = 'Path to executable: '
          , default = vim.fn.getcwd() .. '/'
          , completion = 'file'
        })
        return (path and path ~= "") and path or dap.ABORT
      end
    , cwd = '${workspaceFolder}'
    }
  }
dap.configurations.cpp = dap.configurations.c

local dapui = require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

-- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
--   require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
--   require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)

