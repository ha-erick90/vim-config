" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=m          " Remove the menu & toolbar
    set guioptions-=T
    set lines=55 columns=158    " Set fullscreen for my desktop
else
    set term=builtin_ansi       " Make arrow and other keys work
endif

if has('gui_running')
  set guifont=Monospace\ 11
endif

set encoding=utf-8

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"Personal Settings.
"More to be added soon. 
execute pathogen#infect() 
filetype plugin indent on 
syntax on

"Toggle between relativenumber and absoult numbers
function! NumberToggle()
  if (&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n>: call NumberToggle()<cr>

" Change to absolute whe focus is out of window.
": au FocusLost * : set number " :au FocusGained * :set relativenumber

"Change when entering insert mode.
" autocmd InsertEnter * :set number
"
autocmd InsertLeave * : set relativenumber

 "Set the status line options. Make it show more information. 
set laststatus=2 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 

"Set Color Scheme and Font Options
colorscheme kolor

"set line no, buffer, search, highlight, autoindent and more. 
set nu 
set hidden 
set ignorecase 
set incsearch 
set smartcase 
set showmatch
nnoremap <leader><space> :noh<cr>

set autoindent
set ruler
set vb
set viminfo+=n$VIM/_viminfo
set noerrorbells
set showcmd
set mouse=a
set history=1000
set undolevels=1000
set colorcolumn=72


" Edit and reload Vim file
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>lv :so $MYVIMRC<cr>

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Tab config
set expandtab
set tabstop=2
set shiftwidth=2

" No backup files
set nobackup

" Map <ESC>
inoremap jj <ESC>

" Open Split Window and move to it
nnoremap <leader>w <C-w>v <C-w>l

" Add Semicolon at the end of line
nnoremap <leader>; A;<ESC>
inoremap <leader>; <ESC>A;

" Save file
nnoremap <leader>s :w<CR>
inoremap <leader>s <ESC>:w<CR>a

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Search and replace mappings
nnoremap <F4> :%s//gc<Left><Left><Left>
nnoremap <S-F4> :%s/<C-r><C-w>//gc<Left><Left><Left>

" YankRing mappings
nnoremap <silent><F3> :YRShow<cr>
inoremap <silent><F3><ESC> :YRShow<cr>

" Configuration for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Deleta trailing spaces on save
autocmd BufWritePre *.js :%s/\s\+$//e

" Ctrl - Space
let g:CtrlSpaceSymbols = {"CS": "#","ALL": "ALL","Vis": "VIS","NTM": "+","WLoad": "|*|","WSave": "[*]","Zoom": "*","IV": "-","IA": "*"}

" NERDTree
map <F5> :NERDTreeToggle<CR>

" Ctrl-P
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']
nmap <leader>p :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>

"Move lines up and down
nnoremap <A-j> :m.+1<CR>==
nnoremap <A-k> :m.-2<CR>==
inoremap <A-j><Esc> :m.+1<CR>==gi
inoremap <A-k><Esc> :m.-2<CR>==gi
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m'<-2<CR>gv=gv

let g:syntastic_javascript_checkers = ["eslint"]

" Beautifier
let g:editorconfig_Beautifier = "/home/erick/.vim/.editorconf"
map <leader>f :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <leader>f :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>f :call JsonBeautify() <cr>
autocmd FileType jsx noremap <buffer> <leader>f :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>f :call HtmlBeautify() <cr>
autocmd FileType css noremap <buffer> <leader>f :call CSSBeautify() <cr>

" YANK Ring config
let g:yankring_replace_n_pkey = '<Char-62>'
let g:yankring_replace_n_nkey = '<Char-60>'

" Delimit Mate
inoremap <leader><CR> <CR><ESC>O
