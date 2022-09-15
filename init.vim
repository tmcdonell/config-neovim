
"-- Plugins --------------------------------------------------------------------

" Use Plug (junegunn/vim-plug) to manage plugins. Due to the structure of that
" git repository it needs to be stored directly in autoload, not the bundle
" directory. It can, however, update itself.
call plug#begin('~/.config/nvim/plug')

" A minimalist vim plugin manager (disabled: cannot bootstrap)
" Plug 'junegunn/vim-plug'

" A collection of language packs for vim
Plug 'sheerun/vim-polyglot'

" A plugin for asynchronous :make using Neovim's job-control functionality
Plug 'neomake/neomake'

" tmux status line generator
" Plug 'edkolev/tmuxline.vim'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" teach a vim to fish
Plug 'dag/vim-fish'

" Fast vim CtrlP matcher based on python
" Plug 'FelikZ/ctrlp-py-matcher'

" Configurable, flexible, intuitive text aligning
Plug 'godlygeek/tabular'

" Improved incremental (and fuzzy) searching for vim
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" Wrapper of some neovim's :terminal functions
Plug 'kassio/neoterm'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'ctrlpvim/ctrlp.vim'

" Delete buffers and close files in Vim without messing up your layout.
Plug 'moll/vim-bbye'

" Visualise the vim undo tree
Plug 'sjl/gundo.vim'
" Plug 'mbbill/undotree'

" Comment stuff out
Plug 'tpope/vim-commentary'

" A Git wrapper so awesome, it should be illegal
" Plug 'tpope/vim-fugitive'

" Show git diff in the gutter
" Plug 'airblade/vim-gitgutter'

" Complementary pairs of mappings
Plug 'tpope/vim-unimpaired'

" Combine with NETRW to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" vimscripts for haskell development
Plug 'neovimhaskell/haskell-vim'
" Plug 'dag/vim2hs'   " syntax highlighting is slow as all fuck

" Happy Haskell programming on Vim, powered by ghc-mod
" Plug 'eagletmt/ghcmod-vim'
" Plug 'eagletmt/neco-ghc'
" Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Intero for neovim
" Plug 'parsonsmatt/intero-neovim'

" Quickfix error feedback via ghcid
" Plug 'cloudhead/neovim-ghcid'

" The core of an IDE for Haskell
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'mattn/vim-lsp-settings'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Dark powered asynchronous completion framework for neovim (requires python3)
" Plug 'Shougo/deoplete.nvim'

" Syntax checking hacks for vim (requires +lua)
" Plug 'scrooloose/syntastic'

" Automatic resizing of Vim windows to the golden ratio
" Plug 'roman/golden-ratio'

" LLVM syntax
" Plug 'Superbil/llvm.vim'

" A vim plugin for vim plugins
" Plug 'tpope/vim-scriptease'

" Highlight trailing whitespace
" Plug 'bronson/vim-trailing-whitespace'
Plug 'ntpeters/vim-better-whitespace'

" Man page viewer
" Plug 'nhooyr/neoman.vim'

" Speed up vim by updating folds only when called for
" Plug 'Konfekt/FastFold'

" The fancy start screen for Vim
Plug 'mhinz/vim-startify'

" Add quotes/parenthesis
Plug 'tpope/vim-surround'

" Repeat supported plugin maps with "."
Plug 'tpope/vim-repeat'

" " Live preview markdown files
" function! CargoBuild(info)
"   if a:info.status != 'unchanged' || a:info.force
"     !env C_INCLUDE_PATH=/usr/local/homebrew/opt/openssl/include cargo build --release
"     UpdateRemotePlugins
"   endif
" endfunction

" Plug 'euclio/vim-markdown-composer', { 'do': function('CargoBuild') }
  " NOTE: OpenSSL installed via Homebrew is not linked to the system paths by
  " default, so to do the initial build you may need something like:
  "
  " > env C_INCLUDE_PATH=/usr/local/homebrew/opt/openssl/include cargo build --release
  "

" Markdown mode (requires gadlygeek/tabular)
Plug 'plasticboy/vim-markdown'

" The missing motion for vim
" Plug 'justinmk/vim-sneak'

" Fuzzy command-line finder
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'ibhagwan/fzf-lua'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Support for using neovim as a remote process
Plug 'mhinz/neovim-remote'

" Visually display indent level of code
" Plug 'nathanaelkane/vim-indent-guides'

" OpenCL syntax
" Plug 'brgmnn/vim-opencl'

" org-mode for vim
" Plug 'jceb/vim-orgmode'
" Plug 'mattn/calendar-vim'
" Plug 'inkarkat/vim-SyntaxRange'
" Plug 'tpope/vim-speeddating'
" Plug 'vim-scripts/utl.vim'

call plug#end()


"-- Leader Keys ----------------------------------------------------------------

" This must come before any bindings to <Leader>
let mapleader      = ","

" This must come before any bindings to <LocalLeader>
let maplocalleader = ";"


"-- nvimrc ---------------------------------------------------------------------

" Location of nvimrc
let g:nvimrc = "~/.config/nvim/init.vim"

" Edit nvimrc
nnoremap <Leader>m :exec ":e " . g:nvimrc<CR>

" Source the nvimrc file after saving it
augroup nvimrc
  autocmd!
  autocmd BufWritePost nvimrc exec "source " . g:nvimrc | AirlineRefresh
augroup END


" -- Highlighting --------------------------------------------------------------

" type of file; triggers the FileType event when set (local to buffer)
filetype plugin indent on

" name of syntax highlighting used (local to buffer)
syntax on

" highlight all matches for the last used search pattern
set hlsearch

" highlight the screen line of the cursor (local to window)
" set cursorline

" Maximum column in which to search for syntax items
set synmaxcol=400

" spell highlight spelling mistakes, list of accepted languages
set spell
set spelllang=en_au


" -- Colours -------------------------------------------------------------------

" Enable 24-bit colour mode
if !$TERM_PROGRAM =~ "Apple_Terminal"
  set termguicolors
endif

" The background colour brightness
set background=light
colorscheme chaos

" " Matches iTerm2 colours (???)
" let g:terminal_color_0  = '#808080'
" let g:terminal_color_1  = '#da4f56'
" let g:terminal_color_2  = '#78af54'
" let g:terminal_color_3  = '#fa8e43'
" let g:terminal_color_4  = '#6197d4'
" let g:terminal_color_5  = '#cf9af8'
" let g:terminal_color_6  = '#50c283'
" let g:terminal_color_7  = '#d6d6c6'
" let g:terminal_color_8  = '#bdbdbd'
" let g:terminal_color_9  = '#fc767c'
" let g:terminal_color_10 = '#95da72'
" let g:terminal_color_11 = '#fecc7a'
" let g:terminal_color_12 = '#8ebaf6'
" let g:terminal_color_13 = '#f7bdff'
" let g:terminal_color_14 = '#67e39f'
" let g:terminal_color_15 = '#efeee0'


"-- Airline --------------------------------------------------------------------

let g:airline_powerline_fonts                   = 1
let g:airline_theme                             = 'tomorrow'
let g:airline_skip_empty_sections               = 1
let g:airline_highlighting_cache                = 1
let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#fnamecollapse  = 0
let g:airline#extensions#tabline#formatter      = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod       = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tmuxline#enabled       = 0
let g:airline#extensions#scrollbar#enabled      = 0


" -- Buffers & Entering text ---------------------------------------------------

" Jump to the last known cursor position
autocmd BufReadPost *
    \ if line("'\'") > 0 && line("'\'") <= line("$")
    \   | execute "normal g'\"" |
    \ endif

" (buffer id) + Leader = jump to buffer
let buffer_id = 1
while buffer_id <= 99
  execute "nnoremap " . buffer_id . "<Leader> :" . buffer_id . "b\<CR>"
  let buffer_id += 1
endwhile

" show cursor position below each window
set ruler

" don't show the current mode in the status line, as airline does that for us
set noshowmode

" show (partial) command keys in the status line
set showcmd

" Always show the status line
set laststatus=2

" Don't ring the bell for error messages
set noerrorbells

" number of screen lines to show around the cursor
set scrolloff=5

" minimal number of lines to scroll at a time
set scrolljump=5

" minimal number of columns to scroll horizontally
set sidescroll=1

" minimal number of columns to show around the cursor
set sidescrolloff=5

" don't wrap long lines
set nowrap

" but if we do wrap, don't just break at the last character that fits on screen
set linebreak

" don't redraw while executing macros
set lazyredraw

" show the (relative) line number for each line
set number
set relativenumber

" Disable folding
" set nofoldenable

" Start with all folds open
set foldlevelstart=99

" ignore case when using a search pattern
set ignorecase

" override 'ignorecase' when pattern has upper case characters
set smartcase

" line length above which to break a line
set textwidth=80

" specifies what <BS>, CTRL-W, etc. can do in Insert mode
set backspace=indent,eol,start

" don't use two spaces after '.' when joining a line
set nojoinspaces

" don't unload buffers when switching away
" set hidden

" split new windows to the right or below of the current one
set splitright
set nosplitbelow

" list of flags specifying which commands to wrap to another line
set whichwrap=b,s,h,l,<,>,~,[,]

" number of spaces used for each step of (auto)indent
set shiftwidth=2

" a <Tab> in an indent inserts 'shiftwidth' spaces
set smarttab

" number of spaces that a <Tab> in a file counts for
set tabstop=8

" number of spaces to insert for a <Tab>
set softtabstop=2

" expand <Tab> to spaces in Insert mode
set expandtab

" automatically set the indent of a new line
set autoindent

" no backups after overwriting a file
set nobackup

" In insert mode, <C-u> deletes the text typed on the current line, and <C-w>
" deletes the word before the cursor. This mapping begins a new change, so that
" the deletion can be undone.
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>


" -- Mouse ---------------------------------------------------------------------

" always use the mouse, follow focus
set mouse=a
set mousefocus


" -- Clipboard -----------------------------------------------------------------

" Use the * register like an unnamed clipboard
set clipboard=unnamed


" -- Command line editing & wildcard configuration -----------------------------

" specifies how command line completion works
" set wildmode=list:longest

" command-line completion shows a list of matches
set wildmenu

" ignore boring files and directories
set wildignore=_*/*
set wildignore+=*.exe,.dll
set wildignore+=*.gif,*.jpg,*.png
set wildignore+=*.o,*.hi,*.p_o,*.p_hi,*.pyc
set wildignore+=*.swp
set wildignore+=*.ibc
set wildignore+=*.class,*.jar
set wildignore+=*/.git/*
set wildignore+=*/output/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
" set wildignore+=*/projects/*
set wildignore+=*/icebox/*

" Vim
set wildignore+=*/spell/*
set wildignore+=*/plugged/*

" Haskell
set wildignore+=*/dist/*
set wildignore+=*/.cabal-sandbox/*
set wildignore+=*/.stack-work/*


" -- Windows -------------------------------------------------------------------

" close window
nnoremap <leader>c      <C-w>c

" delete buffer, without closing window
nnoremap <Leader>q      :Bdelete<CR>

" split window, vertically
nnoremap <leader>s      <C-w>s
nnoremap <leader>v      <C-w>v

" moving to windows left/right/up/down
nnoremap <leader>wl     <C-w><C-l>
nnoremap <leader>wh     <C-w><C-h>
nnoremap <leader>wk     <C-w><C-k>
nnoremap <leader>wj     <C-w><C-j>

" distribute windows
nnoremap <leader>w=     <C-w>=


"-- Terminal Mode / neoterm --------------------------------------------

if has('nvim')

  let $EDITOR = 'nvr -l'

  " Open neoterm windows in a vertical split
  " let g:neoterm_position = 'vertical'
  let g:neoterm_default_mod=':vertical'

  " Leader + Esc = exit terminal mode
  tnoremap <Leader><Esc> <C-\><C-n>

  " Ctrl + w + n = create new window with empty buffer
  tnoremap <C-w>n     <C-\><C-n><C-w>n
  tnoremap <C-w><C-n> <C-\><C-n><C-w><C-n>

  " Ctrl + w + s = split window horizontally
  tnoremap <C-w>s     <C-\><C-n><C-w>s
  tnoremap <C-w><C-s> <C-\><C-n><C-w><C-s>

  " Ctrl + w + v = split window vertically
  tnoremap <C-w>v     <C-\><C-n><C-w>v
  tnoremap <C-w><C-v> <C-\><C-n><C-w><C-v>

  " Ctrl + w + p = move cursor to the previous window
  tnoremap <C-w>p     <C-\><C-n><C-w>p
  tnoremap <C-w><C-p> <C-\><C-n><C-w><C-p>

  " Ctrl + w + w = move cursor to window below/right of the current one
  tnoremap <C-w>w     <C-\><C-n><C-w>w
  tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>

  " Ctrl + w + u = move cursor to window above/left of the current one
  nnoremap <C-w>u     <C-w>w
  nnoremap <C-w><C-u> <C-w><C-w>
  tnoremap <C-w>u     <C-\><C-n><C-w>w
  tnoremap <C-w><C-u> <C-\><C-n><C-w><C-w>

  " Ctrl + w + h = move cursor to window on the left
  tnoremap <C-w>h     <C-\><C-n><C-w>h
  tnoremap <C-w><C-h> <C-\><C-n><C-w><C-h>

  " Ctrl + w + j = move cursor to window below
  tnoremap <C-w>j     <C-\><C-n><C-w>j
  tnoremap <C-w><C-j> <C-\><C-n><C-w><C-j>

  " Ctrl + w + k = move cursor to window above
  tnoremap <C-w>k     <C-\><C-n><C-w>k
  tnoremap <C-w><C-k> <C-\><C-n><C-w><C-k>

  " Ctrl + w + l = move cursor to window on the right
  tnoremap <C-w>l     <C-\><C-n><C-w>l
  tnoremap <C-w><C-l> <C-\><C-n><C-w><C-l>

  " Ctrl + w + c = close current window
  tnoremap <C-w>c <C-\><C-n><C-w>c

  augroup Terminal
    autocmd!

    " Always start insert mode when you enter a terminal window
    autocmd BufWinEnter,WinEnter term://* startinsert

    " Always stop insert mode when you leave a terminal window
    autocmd BufLeave term://* stopinsert
  " augroup END

  " augroup neoterm_setup
    " Turn off spell checking in the terminal window
    autocmd TermOpen term://* setlocal nospell

    " Start the terminal in insert mode
    autocmd TermOpen term://* startinsert
  augroup END

endif


" -- GUndo ---------------------------------------------------------------------

let g:gundo_prefer_python3 = 1

" gundo toggle window
nnoremap <F5> :GundoToggle<CR>


"-- undotree -------------------------------------------------------------------

" toggle undo window
" nnoremap <F5> :UndotreeToggle<CR>


"-- Grep -----------------------------------------------------------------------

" Grep word under cursor, same file type
nnoremap <Leader>g
  \ :noautocmd lvim /\<lt><C-R><C-W>\>/gj
  \ **/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
  \ <Bar> lw<CR>

" Grep word under cursor, all files
nnoremap <Leader>G
  \ :noautocmd lvim /\<lt><C-R><C-W>\>/gj
  \ **
  \ <Bar> lw<CR>


"-- Ctrl+P ---------------------------------------------------------------------

" " Leader + t = find file in project
" nnoremap <silent> <Leader>t :CtrlP<CR>

" " Leader + b = find file in open buffers
" nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" " Leader + r = clean file cache
" nnoremap <silent> <Leader>r :CtrlPClearCache<CR>

" let g:ctrlp_root_markers = ['stack*.yaml'] " '*.cabal',
" let g:ctrlp_match_func   = { 'match': 'pymatcher#PyMatch' }
" let g:ctrlp_reuse_window = 'startify'
" let g:ctrlp_switch_buffer = ''
" let g:ctrlp_custom_ignore = {
"   \ 'dir': '\v[\/](.git|.hg|.svn|tests|icebox)$'
"   \ }

"-- FZF ------------------------------------------------------------------------

" if has("nvim")
"   " Escape inside a FZF terminal window should exit the terminal window
"   " rather than going into the terminal's normal mode.
"   autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
" endif

" " Leader + t = find file in project
" " nnoremap <silent> <Leader>t :Files<CR>
" nnoremap <silent> <Leader>t <cmd>lua require('fzf-lua').files()<CR>

" " Leader + b = find file in open buffers
" " nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader>b <cmd>lua require('fzf-lua').buffers()<CR>

" " Jump to the existing window if possible
" let g:fzf_buffers_jump = 0

" " Command to generate tags file
" let g:fzf_tags_command = 'ctags -R'

" " --expect expression for directly executing the command
" let g:fzf_commands_expect = 'alt-enter,ctrl-x'

"-- Telescope ------------------------------------------------------------------

lua <<EOF
require('telescope').setup{}
require('telescope').load_extension('fzf')
EOF

nnoremap <Leader>t <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <Leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

" nnoremap <leader>t <cmd>Telescope find_files<cr>
" nnoremap <leader>b <cmd>Telescope buffers<cr>

"-- Fugitive -------------------------------------------------------------------

" Leader + gd = diff current vs git head
nnoremap <Leader>d :Gdiff<cr>

" Leader + gD = Switch back to current file and closes Fugitive buffer
nnoremap <Leader>D <c-w>h<c-w>c


"-- Easy Align -----------------------------------------------------------------

" vip<Enter> = Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" gaip = Start interactive EasyAlign for a motion/text object
nmap ga      <Plug>(EasyAlign)


"-- Tabular --------------------------------------------------------------------

" Align = or += or &= or /= or == or ==>
nnoremap <Leader>a= :Tabularize /[+&/]\?=\+[>]\?<CR>
vnoremap <Leader>a= :Tabularize /[+&/]\?=\+[>]\?<CR>

" Align -> or <-
nnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>
vnoremap <Leader>a- :Tabularize /-\+>\\|<-\+<CR>


"-- Word manipulation ----------------------------------------------------------

" Leader + r = replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" gw = Swap current word with next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>


" -- Searching -----------------------------------------------------------------

" standard incremental search
map /   <Plug>(incsearch-forward)
map ?   <Plug>(incsearch-backward)
map g/  <Plug>(incsearch-stay)

" fuzzy search
map z/  <Plug>(incsearch-fuzzyspell-/)
map z?  <Plug>(incsearch-fuzzyspell-?)
map zg/ <Plug>(incsearch-fuzzyspell-stay)

" turn off highlighting using <CR>, but not in the quickfix window
nnoremap <CR> :nohlsearch<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix setlocal nospell


"-- Neomake --------------------------------------------------------------------

" Leader + e = open location list
nnoremap <Leader>e :lopen<CR>

" Leader + E = close location list
nnoremap <Leader>E :lclose<CR>

function! s:NeomakeExclude()
  let l:path   = expand('%:p:h')
  let l:ignore = expand('^$HOME/.config/nvim')
  if match(l:path, l:ignore)
    Neomake
  endif
endfunction

augroup neomake
  autocmd!
  autocmd BufWritePost * call s:NeomakeExclude()
augroup END

if !exists('g:nvimrc_neomake')
  " Only source the first time
  let g:nvimrc_neomake = 1

  highlight SpellBad gui=NONE term=NONE
  highlight SpellCap gui=NONE term=NONE
  highlight clear SignColumn

  call neomake#signs#RedefineErrorSign({ 'texthl': 'SpellBad' })
  call neomake#signs#RedefineWarningSign({ 'texthl': 'SpellCap' })
endif

" let g:neomake_haskell_enabled_makers  = ['ghcmod']

" let g:neomake_haskell_ghcmod_maker = {
"     \ 'exe': 'ghc-mod',
"     \ 'args': ['check', "-b\n"],
"     \ 'errorformat':
"       \ '%-Z %#,' .
"       \ '%E%f:%l:%c:Error: %m,' .
"       \ '%W%f:%l:%c:Warning: %m,'.
"       \ '%E%f:%l:%c: Error: %m,' .
"       \ '%W%f:%l:%c: Warning: %m,' .
"       \ '%E%f:%l:%c:%m,' .
"       \ '%m'
"     \ }


"-- VimL -----------------------------------------------------------------------

augroup viml
  autocmd!
  autocmd FileType vim setlocal shiftwidth=2
augroup END


"-- Shell ----------------------------------------------------------------------

" All shell scripts allow POSIX extensions, e.g $(..) instead of `..`
let g:is_posix = 1

augroup bash
  autocmd!
  autocmd FileType sh setlocal shiftwidth=2
augroup END


"-- YAML -----------------------------------------------------------------------

augroup YAML
  autocmd!
  autocmd FileType yaml setlocal shiftwidth=2
augroup END


"-- LLVM -----------------------------------------------------------------------

augroup LLVM
  autocmd!
  autocmd BufNewFile,BufRead *.ll set filetype=llvm
  autocmd BufNewFile,BufRead *.td set filetype=tablegen
augroup END


"-- Haskell --------------------------------------------------------------------

augroup Haskell
  autocmd!

  autocmd BufNewFile,BufRead *.chs   set filetype=haskell " c2hs
  autocmd BufNewFile,BufRead *.maxml set filetype=haskell " MaxML

  autocmd FileType haskell setlocal shiftwidth=2
  autocmd FileType haskell setlocal iskeyword=@,48-57,_,'
  " autocmd FileType haskell setlocal foldcolumn=1
  autocmd FileType haskell setlocal path=src,,
  autocmd FileType haskell setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  autocmd FileType haskell setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.hs'

  " Sort then align imports, including as and hiding keywords
  "
  " This only operates on the current block (inner paragraph)
  "
  " The sorting step must occur last, because after sorting the cursor may be
  " within a comment area, and the following :Tabularize commands will fail.
  " autocmd FileType haskell nnoremap <silent> <Leader>ai
  "   \ <Bar> :Tabularize /\u.*/<CR>
  "   \ <Bar> :Tabularize /\u\(\w\\|\.\)*\(\s*\\|$\)\zs.*/<CR>
  "   \ vip :sort r /\u.*/<CR>
  autocmd FileType haskell nnoremap <silent> <Leader>ai :Tabularize haskell_imports<CR>

  " ghc-mod
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>t :GhcModType<CR>
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>T :GhcModTypeClear<CR>
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>i :GhcModTypeInsert<CR>
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>c :GhcModSplitFunCase<CR>
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>d :GhcModSigCodegen<CR>

  " let g:haskellmode_completion_ghc     = 0
  " let g:necoghc_enable_detailed_browse = 1
  " autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

  " ghci
  autocmd FileType haskell nnoremap <silent> <LocalLeader>q :T :q<CR>:T ./cabal quick "%"<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>Q :T :q<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>r :T :r<CR>
  " autocmd FileType haskell nnoremap <silent> <LocalLeader>s :T :r<CR>:T tests<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>E viw:TREPLSend<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>e :TREPLSend<CR>
  autocmd FileType haskell vnoremap <silent> <LocalLeader>e :TREPLSend<CR>

  "-- dag/vim2hs ---------------------------------------------------------------
  "
  let g:haskell_conceal=0 " don't conceal haskell syntax
  let g:haskell_jmacro=0
  let g:haskell_shqq=0
  let g:haskell_rlangqq=0
  let g:haskell_sql=0
  let g:haskell_json=0
  let g:haskell_xml=0
  let g:haskell_hsp=0

  " neovimhaskell/haskell-vim --------------------------------------------------
  let g:haskell_classic_highlighting = 1    " no clown vomit

  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 0  " to enable highlighting of `static`
  let g:haskell_backpack = 0                " to enable highlighting of backpack keywords

  let g:haskell_indent_if = 3
  let g:haskell_indent_in = 1
  let g:haskell_indent_case = 2
  let g:haskell_indent_let = 4
  let g:haskell_indent_where = 6
  let g:haskell_indent_before_where = 2
  let g:haskell_indent_after_bare_where = 2
  let g:haskell_indent_do = 3
  let g:haskell_indent_guard = 2

  let g:cabal_indent_section = 2

  nnoremap <F4> :call LanguageClient_contextMenu()<CR>
  " Or map each action separately
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

augroup END


"-- haskell-ide-engine ---------------------------------------------------------

let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
let g:LanguageClient_serverCommands = {
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'haskell': ['ghcide', '--lsp']
      \ }

au User lsp_setup call lsp#register_server({
    \ 'name': 'ghcide',
    \ 'cmd': {server_info->['/Users/trevor/.local/bin/ghcide', '--lsp']},
    \ 'whitelist': ['haskell'],
    \ })

" augroup lsp_install
"   au!
"   " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"   autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

"-- Intero ---------------------------------------------------------------------

" augroup interoMaps
"   au!
"   " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

"   " Background process and window management
"   au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
"   au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

"   " Open intero/GHCi split horizontally
"   au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
"   " Open intero/GHCi split vertically
"   au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
"   au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

"   " Reloading (pick one)
"   " Automatically reload on save
"   " au BufWritePost *.hs InteroReload
"   " Manually save and reload
"   au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

"   " Load individual modules
"   au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
"   au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

"   " Type-related information
"   " Heads up! These next two differ from the rest.
"   au FileType haskell map <silent> <leader>it <Plug>InteroGenericType
"   au FileType haskell map <silent> <leader>iT <Plug>InteroType
"   au FileType haskell nnoremap <silent> <leader>iit :InteroTypeInsert<CR>

"   " Navigation
"   au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

"   " Managing targets
"   " Prompts you to enter targets (no silent):
"   au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
" augroup END

" " Intero starts automatically. Set this if you'd like to prevent that.
" let g:intero_start_immediately = 0


"-- Markdown -------------------------------------------------------------------

augroup markdown
  " autocmd FileType markdown setl shell=bash\ -i

  let g:vim_markdown_toc_autofit          = 1
  let g:vim_markdown_new_list_item_indent = 2

  autocmd FileType markdown setlocal conceallevel=2
augroup END

"-- Lox ------------------------------------------------------------------------

autocmd BufNewFile,BufRead *.lox set filetype=lox

"-- Deoplete -------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

"-- Startify -------------------------------------------------------------------

nnoremap <leader>st :Startify<CR>

let g:startify_change_to_dir      = 1
let g:startify_change_to_vcs_root = 1

