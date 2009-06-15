" $Id$
if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim
let ta = "<CR><SPACE><SPACE>"
let te = "<CR><BS><BS>"
let dots = "..."

" C++
exec "Snippet nam using namespace ".st."std".et.";"
exec "Snippet cout cout << ".st.et." << endl;".st.et
exec "Snippet class class ".st."name".et."<CR>{".ta.st.et.te."};"
exec "Snippet try try".ta."{".ta.st.et.te."}".te."catch(".st."catch".et.")".ta."{".ta.st.et.te."}"
exec "Snippet cat catch(".st."catch".et.")".ta."{".ta.st.et.te."}"
exec "Snippet thr throw(".st.et.");".st.et
exec "Snippet incp #include <".st."iostream".et.">".st.et
