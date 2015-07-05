" ------------------------------------------------------------------------------
" Load plugins (optionally downloading them if not installed) using Vundle
" and then set any plugin specific settings that are needed.
" ------------------------------------------------------------------------------


" Section: Setup Vundle
" ------------------------------------------------------------------------------
if has('vim_starting')
     call plug#begin('~/.vim/plugged')
     Plug 'bling/vim-airline'
     Plug 'elixir-lang/vim-elixir'
     Plug 'Glench/Vim-Jinja2-Syntax'
     Plug 'godlygeek/tabular'
     Plug 'groenewege/vim-less'
     Plug 'junegunn/vim-easy-align'
     Plug 'justinmk/vim-sneak'
     Plug 'majutsushi/tagbar'
     Plug 'mattn/emmet-vim'
     Plug 'mhinz/vim-signify'
     Plug 'rking/ag.vim'
     Plug 'scrooloose/nerdtree'
     Plug 'Shougo/unite.vim'
     Plug 'Shougo/vimproc.vim', { 'do': 'make' }
     Plug 'SirVer/ultisnips'
     Plug 'sjl/gundo.vim'
     Plug 'tommcdo/vim-exchange'
     Plug 'tpope/vim-fugitive'
     Plug 'tpope/vim-surround'
     Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
     Plug 'wting/rust.vim'
     Plug 'raichoo/haskell-vim'
     Plug 'wavded/vim-stylus'
     Plug 'ludovicchabant/vim-gutentags'
     Plug 'terryma/vim-multiple-cursors'
     call plug#end()
endif



" Section: Gutentags Settings
" ------------------------------------------------------------------------------
let g:gutentags_cache_dir=$HOME . "/.vim/backup/tags"
let g:gutentags_exclude=["env", ".git"]



" Section: UltiSnips Settings
" ------------------------------------------------------------------------------
let g:UltiSnipsListSnippets="<C-Tab>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsSnippetDirectories=["local_snippets"]
let g:ultisnips_cpp_type_style = "nl"



" Section: Airline Settings
" ------------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='bubblegum'



" Section: GUndo Settings
" ------------------------------------------------------------------------------
let g:gundo_preview_bottom=1



" Section: Ctrl-P Settings (Not used right now)
" ------------------------------------------------------------------------------
let g:ctrlp_max_files=0             " Slow... but only once.
let g:ctrlp_use_caching=1           " Need caching to compensate.
let g:ctrlp_clear_cache_on_exit=0   " Stop the cache being cleared.
let g:ctrlp_lazy_update=150         " Pause on keystrokes, less searches.
let g:ctrlp_match_window_bottom=0   " Put CtrlP window at the top.



" Section: ag.vim Settings
" ------------------------------------------------------------------------------
let g:agprg=$HOME . "/.dot/local/bin/ag --column --noheading --nobreak -S"




" Section: Unite Settings
" ------------------------------------------------------------------------------
let g:unite_source_rec_max_cache_files=0



" Section: DelimitMate Setings
" ------------------------------------------------------------------------------
let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1



" Section: Late Plugin Settings (Only checkable at late load)
" ------------------------------------------------------------------------------
fu! ConditionalPlugins()
    " Only set custom Unite source settings if the Unite plugin is available.
    " This stops us calling this on first run (when setting up vim without
    " plugins) and causing an error.
    if exists("*unite#custom#source")
        call unite#custom#source('file_rec/async', 'max_candidates', 0)
    endif
endf

augroup PluginModifiers
    au!
    au VimEnter * call ConditionalPlugins()
augroup END

