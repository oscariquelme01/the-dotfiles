" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

exmap splitVertical obcommand workspace:split-vertical
exmap splitHorizontal obcommand workspace:split-horizontal
exmap only obcommand workspace:close-others
nnoremap <C-w>v :splitVertical
nnoremap <C-w>h :splitHorizontal
nnoremap <C-w>o :only


exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight

exmap focusRight obcommand editor:focus-left
nmap <C-h> :focusLeft

exmap focusBottom obcomman editor:focus-bottom
nmap <C-j> :focusBottom

exmap focusTop obcomman editor:focus-top
nmap <C-k> :focusTop
