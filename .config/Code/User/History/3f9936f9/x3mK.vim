" ============================
" Display Settings
" ============================
set number                      " Show absolute line numbers
set relativenumber              " Show relative line numbers
syntax on                       " Enable syntax highlighting

" ============================
" Buffer Settings
" ============================
set hidden                      " Allow unsaved buffer switching
set autowrite                   " Auto-save when switching buffers
set confirm                     " Ask before discarding changes
set switchbuf=useopen           " Jump to existing window if open

" ============================
" Indentation
" ============================
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
set expandtab                   " Use spaces instead of tabs
set autoindent                  " Auto-indent new lines

" ============================
" Search Settings
" ============================
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search
set ignorecase                  " Case-insensitive search
set smartcase                   " Case-sensitive if uppercase letters are used

" ============================
" Interface Settings
" ============================
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching brackets
set ruler                       " Show cursor position
set laststatus=2                " Always show status line
set wildmenu                    " Enhanced command completion
set scrolloff=5                 " Keep lines above/below cursor

" ============================
" Editor Behavior
" ============================
set noswapfile                  " Disable swap files
set nobackup                    " Disable backup files
set undofile                    " Enable persistent undo
set clipboard=unnamedplus       " Use system clipboard
set mouse=a                     " Enable mouse support
