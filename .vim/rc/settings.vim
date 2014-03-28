" ------------------------------------------------------------------------------
" Initialize all the good shit that makes Vim worth using. Only core built-in
" vim settings are in here, plugin settings are in rc/plugins.vim. Options are
" grouped in the same groups as in :options.
" ------------------------------------------------------------------------------


" Section: 1 important
" ------------------------------------------------------------------------------
set nocompatible                " Disable dumb vi behaviours.
set noim                        " Make sure to always start vim in Normal mode.
set nopaste                     " Make sure input mode isn't gimped.



" Section: 2 moving around, searching, and patterns
" ------------------------------------------------------------------------------
set whichwrap=b,s,<,>           " Make left/right move lines like BS and Space.
set incsearch                   " But still highlight while typing at least.



" Section: 4 displaying text
" ------------------------------------------------------------------------------
set nowrap                      " Disable line wrapping.
set nolinebreak                 " Don't automatically break lines at the limit.
set lazyredraw                  " Don't draw while executing macros, faster.
set list                        " Draw normally hidden characters.
set listchars=tab:>\ ,trail:_    " Set hidden character replacements text.
set number                      " Show line numbers.
if exists('&relativenumber')
    set relativenumber          " Show relative line numbers (Vim 7.4 Dual).
endif



" Section: 5 syntax, highlighting and spelling
" ------------------------------------------------------------------------------
if &t_Co > 2
    set t_Co=256                " Enable 256 Colours. Nicer looking themes.
endif

set cursorline                  " Highlight the line the cursor is on.
set nohlsearch                  " Disable highlighting search results.



" Section: 6 multiple windows
" ------------------------------------------------------------------------------
set laststatus=2                " Show status bar no matter how many wins.
set equalalways                 " Make sure windows are always resized equally.
set splitright                  " Put window on the right instead of in place.
set splitbelow                  " Same deal for horizontal splits.



" Section: 10 GUI
" ------------------------------------------------------------------------------
if has('gui_running')
    set guifont=Terminus\ 9     " Fonts for GVim.

    set guioptions-=r           " Disable all scrollbars in Gvim.
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=b
    set guioptions-=B
endif



" Section: 12 messages and info
" ------------------------------------------------------------------------------
set showcmd                     " Show partial commands in the status bar.
set showmode                    " Show mode in status bar.
set ruler                       " Show position in file in status bar.



" Section: 13 editing text
" ------------------------------------------------------------------------------
set textwidth=0                 " Stop vim from wrapping breaking lines.
set wrapmargin=0                " Same again.
set showmatch                   " Highlight matching parenthesis briefly.
set nojoinspaces                " Stop vim using two spaces . line joins.



" Section: 14 tabs and indenting
" ------------------------------------------------------------------------------
set tabstop=4                   " Display tabs as 4 space width.
set shiftwidth=4                " Number of spaces inserted when pressing tab.
set smarttab                    " Use shiftwidth for line indenting.
set softtabstop=4               " Insert x spaces instead of a tab.
set shiftround                  " >> and << Round to shiftwidth, smarter.
set expandtab                   " When tabs should be inserted, keep spaces.
set autoindent                  " Keep prevoius lines indent on new lines.
set smartindent                 " Indent cleverly (when seeing { etc).




" Section: 18 mapping
" ------------------------------------------------------------------------------
set ttimeoutlen=0               " Eliminate keycode delays.



" Section: 19 reading and writing files
" ------------------------------------------------------------------------------
set modeline                    " Vim options from modelines.
set modelines=10                " Search a little further for modelines.
set ff=unix                     " Do this always, because fuck it.
set writebackup                 " Backup files during writes, in case vim fucks.
set backup                      " Enable file backups.
set backupdir=~/.vim/backup     " Save backup files here.
set cryptmethod=blowfish        " Yeah



" Section: 20 the swap file
" ------------------------------------------------------------------------------
set dir=~/.vim/backup/swap      " Write all swap files away from any VCS eyes.



" Section: 21 command line editing
" ------------------------------------------------------------------------------
set wildcharm=<C-z>
set wildmenu
set undofile                    " Store undo history for files, useful as hell.
set undodir=~/.vim/backup/undo  " Store in same place as swap files.



" Section: 25 multi-byte characters
" ------------------------------------------------------------------------------
set encoding=utf-8



" Section: 26 various (also non-options)
" ------------------------------------------------------------------------------
set virtualedit=block           " Enable editing outside no character areas.
set viewdir=~/.vim/backup/view  " Store view files in the same place as swap.
let hs_highlight_types=1        " Enable Highlighting haskell Types.

syntax on                       " Enable syntax Highlighting.
colorscheme bluez2              " Nice dark and blue colour scheme.
filetype on                     " Detect filetypes and run filetype.vim
filetype plugin on              " Enable language specific settings.
