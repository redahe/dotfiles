" ------------Plugins------------------------------------------------
call plug#begin('~/build/vimplugins') " keep plugins in build dir
	Plug 'flazz/vim-colorschemes'               " Color Schemes
	Plug 'crusoexia/vim-monokai'

	Plug 'itchyny/lightline.vim'                " Custom status line
	Plug 'ap/vim-buftabline'                    " Buffers in tabline

	Plug 'roxma/vim-tmux-clipboard'             " sync vimand tmux copy buffers
	Plug 'tpope/vim-dispatch'                   " Dispatch make to parallel tmux window
	Plug 'preservim/vimux'                      " Run commands in tmux-pane

	Plug 'vimwiki/vimwiki'                    

	Plug 'neovim/nvim-lspconfig'                " Standard configs for lsp
call plug#end()            " required


" ----------Settings--------------------------------------

set showtabline=2 	          " show tabline
set nocompatible
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
set synmaxcol=140                " Vim syntax highlighting can be slow on long lines, limiting
set foldlevel=99                  " Dont fold when open a file by default
set splitright                    " Open splits on the right
set cc=80                         " 80 column border
set clipboard=unnamedplus         " using system clipboard


filetype plugin on
syntax on

"-------------Status Line Settings--------------------------------
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ]],
      \ },
      \ 'colorscheme': 'PaperColor'
      \ }

"---------------Runner (vimux) pane settings-----------------

let g:VimuxOrientation = "h"
let g:VimuxHeight = "33"
let g:VimuxCommandShell = 1
let g:VimuxPromptString = "run>"

"--------------Key bindings --------------------------------------------------
nmap <space> <leader>
imap <C-Space> <C-x><C-o>
map <Leader><space> :pwd<CR>
"--------------Buffers navigation----------------------------------------------
nmap <C-p> :bp<CR>              " Previous buffer
nmap <C-n> :bn<CR>              " Next buffer
nmap <C-x> :bp\|bd #<CR>        " Go to the previous buffer and close the last

"--------------Windows Navigation----------------------------------------------
" Don't require w key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <Leader>\| :vsplit<CR>    " Divide window vertically
map <Leader>- :split<CR>      " Divide window horizontaly

map <C-q> :q<CR>
"---------------QuckFix List navigation

nnoremap <leader>[ :cp<CR>
nnoremap <leader>] :cn<CR>
nnoremap <leader>q :ccl<CR>
  
"---------------Runner window controls-----------------------------------------
nnoremap <Leader>rc :VimuxPromptCommand<CR>
nnoremap <Leader>rr :VimuxRunLastCommand<CR>
nnoremap <Leader>ri :VimuxInspectRunner<CR>
" paste to runner
nnoremap <Leader>rp :call VimuxSendText(@")<CR>
" Enter current line in runner
nnoremap <Leader>rl :call VimuxSendText(getline('.'))\|call VimuxSendKeys('enter')<CR>

function! SendBlock2Vimux()
    let start = search('^##\+', 'bnW')
    let end = search('^##\+', 'nW')
    if start == 0
        let start = 1
    else
        let start = start + 1
    endif
    if end == 0
        let end = line('$')
     else
        let end = end -1
     endif
     let lines = getline(start,end)
     " Send ctr-o for ipython to use 1 cell
     :call VimuxSendKeys('C-o')
     for line in lines
         if strlen(line)>0
             :call VimuxSendText(line)
	     :call VimuxSendKeys('enter')
         endif
     endfor
     :call VimuxSendKeys('enter')
endfunction
" Enter current line in runner
nnoremap <Leader>rb :call SendBlock2Vimux()<CR>
nnoremap <Leader>rq :VimuxCloseRunner<CR>

"--------------Close quick fix window---------------------------------------

nnoremap <Leader>o :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>u :so ~/.config/nvim/init.vim<CR>
 " Show/hide line numbers
nnoremap <leader>n :set invnumber<CR>

nmap <C-f> :!fmin %:p:h<CR>       " Open file manager where the buffer is
nmap <leader>f :!fmin %:p:h<CR>   " Open file manager where the buffer is

map  <F9> :Make <CR>              " Make is an improved version of 'make' from tpope/vim-dispatch
map  <F10> :Make run <CR>         " Make run command

map <F6> :let &bg=(&bg=='light'?'dark':'light')<cr>  " toggle bg lighnes
"------------LSP-----------------------------------------------------------
"Go to the defenition
"
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> grn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> gf <cmd>lua vim.lsp.buf.formatting()<CR>

" --- UI, Colors and highlighting

highlight MatchParen ctermfg=blue ctermbg=None " avoid 'cursor jumping' effect
highlight LineNr ctermfg=DarkGrey ctermbg=None " line number highligh


function! AutoTransparency()
  highlight clear CursorLine
  highlight Normal ctermbg=none
  highlight LineNr ctermbg=none
  highlight Folded ctermbg=none
  highlight NonText ctermbg=none
  highlight SpecialKey ctermbg=none
  highlight VertSplit ctermbg=none
  highlight SignColumn ctermbg=none
endfunction

autocmd ColorScheme * call AutoTransparency() " Force transparency
set t_Co=256                        " Support 256 colors
colorscheme PaperColor              " Color Scheme
set background=dark                 " Default background mode (light/dark)



"-------------------Settings per file type--------------------------------------
" --- Indents, tabs and line lenght for programming ---
"
autocmd FileType python,c,cpp,go,vimwiki,sh set nowrap     " Don't wrap lines in sources

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

autocmd FileType c,go,cpp,sh setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=8 smartindent
" ----------------------------------------------------------
" --------------- Email editing -----------------------
autocmd BufNewFile,BufRead /tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist

" ------ vimwiki settings ----------------------------------------------------
let g:vimwiki_folding = 'custom'

" Folding function from vimwiki doc for markdown
function! VimwikiFoldLevelCustom(lnum)
    let pounds = strlen(matchstr(getline(a:lnum), '^#\+'))
    if (pounds)
      return '>' . pounds  " start a fold level
   endif
    if getline(a:lnum) =~? '\v^\s*$'
      if (strlen(matchstr(getline(a:lnum + 1), '^#\+')))
        return '-1' " don't fold last blank line before header
      endif
    endif
    return '=' " return previous fold level
endfunction

autocmd FileType vimwiki setlocal foldmethod=expr |
     \ setlocal foldenable | set foldexpr=VimwikiFoldLevelCustom(v:lnum)

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_autowriteall = 0

autocmd FileType vimwiki setlocal syntax=markdown
autocmd FileType vimwiki setlocal foldlevel=1       " Fold ##-level headers
"--------------------------------
"
" -- Fold text 

function! MyFoldText()
    return substitute(getline(v:foldstart),"^ *","",1). '...             ' 
endfunction
set foldtext=MyFoldText()

" Conceal links
autocmd Filetype markdown,vimwiki 
\  syn region markdownLink matchgroup=markdownLinkDelimiter 
\  start="(" end=")" keepend contained conceal contains=markdownUrl

" -------------REPL--------------------------------------------------
"  TODO
" -------------------------------------------------------------------
"
"
"  ---------LSP and Code Completion----------------------------------------
set omnifunc=syntaxcomplete#Complete     " default omni completion
set completeopt-=preview                 " No documentation preview

let g:SuperTabDefaultCompletionType="context"   " Enable filepath completion
let g:SuperTabContextDefaultCompletionType="<c-x><c-o>" " Omni for rest

lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

require'lspconfig'.clangd.setup{cmd = { "clangd-10", "--background-index" }, on_attach = on_attach}
require'lspconfig'.r_language_server.setup{on_attach = on_attach}
EOF


" Folding for languages

autocmd FileType c,cpp,r  set foldmethod=syntax
"autocmd FileType c,cpp,r  set foldmethod=expr
"  \ foldexpr=lsp#ui#vim#folding#foldexpr()
"  \ foldtext=lsp#ui#vim#folding#foldtext()



