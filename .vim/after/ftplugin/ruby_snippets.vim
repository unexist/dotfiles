" $Id$
if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

" Single
exec "Snippet req require(\"".st.et."\")".st.et
exec "Snippet : :".st."key".et." => \"".st."value".et."\"".st.et
exec "Snippet @ @".st."name".et." = \"".st."value".et."\"".st.et

" Block
exec "Snippet def # ".st."method".et." {{{ <CR><BS><BS>def ".st."method".et."(".st.et.")<CR><SPACE><SPACE>".st.et."<CR><BS><BS>end #  }}}"
exec "Snippet class # ".st."class".et." {{{ <CR><BS><BS>class ".st."class".et."<CR><SPACE><SPACE>".st.et."<CR><BS><BS>end #  }}}"
exec "Snippet begin begin<CR><SPACE><SPACE>".st.et."<CR><BS><BS>rescue<CR><SPACE><SPACE>".st.et."<CR><BS><BS>end".st.et
exec "Snippet do do<CR><SPACE><SPACE>".st.et."<CR><BS><BS>end".st.et

exec "Snippet each- each { |".st."iter".et."| ".st.et" }".st.et
exec "Snippet each each { |".st."iter".et."| ".st.et" }".st.et
