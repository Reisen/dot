" ------------------------------------------------------------------------------
" A collection of various custom functions for situations that plugins and vim
" don't really have solutions for. Or aren't worth grabbing some plugin for.
" ------------------------------------------------------------------------------

function! LoadAbbreviations()
    iabc
    let target = globpath(&rtp, "abbreviations/") . &filetype . ".vim"
    if filereadable(target) == 1
        execute "source " . target
    endif
endfunction
