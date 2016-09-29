"===============================================================================
"                                 ~My vimrc~
"===============================================================================
"
" Author:       Tim Hyson [http://timhyson.com]
" Source:       https://github.com/timhyson/home-files
"
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
" Launch Config {{{
"-------------------------------------------------------------------------------
" Extract all vim plugins
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
"}}}
"-------------------------------------------------------------------------------
" Colors {{{
"-------------------------------------------------------------------------------
colorscheme solarized
"colorscheme badwolf
"colorscheme molokai

" Setting dark mode
set background=dark

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
"}}}
"-------------------------------------------------------------------------------
" Space and Tabs {{{
"-------------------------------------------------------------------------------
" Softtabs, 2 spaces
set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab     " tabs are
set smarttab      " helps with backspacing because of expandtab
se shiftwidth=2  " number of spaces for auto indenting
set shiftround    " use multiples of shiftwidth when indenting with '<' and '>'
filetype indent on " load filetype-specific indent files
filetype plugin on " load filetype-specific plugin files
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
"}}}
"-------------------------------------------------------------------------------
" UI Layout {{{
"-------------------------------------------------------------------------------
set number        " show line numbers
set numberwidth=5
set showcmd       " show command in bottom bar
set cursorline    " highlight the current line
set wildmenu      " Enable tab complete for commands
set wildmode=list:longest,list:full " first tab shows all matches. next tab starts cycling through the matches
set lazyredraw    " redraw only when we need to
set ttyfast       " faster redraw
set showmatch     " flashes matching brackets or parentheses
" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
" Supercharges '%' to work on do-end, def-end, class-end, module-end etc.
runtime macros/matchit.vim
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set ruler         " show the cursor position all the time
set laststatus=2  " always display the status line

set spelllang=en_gb " spell check
set history=50
set autowrite     " Automatically :write before running commands
set complete=.,w,b,u,t,i
"}}}
"-------------------------------------------------------------------------------
" Searching {{{
"-------------------------------------------------------------------------------
set incsearch     " do incremental searching
set hlsearch      " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<cr>
"}}}
"-------------------------------------------------------------------------------
" Folding {{{
"-------------------------------------------------------------------------------
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <Leader>z za
set foldlevelstart=10   "start with fold level of 1
"}}}
"-------------------------------------------------------------------------------
" Line shortcuts {{{
"-------------------------------------------------------------------------------
" Move vertically by visual line (as opposed to line break only)
nnoremap j gj
nnoremap k gk

" keep cursor column when JK motion
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1

" Move to beginning / end of line
nnoremap B ^
nnoremap E $
" $ / ^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Highlight last inserted text
nnoremap gV `[v`]

" Backspace behaviour
set backspace=indent,eol,start
"set backspace=2   " Backspace deletes like most programs in insert mode
"}}}
"-------------------------------------------------------------------------------
" Leader Shortcuts {{{
"-------------------------------------------------------------------------------
let mapleader = "\<Space>" " leader is space

" 'jj' / 'jk' / 'kj' is escape
inoremap jj <ESC>:wa<CR>
inoremap jk <ESC>:wa<CR>
inoremap kj <ESC>:wa<CR>

" Nerdtree
map <C-t> :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>

" Toggle gundo (displays undo tree in graphical form)
nnoremap <leader>u :GundoToggle<CR>

" Edit vimrc/zshrc and load vimrc/zshrc bindings
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ez <C-w><C-v><C-l>:e ~/.zshrc<cr>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Save session (then reopen saved session with 'vim -S')
nnoremap <leader>s :mksession<CR>

" Open ag.vim (maybe replace with 'nnoremap <Leader>a')
map <leader>F :Ag<space>

" Strip Whitespace
nnoremap <leader>ws :StripWhitespace<CR>

" Autoformat
map <Leader>f :Autoformat<CR>

" Indentation
nnoremap <Leader>i m^gg=G`^

" Easily spell check http://vimcasts.org/episodes/spell-checking/
nmap <silent> <leader>s :set spell!<CR>

" Toggle paste mode
"set pastetoggle=<leader>p

" Cycle forward and backward through open buffers
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>

" Tab navigation
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>te :tabedit

" Create split, close split
nnoremap <leader>w <C-w>v<C-w>1
nnoremap <leader>q <C-w>q

" Git shortcut
" map <leader>g :Git<space>

" Index ctags from any project
map <Leader>ct :!ctags -r .<CR>

" all tests in file
nnoremap <leader>u :call RunPHPUnitTest(0)<cr>
" test under cursor
nnoremap <leader>t :call RunPHPUnitTest(1)<cr>

" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>

  " filename       (foo.txt)
  nnoremap <leader>ct :let @*=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif
"}}}
"-------------------------------------------------------------------------------
" Keyboard Shortcuts {{{
"-------------------------------------------------------------------------------
" avoid common vim typos https://sanctum.geek.nz/arabesque/vim-command-typos/
if has("user_commands")
  command! -bang -nargs=? -complete=file E e<bang> <args>
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif

" Move between splits
nnoremap <S-Tab> <C-W>W
nnoremap <Tab> <C-W><C-W>

" Quicker window movement - clashes with tmux
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

" bind K to grep word under cursor
nnoremap K :grep! "\b<c-r><c-w>\b"<CR>:cw<CR>

" such very magic
:nnoremap / /\v
:cnoremap %s/ %s/\v

" Remap F1 from Help to ESC.  No more accidents.
nmap <F1> <Esc>
map! <F1> <Esc>

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap * *Nzz
nmap # #nzz

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
"}}}
"-------------------------------------------------------------------------------
" Copy and Paste {{{
"-------------------------------------------------------------------------------
" Toggle Paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>

" Paste mode in and out
"nnoremap <leader>p :set paste<CR>
"nnoremap <leader>np :set nopaste<CR>

" make ctrl-c work with vim on a mac
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>
"}}}
"-------------------------------------------------------------------------------
" NERDTree {{{
"-------------------------------------------------------------------------------
let NERDTreeQuitOnOpen=1
" colored NERD Tree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']
"}}}
"-------------------------------------------------------------------------------
" CtrlP {{{
"-------------------------------------------------------------------------------
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0     " always open files in new buffers
let g:ctrlp_working_path_mode = 0 " respect working directory changes during vim session
let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif
"}}}
"-------------------------------------------------------------------------------
" Tmux {{{
"-------------------------------------------------------------------------------
" Allows cursor change in tmux mode
if exists('TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"}}}
"-------------------------------------------------------------------------------
" Autogroups {{{
"-------------------------------------------------------------------------------
" Create language-specific settings for certain filetypes / extensions
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
        \:call <SID>StripTrailingWhitespaces()
  autocmd FileType java setlocal noexpandtab
  autocmd FileType java setlocal list
  autocmd FileType java setlocal listchars=tab:+\ ,eol:-
  autocmd FileType java setlocal formatprg=par\ -w80\ -T4
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal list
  autocmd FileType php setlocal listchars=tab:+\ ,eol:-
  autocmd FileType php setlocal formatprg=par\ -w80\ -T4
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

autocmd FileType javascript inoremap (; ();<Esc>hi

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
  " Automatically wrap at 80 characters for Markdown
  "autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
"}}}
"-------------------------------------------------------------------------------
" Backups {{{
"-------------------------------------------------------------------------------
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
au FocusLost * :wa
set autowrite
"}}}
"-------------------------------------------------------------------------------
" Custom Functions {{{
"-------------------------------------------------------------------------------
function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction

" Tab completion
" will insert tab at beginning of line, will use completion if not at beginning
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
"}}}

" Ability to run single or all unit tests from within a test file
function! RunPHPUnitTest(filter)
  cd ~/Sites/DrupalV3_UKCL_DEV/app
  if a:filter
    normal! T yw
    let result = system("phpunit --filter " . @" . " " . bufname("%"))
  else
    let result = system("phpunit " . bufname("%"))
  endif
  split __PHPUnit_Result__
  normal! ggdG
  setlocal buftype=nofile
  call append(0, split(result, '\v\n'))
  cd -
endfunction
"}}}

" vim:foldmethod=marker:foldlevel=0
