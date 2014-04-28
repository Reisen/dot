" ------------------------------------------------------------------------------
" A collection of various custom functions for situations that plugins and vim
" don't really have solutions for. Or aren't worth grabbing some plugin for.
" ------------------------------------------------------------------------------

fu! LoadAbbreviations()
    iabc
    let target = globpath(&rtp, "abbreviations/") . &filetype . ".vim"
    if filereadable(target) == 1
        execute "source " . target
    endif
endf

fu! StripWhitespace()
    if exists('b:strip_whitespace')
        return
    endif
    %s/\v\s+$//e
endf

fu! CreateScratchBuffer()
    enew
    setl buftype=nofile
    setl bufhidden=hide
    setl noswapfile
endf

fu! SyncScrollFile()
    " Store the current scrolloff offset temporarily so we can set it to 0 and
    " properly sync up the windows.
    let l:oldso = &so
    let &so = 0
    setl noscb

    " Create the first split window.
    bo vs                               " Split window.
    normal Ljzt
    setl scb                            " Enable synced scrolling for window.
    wincmd p                            " Refocus the original window.

    " Create the second split window.
    bo vs                               " Split again.
    normal LjztLjzt
    setl scb                            " Enable synced scrolling for this window.
    wincmd p                            " Refocus the original window.

    " Restore settings.
    setl scb
    let &so = l:oldso
endf
