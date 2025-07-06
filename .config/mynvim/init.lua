-- -----OPTIONS------------------------------------------------------------
vim.o.compatible = false         
vim.o.showtabline = 2            -- show tab-line
vim.o.swapfile = false           -- no swap files
vim.o.ruler = true
vim.o.visualbell = false          -- No bell
vim.o.enc='utf-8'	          -- Encoding UTF-8
vim.o.ls=2                        -- Always show status line
vim.o.incsearch = true            -- Incremental search
vim.o.linebreak = true            -- but not in the middle of the word
vim.o.nu = true                   -- Display line numbers
vim.o.numberwidth=3               -- Line number width
vim.o.scrolloff=5                 -- Scroll when # of line to the top/bottom
vim.o.tabstop=8                   -- Tab looks 8 spaces wide
vim.o.smarttab = true             -- replace tab with spaces
vim.o.hidden  = true              -- Allow change buffer without saving
vim.o.cursorline = true           -- Highlight current line
vim.o.synmaxcol=300               -- Limit syntax highlighting line length
vim.o.foldlevel=99                -- Don't fold when open a file by default
vim.o.splitright = true           -- Open splits on the right
vim.o.cc='80'                      -- 80 column border
vim.o.clipboard=unnamedplus       -- using system clipboard
vim.o.wrap  = false               -- No wrap by default
vim.o.breakindent = true          -- But when wrap preserve indentation
vim.o.expandtab = true
vim.o.shiftwidth=2 
vim.o.tabstop=8 
vim.o.softtabstop=8 
vim.o.smartindent = true 
vim.o.hlsearch = false            -- No highlight for search
vim.o.ttyfast = true              -- Fast tty

vim.o.timeout = false
vim.o.ttimeout = true

vim.o.spell = true
vim.o.spelllang=en_gb

vim.o.background=dark

-- Syntax highlighting and filetype plugins
vim.cmd('syntax off')
-- vim.cmd('filetype plugin indent off')

-- -------------FUNCTIONS----------------
function VifmPickFile()
  vim.cmd [[
      let cmd = 'fmin --choose-files /tmp/vim_vifm_pick '.expand("$PWD ").expand('%:p:h')
      let res = system(cmd)
      let file_path = readfile('/tmp/vim_vifm_pick')
      if !empty(file_path)
        :execute 'e '.file_path[0]
      endif
  ]]
end

-- Move the definitions to be lazy loaded when plugin is loaded
function Compile()
  vim.cmd [[
     " This relies on makecmd script which detects
     " the proper command for vim-dispatch depending on the environment
     " vim dispatch takes care for setting compiler to match the command
     let shellcmd = 'makecmd '.expand('%')
     let command=system(shellcmd)
     if !v:shell_error
       :execute 'Dispatch'.' '.trim(command)     
     endif
  ]]
end

function Run()
  vim.cmd [[
      " This relies on runcmd script which detects
      " the proper command for vim-dispatch depending on environment
      let shellcmd = 'runcmd '.expand('%')
      let command=system(shellcmd)
      if !v:shell_error
        :execute 'Start -wait=always'.' '.trim(command)
      endif
  ]]
end

-- -------------KEY BINDINGS -------------------------------------------------
-- Leader key
vim.g.mapleader = ' '

-- Show path
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':pwd<CR>', 
                        { noremap = true, silent = true })

-- Buffers switching
vim.api.nvim_set_keymap('n', '<C-p>', ':bp<CR>', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':bn<CR>', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':bd<CR>', 
                        { noremap = true, silent = true })
-- Config file
vim.api.nvim_set_keymap('n', '<Leader>o', ':e ~/.config/mynvim/init.lua<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>u', ':so ~/.config/mynvim/init.lua<CR>',
                        { noremap = true, silent = true })
-- Window navigation
vim.api.nvim_set_keymap('n', '<Leader>|', ':vsplit<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>-', ':split<CR>', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', 
                        { noremap = true, silent = true })
        
-- QuickFix List navigation

vim.api.nvim_set_keymap('n', '<Leader>[', ':cp<CR>', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>]', ':cn<CR>', 
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':ccl<CR>', 
                        { noremap = true, silent = true })

-- FileManager
vim.api.nvim_set_keymap('n', '<Leader>f', ':lua VifmPickFile()<CR>', 
                        { noremap = true, silent = true })
-- Open vimwiki
vim.api.nvim_set_keymap('n', '<Leader>ww', ':e ~/vimwiki/index.md<CR>', 
                        { noremap = true, silent = true })

-- Autocomplete in menu
-- TODO rewrite in lua
vim.cmd [[
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "<CR>"
  inoremap <expr> <C-space> pumvisible() ? "\<C-n>" : "<C-x><C-o>"
  inoremap <expr> <C-c> pumvisible() ? "\<C-n>" : "<C-x><C-o>"
]]

--Russian in Normal mode
vim.o.langmap='ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,Ж;:'


-- -------------EMAIL-------------------------------------------------------
vim.cmd [[
    autocmd BufNewFile,BufRead /tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist

    function! CheckRecruitmentReply()
      if !empty($MUTT_REPLY_TO_RECRUITER)
        :call cursor(8, 1)
        :read ~/bin/recruiter_response.txt
      endif
    endfunction

    autocmd BufNewFile,BufRead /tmp/neomutt* call CheckRecruitmentReply()
]]
-- ------------PLUGINS------------------------------------------------------

require("config")

-- ------------UI MISCELLANEOUS------------------------------------------------------
--
vim.cmd "colorscheme ntune"

-- Allow inline diagnostic messages
vim.diagnostic.config({
  virtual_text = true
})
-- Buffer Line
require("buftabline").setup {
  tab_format = " #{b}#{f} ",
}

-- StatusLine -----
require('lualine').setup{ 
  options = {icons_enabled = false,
    theme = 'papercolor_dark',
    component_separators = { left = '', right = '|'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{'filename', path=1}},
    lualine_c = {},
    lualine_x = {'fileformat', 'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

