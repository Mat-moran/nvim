" Experimental
let g:vimspector_base_dir=expand( '$HOME/.config/nvim/vimspector-config' )
" let g:vimspector_enable_mappings='VISUAL_STUDIO'
let g:vimspector_enable_mappings='HUMAN'

"The primeagen config
" fun GotoWindow(id)
"   call win_gotoid(a:id)
"   MaximizerToggle
" endfun
" does not work properly

nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
"nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
"nmap <leader>de :Vimspector#Eval()<CR>
"nmap <leader>dw :Vimspector#Watch()<CR>
"nmap <leader>do :Vimspector#ShowOuput()<CR>
nnoremap <leader>dtcb :call vimspector#CleanLineBreakPoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<Tab> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
