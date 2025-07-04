local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--[[
--UNCOMMENT IF NEED TO INSTALL lazy from git
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
  spec = {
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
  },
  {
    "UtkarshVerma/molokai.nvim",
    lazy = false,
    priority = 1000,
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
      }
  },
  {
    "tpope/vim-dispatch",
    lazy = true,
    keys = {
        {"<Leader>c", ":lua Compile()<CR>", desc = "Compile"}, 
        {"<Leader>r", ":lua Run()<CR>", desc = "Run"}, 
      }
  },
  },
  install = {
    missing=false, 
    colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
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
