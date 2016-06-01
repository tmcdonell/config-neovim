
"-- Plugins --------------------------------------------------------------------

" Use Plug (junegunn/vim-plug) to manage plugins. Due to the structure of that
" git repository it needs to be stored directly in autoload, not the bundle
" directory. It can, however, update itself.
call plug#begin('~/.config/nvim/plug')

" A minimalist vim plugin manager (disabled: cannot bootstrap)
" Plug 'junegunn/vim-plug'

" A plugin for asynchronous :make using Neovim's job-control functionality
Plug 'benekastah/neomake'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" teach a vim to fish
Plug 'dag/vim-fish'

" Fast vim CtrlP matcher based on python
Plug 'FelikZ/ctrlp-py-matcher'

" Configurable, flexible, intuitive text aligning
Plug 'godlygeek/tabular'

" vimscripts for haskell development
Plug 'dag/vim2hs'
" Plug 'neovimhaskell/haskell-vim'

" Improved incremental (and fuzzy) searching for vim
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" Wrapper of some neovim's :terminal functions
Plug 'kassio/neoterm'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

" Delete buffers and close files in Vim without messing up your layout.
Plug 'moll/vim-bbye'

" Visualise the vim undo tree
Plug 'sjl/gundo.vim'

" Comment stuff out
Plug 'tpope/vim-commentary'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Show git diff in the gutter
Plug 'airblade/vim-gitgutter'

" Complementary pairs of mappings
Plug 'tpope/vim-unimpaired'

" Combine with NETRW to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" Happy Haskell programming on Vim, powered by ghc-mod
" Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Dark powered asynchronous completion framework for neovim (requires python3)
Plug 'Shougo/deoplete.nvim'

" Syntax checking hacks for vim (requires +lua)
" Plug 'scrooloose/syntastic'

" Automatic resizing of Vim windows to the golden ratio
" Plug 'roman/golden-ratio'

" LLVM syntax
Plug 'Superbil/llvm.vim'

" A vim plugin for vim plugins
Plug 'tpope/vim-scriptease'

" Highlight trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" Man page viewer
Plug 'nhooyr/neoman.vim'

" Speed up vim by updating folds only when called for
Plug 'Konfekt/FastFold'

" The fancy start screen for Vim
Plug 'mhinz/vim-startify'

" Add quotes/parenthesis
Plug 'tpope/vim-surround'

" Repeat supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Live preview markdown files
function! CargoBuild(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('CargoBuild') }
  " NOTE: OpenSSL installed via Homebrew is not linked to the system paths by
  " default, so to do the initial build you may need something like:
  "
  " > env C_INCLUDE_PATH=/usr/local/homebrew/opt/openssl/include cargo build -release
  "

" Markdown mode (requires gadlygeek/tabular)
Plug 'plasticboy/vim-markdown'

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


" -- Colours -------------------------------------------------------------------

" The background colour brightness
colorscheme chaos
set background=light

" Matches iTerm2 colours (?)
let g:terminal_color_0  = '#808080'
let g:terminal_color_1  = '#da4f56'
let g:terminal_color_2  = '#78af54'
let g:terminal_color_3  = '#fa8e43'
let g:terminal_color_4  = '#6197d4'
let g:terminal_color_5  = '#cf9af8'
let g:terminal_color_6  = '#50c283'
let g:terminal_color_7  = '#d6d6c6'
let g:terminal_color_8  = '#bdbdbd'
let g:terminal_color_9  = '#fc767c'
let g:terminal_color_10 = '#95da72'
let g:terminal_color_11 = '#fecc7a'
let g:terminal_color_12 = '#8ebaf6'
let g:terminal_color_13 = '#f7bdff'
let g:terminal_color_14 = '#67e39f'
let g:terminal_color_15 = '#efeee0'


"-- Airline --------------------------------------------------------------------

let g:airline_powerline_fonts                   = 1
let g:airline_theme                             = 'tomorrow'
let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#tabline#fnamecollapse  = 0
let g:airline#extensions#tabline#formatter      = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod       = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1


" -- Highlighting --------------------------------------------------------------

" type of file; triggers the FileType event when set (local to buffer)
filetype plugin indent on

" name of syntax highlighting used (local to buffer)
syntax on

" highlight all matches for the last used search pattern
set hlsearch

" highlight the screen line of the cursor (local to window)
set cursorline

" spell highlight spelling mistakes, list of accepted languages
set spell
set spelllang=en_au


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
set hidden

" split new windows to the right or below of the current one
set splitright
set nosplitbelow

" list of flags specifying which commands to wrap to another line
set whichwrap=b,s,h,l,<,>,~,[,]

" number of spaces used for each step of (auto)indent
set shiftwidth=4

" a <Tab> in an indent inserts 'shiftwidth' spaces
set smarttab

" number of spaces to insert for a <Tab>
set softtabstop=8

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
set wildignore+=*/projects/*

" Vim
set wildignore+=*/spell/*
set wildignore+=*/plugged/*

" Haskell
set wildignore+=*/dist/*,*/.cabal-sandbox/*,*/.stack-work/*


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

  " Open neoterm windows in a vertical split
  let g:neoterm_position = 'vertical'

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

" gundo toggle window
nnoremap <F5> :GundoToggle<CR>


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

" Leader + t = find file in project
nnoremap <silent> <Leader>t :CtrlP<CR>

" Leader + b = find file in open buffers
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" Leader + r = clean file cache
nnoremap <silent> <Leader>r :CtrlPClearCache<CR>

let g:ctrlp_root_markers = ['*.cabal']
let g:ctrlp_match_func   = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_reuse_window = 'startify'


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
" map /   <Plug>(incsearch-forward)
" map ?   <Plug>(incsearch-backward)
" map g/  <Plug>(incsearch-stap)

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

augroup haskell
  autocmd!

  autocmd BufNewFile,BufRead *.maxml set syntax=haskell " MaxML

  " autocmd FileType haskell setlocal shiftwidth=2
  " autocmd FileType haskell setlocal iskeyword=@,48-57,_,'
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
  autocmd FileType haskell nnoremap <silent> <LocalLeader>t :GhcModType<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>T :GhcModTypeClear<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>i :GhcModTypeInsert<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>c :GhcModSplitFunCase<CR>
  autocmd FileType haskell nnoremap <silent> <LocalLeader>d :GhcModSigCodegen<CR>

  let g:haskellmode_completion_ghc     = 0
  let g:necoghc_enable_detailed_browse = 0
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

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
  let g:haskell_indent_in=0
  let g:haskell_enable_typeroles=1
  let g:haskell_enable_pattern_synonyms=1
  " let g:haskell_classic_highlighting=1

augroup END

"-- Markdown -------------------------------------------------------------------

augroup markdown
  " autocmd FileType markdown setl shell=bash\ -i

  let g:vim_markdown_toc_autofit          = 1
  let g:vim_markdown_new_list_item_indent = 2

  autocmd FileType markdown setlocal conceallevel=2
augroup END

"-- Deoplete -------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

"-- Startify -------------------------------------------------------------------

nnoremap <leader>st :Startify<CR>

let g:startify_change_to_dir      = 1
let g:startify_change_to_vcs_root = 1

