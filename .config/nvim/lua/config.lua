local plugin_dir = vim.fn.expand("$HOME/build/neovim_plugins/lazy")
local lazypath = plugin_dir.."/lazy.nvim"
--UNCOMMENT IF NEED TO INSTALL lazy from git
--[[
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
--]]
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  root = plugin_dir,
  spec = {
    {"nvim-treesitter/nvim-treesitter", 
      branch = 'master', 
      lazy = false, 
      build = ":TSUpdate",
      opts_extend = { "ensure_installed" },
      opts = {
        highlight = { enable = true },
        indent = { enable = false },
        ensure_installed = {
            "asm",
            "awk",
            "bash",
            "bibtex",
            "c",
            "cpp",
            "cuda",
            "diff",
            "html",
            "java",
            "json",
            "jsonc",
            "lua",
            "luap",
            "make",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "pascal",
            "query",
            "regex",
            "toml",
            "sql",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
          },
      },
      ---@param opts TSConfig
      config = function(_, opts)
          require("nvim-treesitter.configs").setup(opts)
      end,
   },
   {
      lazy = true,
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
   },
   {
    "jose-elias-alvarez/buftabline.nvim",
  },
  {
    'nvim-lualine/lualine.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    ft = {'c', 'cpp'},
    config = function()
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
          -- Enable completion triggered by <c-x><c-o>
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
          -- Mappings.
          local opts = { noremap=true, silent=true }
          buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        end
        vim.lsp.config('clangd', {
            cmd = {'clangd-10', '--background-index'},
            on_attach = on_attach
        })
        vim.lsp.enable('clangd')
        vim.cmd [[
          set omnifunc=syntaxcomplete#Complete     " default omni completion
          set completeopt-=preview                 " No documentation preview
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
          nnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>
        ]]
    end,
  },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.cmd [[
          let g:vimwiki_folding = 'custom'
          " Parse TODO for appointments, update calcurse
          autocmd BufWritePost ~/vimwiki/TODO.md silent !update_calcurse_apt.sh
          " Parse Routines for appointments, update calcurse
          autocmd BufWritePost ~/vimwiki/Routines.md silent !update_calcurse_apt.sh
          " Parse next planned items and update calcurse TODO
          autocmd BufWritePost ~/vimwiki/NextDaysPlans.md silent !update_calcurse_todo.sh
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

          " -- Fold text
          function! MyFoldText()
              return substitute(getline(v:foldstart),"^ *","",1). '...             '
          endfunction
          set foldtext=MyFoldText()

          " Conceal links
          autocmd Filetype markdown,vimwiki
          \  syn region markdownLink matchgroup=markdownLinkDelimiter
          \  start="(" end=")" keepend contained conceal contains=markdownUrl
      ]]
    end,
  },
  {
    "sakhnik/nvim-gdb",
    lazy = true,
    keys = {
        {"<Leader>dd", "<Leader>dd", desc = "Start GNU GDB"}, 
        {"<Leader>dl", "<Leader>dl", desc = "Start LLDB"}, 
        {"<Leader>dp", "<Leader>dp", desc = "Start PDB"}, 
        {"<Leader>db", "<Leader>db", desc = "Start BashDB"}, 
        {"<Leader>dr", "<Leader>dr", desc = "Start rr replay"}, 
    },
    config = function()
      -- ToggleBreakpoint
      vim.api.nvim_set_keymap('n', '<Leader>b', ':GdbBreakpointToggle<CR>', 
                              { noremap = true, silent = true })
    end,
  },
  {
    "tpope/vim-dispatch",
    lazy = true,
    keys = {
        {"<Leader>c", ":lua Compile()<CR>", desc = "Compile"}, 
        {"<Leader>r", ":lua Run()<CR>", desc = "Run"}, 
    },
    config = function()
        vim.g.dispatch_compilers = {gcc='gcc',
                                    pylint='pylint',
                                    proselint='proselint',
                                    fpc='fpc'}
        -- Dont use tmux panes to dispatch make requests (or it will exit Zoom)
        vim.g.dispatch_no_tmux_make = 1
    end,
  },
  },
  install = {
    missing=false, 
    colorscheme = { "darkblue" } 
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "gzip",
        "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  }
})
