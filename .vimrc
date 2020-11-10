
" ------------Plugins--------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/build/vimplugins') " keep plugins in build dir

	Plugin 'VundleVim/Vundle.vim'
	Plugin 'flazz/vim-colorschemes'             " Color Schemes
	Plugin 'scrooloose/nerdtree' 	            " Project and file navigation
	Plugin 'bling/vim-airline'   	    	    " Lean & mean status/tabline for vim
	Plugin 'vim-airline/vim-airline-themes'     " vim-airline-themes
	Plugin 'tmux-plugins/vim-tmux-focus-events' " required for vim-tmux integration
	Plugin 'roxma/vim-tmux-clipboard'           " sync vimand tmux copy buffers
	Plugin 'vim-syntastic/syntastic'            " Syntax errors
	Plugin 'tpope/vim-dispatch'                 " Dispatch make to parallel tmux window
	Plugin 'NLKNguyen/papercolor-theme'         " Paper color theme


call vundle#end()            " required


"---------------Plugin Settings---------------------------
set t_Co=256                      " Support 256 colors

colorscheme PaperColor              " Color Scheme
set background=light                " Default background mode (light/dark)
redraw!                             " Need when run in screen from tmux

nnoremap <F6> :let &bg=(&bg=='light'?'dark':'light')<cr>  " toggle bg lighnes

let g:airline_theme='zenburn'     " Status line theme
let g:airline_powerline_fonts = 1 " Use fancy symbols in status line
let g:airline#extensions#tabline#enabled = 1 " show buffers
map <F3> :NERDTreeToggle<CR>      " Open nerdtree on F3


" ----------Settings--------------------------------------

set nocompatible                  " be iMproved, required
set noswapfile 	                  " no swap files
set viminfo='20,<1000             " large clipboard
set ruler

set novisualbell                  " No bell
set enc=utf-8	                  " Encoding UTF-8
set ls=2                          " Always show status line
set incsearch                     " Incremental search

set wrap                          " Wrap long lines
set linebreak                     " but not in the middle of the word

" set hlsearch                      " Highlight all found items
set nu	                            " Display line numbers
set numberwidth=3                   " Line number width

set scrolloff=5	                  " Scroll when # of line to the top/bottom
set guioptions-=T                 " in gVim remove toolbar
set tabstop=8                     " Tab looks 8 spaces wide
set smarttab                      " replace tab with spaces
set hidden                        " Allow change buffer without saving
set cursorline                    " Highlight current line

" ---- Custom key bindings

nmap <C-N> :set invnumber<CR>     " Show/hide line numbers
nmap <C-h> :bp<CR>                " Previous buffer
nmap <C-k> :bp<CR>                " Previous buffer
nmap <C-l> :bn<CR>                " Next buffer
nmap <C-j> :bn<CR>                " Next buffer
nmap <C-x> :bd<CR>                " Close buffer

nmap <C-f> :!fmin %:p:h<CR>       " Open file manager where the buffer is

map  <F9> :Make <CR>              " Make is an improved version of 'make' from tpope/vim-dispatch
map  <F10> :Make run <CR>         " Make run command

" --- UI Highlights
highlight MatchParen ctermfg=blue ctermbg=None " avoid 'cursor jumping' effect
highlight LineNr ctermfg=DarkGrey ctermbg=None " line number highligh


" --- Indents, tabs and line lenght for programming ---
autocmd FileType python,c,cpp
                 \ highlight Excess ctermbg=DarkGrey guibg=Black
autocmd FileType python,c,cpp match Excess /\%80v.*/ " Highlight > 80 column
autocmd FileType python,c,cpp set nowrap             " Don't wrap lines in sources

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType c setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent
" ----------------------------------------------------------


" ----syntastic settings - syntax check
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
