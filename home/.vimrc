"===============================================================================
"                                 ~My vimrc~
"===============================================================================
"
" Author:       Tim Hyson [http://timhyson.com]
" Source:       https://github.com/timhyson/home-files
"
"-------------------------------------------------------------------------------
"
" Leader
let mapleader = "\<Space>"

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set cursorline    " highlight the current line the cursor is on
set complete=.,w,b,u,t,i

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

"sm: flashes matching brackets or parentheses
set showmatch

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

"sta:   helps with backspacing because of expandtab
set smarttab

" When scrolling off-screen do so 3 lines at a time, not 1
set scrolloff=3

set spelllang=en_gb

" Enable tab complete for commands.
" first tab shows all matches. next tab starts cycling through the matches
set wildmenu
set wildmode=list:longest,list:full

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


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

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

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Open the Rails ApiDock page for the word under cursor, using the 'open'
" command
let g:browser = 'open '

"function! OpenRailsDoc(keyword)
"let url = 'http://apidock.com/rails/'.a:keyword
"exec '!'.g:browser.' '.url
"endfunction

" Open the Ruby ApiDock page for the word under cursor, using the 'open' command
"function! OpenRubyDoc(keyword)
"let url = 'http://apidock.com/ruby/'.a:keyword
"exec '!'.g:browser.' '.url
"endfunction

" NERDTree
let NERDTreeQuitOnOpen=1
" colored NERD Tree
let NERDChristmasTree = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeShowHidden = 1
" map enter to activating a node
let NERDTreeMapActivateNode='<CR>'
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf', '.beam']

" Shortcuts!!

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -r .<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Tab navigation
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>te :tabedit

" Remap F1 from Help to ESC.  No more accidents.
nmap <F1> <Esc>
map! <F1> <Esc>

" <leader>F to begin searching with ag
map <leader>F :Ag<space>

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap * *Nzz
nmap # #nzz

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Easily spell check
" http://vimcasts.org/episodes/spell-checking/
nmap <silent> <leader>s :set spell!<CR>


map <C-c>n :cnext<CR>
map <C-c>p :cprevious<CR>

" Added by Leo

" Switch into background mode
nnoremap <leader>. <C-z>

" inoremap <C-o> my<Esc>o<Esc>`yi
" Git shortcut
map <leader>g :Git<space>

" Move between splits
nnoremap <S-Tab> <C-W>W
nnoremap <Tab> <C-W><C-W>

" Cycle forward and backward through open buffers
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>

" No highlight after a search
nnoremap <leader><space> :noh<cr>

" Paste mode in and out
"nnoremap <leader>p :set paste<CR>
"nnoremap <leader>np :set nopaste<CR>

" Create split, close split
nnoremap <leader>w <C-w>v<C-w>1
nnoremap <leader>q <C-w>q

" Nerdtree
map <C-t> :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>

" JJ escape
inoremap jj <ESC>:wa<CR>

au FocusLost * :wa

"save and run last command
"nnoremap <CR> :wa<CR>:!!<CR>
"noremap <C-j> <ESC>:wa<CR>:!!<CR>

"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" source vimrc
nnoremap <leader>es :so $MYVIMRC

" make ctrl-c work with vim on a mac
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

autocmd FileType javascript inoremap (; ();<Esc>hi
set autowrite

" I'm not happy with this but I don't understand how vim/zsh work
" Maybe use tslime
set shell=/bin/sh

" RSpec.vim mappings
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>

" Cucumber mapping
map <Leader>c :w<cr>:!cucumber<cr>

" Easymotion
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" keep cursor column when JK motion
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1

" Two keyword search
nmap s <Plug>(easymotion-s2)

" such very magic
:nnoremap / /\v
:cnoremap %s/ %s/\v

" Indentation
nnoremap <Leader>i m^gg=G`^

" =========================================
" Added by Roi
" =========================================

" Strip Whitespace
nnoremap <leader>ws :StripWhitespace<CR>

" Autoformat
map <Leader>f :Autoformat<CR>

" Indentation
"nnoremap <Leader>i gg=G``
nnoremap == gg=G``

" Move up and down by visual line (as opposed to line break only)
nnoremap j gj
nnoremap k gk

" New Theme <3
"colorscheme sourcerer
colorscheme solarized

" Setting dark mode
set background=dark

" Supercharges '%' to work on do-end, def-end, class-end, module-end etc.
runtime macros/matchit.vim

" Toggle Paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
"set pastetoggle=<leader>p

nnoremap <Leader>H :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" Pomodoro Thyme
nmap <leader>T :!thyme -d<cr><cr>

" Toggle relative line numbers
let g:NumberToggleTrigger="<leader>r"

" HardTime
" let g:hardtime_default_on = 1
" let g:hardtime_timeout = 900
" let g:hardtime_showmsg = 1
" let g:hardtime_maxcount = 2

" bind K to grep word under cursor
nnoremap K :grep! "\b<c-r><c-w>\b"<CR>:cw<CR>

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

 " all tests in file
nnoremap <leader>u :call RunPHPUnitTest(0)<cr>
" test under cursor
nnoremap <leader>f :call RunPHPUnitTest(1)<cr>

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

