" ------------------------------------------------------------------------------
" Load plugins (optionally downloading them if not installed) using Vundle
" and then set any plugin specific settings that are needed.
" ------------------------------------------------------------------------------


" Section: Setup Vundle
" ------------------------------------------------------------------------------
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/Vundle.vim
    filetype off
    call vundle#begin()

    Bundle 'gmarik/Vundle.vim'

    Bundle 'AshyIsMe/2048'
    Bundle 'bling/vim-airline'
    Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
    Bundle 'elixir-lang/vim-elixir'
    Bundle 'Glench/Vim-Jinja2-Syntax'
    Bundle 'godlygeek/tabular'
    Bundle 'groenewege/vim-less'
    Bundle 'junegunn/vim-easy-align'
    Bundle 'justinmk/vim-sneak'
    Bundle 'majutsushi/tagbar'
    Bundle 'mattn/emmet-vim'
    Bundle 'mhinz/vim-signify'
    Bundle 'rking/ag.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'Shougo/unite.vim'
    Bundle 'Shougo/vimproc.vim'
    Bundle 'SirVer/ultisnips'
    Bundle 'sjl/gundo.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'tommcdo/vim-exchange'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-surround'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'wting/rust.vim'
    Bundle 'raichoo/haskell-vim'
    Bundle 'jonathanfilip/vim-lucius'

    call vundle#end()
endif



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

