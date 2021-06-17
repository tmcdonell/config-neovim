
" Rendering is much faster when it does not have to reset the colour of every
" cell, so assume that the terminal background colour is set correctly.
"
" We need to do this after the airline plugin script loads, so that it creates
" its colour groups correctly.
"

highlight Normal ctermbg=None guibg=None

