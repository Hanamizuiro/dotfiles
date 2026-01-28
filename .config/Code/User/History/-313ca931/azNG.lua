-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Display Settings
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.cmd("syntax on")             -- Enable syntax highlighting

-- Buffer Settings
vim.opt.hidden = true            -- Allow unsaved buffer switching
vim.opt.autowrite = true         -- Auto-save when switching buffers
vim.opt.confirm = true           -- Ask before discarding changes
vim.opt.switchbuf = "useopen"    -- Jump to existing window if open

-- Indentation
vim.opt.tabstop = 4              -- Set tab width
vim.opt.shiftwidth = 4           -- Set indent width
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.autoindent = true        -- Auto-indent new lines

-- Search Settings
vim.opt.hlsearch = true          -- Highlight search results
vim.opt.incsearch = true         -- Incremental search
vim.opt.ignorecase = true        -- Case-insensitive search
vim.opt.smartcase = true         -- Case-sensitive if uppercase present

-- Interface Settings
vim.opt.cursorline = true        -- Highlight current line
vim.opt.showmatch = true         -- Highlight matching brackets
vim.opt.ruler = true             -- Show cursor position
vim.opt.laststatus = 2           -- Always show status line
vim.opt.wildmenu = true          -- Enhanced command completion
vim.opt.scrolloff = 5            -- Keep lines above/below cursor

-- Editor Behavior
vim.opt.swapfile = false         -- Disable swap files
vim.opt.backup = false           -- Disable backup files
vim.opt.undofile = true          -- Enable persistent undo
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.mouse = "a"              -- Enable mouse support
