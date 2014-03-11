" ------------------------------------------------------------------------------
" Setup custom bindings in vim, all the plugin related bindings are also here
" instead of strewn around the rc/plugins.vim file.
" ------------------------------------------------------------------------------


" Section: Normal Mode Bindings
" ------------------------------------------------------------------------------
nnoremap <Leader>l :NERDTreeToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a, :Tabularize /,\zs<CR>
nnoremap <Leader>cf :<C-u>Unite -no-split -start-insert file_rec/async:!<CR>
nnoremap <Leader>cg :<C-u>Unite -no-split file<CR>
nnoremap <Leader>cu :<C-u>Unite -no-split file_mru<CR>
nnoremap <Leader>cd :<C-u>Unite -no-split directory_mru<CR>
nnoremap <Leader>cb :<C-u>Unite -no-split buffer<CR>
nnoremap <Leader>cr :<C-u>Unite -no-split register<CR>
nnoremap <Leader>ct :<C-u>Unite -no-split tab<CR>
nnoremap <Leader>cc :<C-u>Unite -no-split -start-insert command<CR>
nnoremap <Leader>cm :<C-u>Unite -no-split mapping<CR>
nnoremap <Leader>cs :<C-u>Unite -no-split grep:./<CR>
nnoremap <Leader>cl :<C-u>Unite -no-split -start-insert line<CR>
nnoremap <Leader>cp :<C-u>Unite -no-split -start-insert process<CR>
nnoremap Q @@



" Section: More Situational Bindings
" ------------------------------------------------------------------------------
" Use Ag to search for the identifier under the cursor.
nnoremap <Leader>* <ESC>yiw:Ag <C-R>"<CR>

" Split the window into three sections and enable synced scrolling for longer
" views of files.
nnoremap <Leader>s :call SyncScrollFile()<CR>



" Section: Autocommands
" ------------------------------------------------------------------------------
" Update tag files post-file save for selected filetypes.
au BufWritePost *.c,*.h,*.cpp,*.hpp,*.hs,*.py,*.rb,*.sh,*.java silent! !ctags --append <afile>
au BufWritePost *.hs silent! !hasktags --ctags --append <afile>

augroup BufferModifiers
    au!
    au FileType markdown let b:strip_whitespace=1
    au BufWritePre * call StripWhitespace()
augroup END
