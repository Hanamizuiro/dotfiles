-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Initialize Packer (if not already initialized)
require('packer').startup(function(use)
  -- Plugin installations go here
  use 'tpope/vim-fugitive'  -- Example plugin
end)

