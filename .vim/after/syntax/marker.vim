" Syntax
highlight MarkerTab guibg=green guifg=black ctermbg=green ctermfg=black
highlight MarkerWhitespace  guibg=yellow guifg=black ctermbg=yellow ctermfg=black
highlight MarkerOverlength guibg=red guifg=black ctermbg=red ctermfg=black

syntax match MarkerTab /\t/                                                                                           
syntax match MarkerWhitespace /[ ]*$/                                                                                  
syntax match MarkerOverlength /\%81v.*/