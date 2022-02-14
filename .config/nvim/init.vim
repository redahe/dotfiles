" ------------Plugins------------------------------------------------
"
call plug#begin('~/build/vimplugins') " keep plugins in build dir
	Plug 'flazz/vim-colorschemes' " Color Schemes
	Plug 'crusoexia/vim-monokai'

	Plug 'itchyny/lightline.vim'     " Custom status line
	Plug 'ap/vim-buftabline'        " Buffers in tabline

	Plug 'roxma/vim-tmux-clipboard' " sync vimand tmux copy buffers
	Plug 'tpope/vim-dispatch'       " Dispatch make to parallel tmux window
	Plug 'preservim/vimux'          " Run commands in tmux-pane

	Plug 'vimwiki/vimwiki'                    

	Plug 'neovim/nvim-lspconfig'  " Standard configs for lsp

        Plug 'SirVer/ultisnips'       " Snippet Engine
        Plug 'honza/vim-snippets'     " Collection of snippets TODO make my own

        Plug 'sakhnik/nvim-gdb'      " gdb,lldb,pdb,bashdb integration
        " ----------------experimental---------------------
        Plug 'preservim/vim-markdown'

call plug#end()            " required

" -------
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['bash=sh']

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
set nowrap                        " No wrap by default
set breakindent                   " But when wrap preserve indentation
set expandtab 
set shiftwidth=2 
set tabstop=8 
set softtabstop=8 
set smartindent
set nohlsearch                   " No highlight for search

set notimeout
set ttimeout

filetype plugin on
syntax on

function! RealRPath()
  return expand('%:.')
endfunction

"-------------Status Line Settings--------------------------------
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'realrelpath', 'modified']],
      \ },
      \ 'component_function': {
      \   'cwd': 'getcwd',
      \   'realrelpath': 'RealRPath'
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
  
"-------------Snippets -----------------------

let g:UltiSnipsExpandTrigger='<tab>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<tab>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

"---------------Runner window controls-----------------------------------------
nnoremap <Leader>rc :VimuxPromptCommand<CR>
nnoremap <Leader>rr :VimuxRunLastCommand<CR>
nnoremap <Leader>ri :VimuxInspectRunner<CR>
" paste to runner
nnoremap <Leader>rp  :call SendRegister2Vimux()<CR>
" Enter current line in runner
nnoremap <Leader>rl :call VimuxOpenRunner()\| call VimuxSendText(getline('.'))\|call VimuxSendKeys('enter')<CR>
" --------------------------autocompletion menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "<CR>"
inoremap <expr> <C-space> pumvisible() ? "\<C-n>" : "<C-x><C-o>"

" Pre-send command
function! PreSend2Vimux()
  :call VimuxOpenRunner()
  if &filetype == 'python'
    " Assume Ipython repl
     :call VimuxSendText('%cpaste')
     :call VimuxSendKeys('enter')
     sleep 50ms
  endif
endfunction

function! AfterSend2Vimux()
  if &filetype == 'python'
    " Assume Ipython repl
     :call VimuxSendKeys('C-d')
  endif
endfunction

" Send register to Vimux
function! SendRegister2Vimux()
 :call PreSend2Vimux()
 :call VimuxSendText(@+)
 :call AfterSend2Vimux()
endfunction

" send block to REPL
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
     :call PreSend2Vimux()
  
     for line in lines
         if strlen(line)>0
             :call VimuxSendText(line)
	     :call VimuxSendKeys('enter')
         endif
     endfor
     :call AfterSend2Vimux()
endfunction
" Send curent block (betwen ## .. ##) to runner (REPL)
nnoremap <Leader>rb :call SendBlock2Vimux()<CR>
nnoremap <Leader>rq :VimuxCloseRunner<CR>

"--------------Close quick fix window---------------------------------------

nnoremap <Leader>o :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>u :so ~/.config/nvim/init.vim<CR>
 " Show/hide line numbers
nnoremap <leader>n :set invnumber<CR>

function! VifmPickFile()
  let cmd = 'fmin --choose-files /tmp/vim_vifm_pick '.expand("$PWD ").expand('%:p:h')
  let res = system(cmd)
  let file_path = readfile('/tmp/vim_vifm_pick')
  if !empty(file_path)
    :execute 'e '.file_path[0]
  endif
endfunction

nmap <F3> :call VifmPickFile()<CR>
nmap <leader>f :call VifmPickFile()<CR>

let g:dispatch_compilers = {'gcc': 'gcc',
      \'pylint3': 'pylint',
      \'fpc': 'fpc'}

" Dont use tmux panes to dispatch make requests (or it will exit Zoom)
let g:dispatch_no_tmux_make = 1

function Compile()
  " This relies on makecmd script which detects 
  " the proper command for vim-dispatch depending on the environment
  " vim dispatch takes care for setting compiler to match the command
  let shellcmd = 'makecmd '.expand('%')   
  let command=system(shellcmd)
  if v:shell_error
      return 1
  endif
  :execute 'Dispatch'.' '.trim(command)
endfunction

function Run()
  " This relies on runcmd script which detects 
  " the proper command for vim-dispatch depending on environment
  let shellcmd = 'runcmd '.expand('%')   
  let command=system(shellcmd)
  if v:shell_error
      return 1
  endif
  :execute 'Start -wait=always'.' '.trim(command)
endfunction




map  <F9> :call Compile()<CR>
map  <F10> :call Run()<CR>


map <F6> :let &bg=(&bg=='light'?'dark':'light')<cr>  " toggle bg lighnes
"------------LSP-----------------------------------------------------------
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
nnoremap <silent> gD <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

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


hi! link BufTabLineActive TabLine

"-------------------Settings per file type--------------------------------------
" --- Indents, tabs and line lenght for programming ---
"
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" ----------------------------------------------------------
" --------------- Email editing -----------------------
autocmd BufNewFile,BufRead /tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist

function! CheckRecruitmentReply()
  if !empty($MUTT_REPLY_TO_RECRUITER)
    :call cursor(8, 1)
    :read ~/bin/recruiter_response.txt
  endif
endfunction

autocmd BufNewFile,BufRead /tmp/neomutt* call CheckRecruitmentReply()



" ------ vimwiki settings ----------------------------------------------------
let g:vimwiki_folding = 'custom'

" Update calcurse entries after editing todo
autocmd BufWritePost ~/vimwiki/TODO.md silent !update_calcurse.sh ~/vimwiki/TODO.md

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

"  ---------LSP and Code Completion----------------------------------------
set omnifunc=syntaxcomplete#Complete     " default omni completion
set completeopt-=preview                 " No documentation preview

" let g:SuperTabDefaultCompletionType="context"   " Enable filepath completion
" let g:SuperTabContextDefaultCompletionType="<c-x><c-o>" " Omni for rest

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

autocmd FileType python  set foldmethod=indent
autocmd FileType c,cpp,r set foldmethod=syntax
