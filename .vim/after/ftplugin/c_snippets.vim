" $Id$
if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

function! Count(haystack, needle)
    let counter = 0
    let index = match(a:haystack, a:needle)
    while index > -1
        let counter = counter + 1
        let index = match(a:haystack, a:needle, index+1)
    endwhile
    return counter
endfunction

function! CArgList(count)
    " This returns a list of empty tags to be used as 
    " argument list placeholders for the call to printf
    let st = g:snip_start_tag
    let et = g:snip_end_tag
    if a:count == 0
        return ""
    else
        return repeat(', '.st.et, a:count)
    endif
endfunction

function! CMacroName(filename)
  let name = a:filename
  let name = substitute(name, '\.','_','g')
  let name = substitute(name, '\(.\)','\u\1','g')
  return name
endfunction

" Single
exec "Snippet nl printf(\"\\n\");".st.et
exec "Snippet ifd #ifdef ".st."DEBUG:toupper(@z)".et."<CR>".st.et."<CR>#endif /* ".st."DEBUG:toupper(@z)".et." */"
exec "Snippet inc #include <".st."stdio".et.".h>".st.et
exec "Snippet incl #include \"".st."stdio".et.".h\"".st.et
exec "Snippet debug printf(\"DEBUG %s:%d\\n\", __func__, __LINE__);".st.et
exec "Snippet def #define ".st."DEBUG:toupper(@z)".et." ".st.et
exec "Snippet free free(".st.et.");".st.et
exec "Snippet once #ifndef ``CMacroName(expand('%'))``<CR>#define ``CMacroName(expand('%'))`` 1<CR><CR>".st.et."<CR><CR>#endif /* ``CMacroName(expand('%'))`` */"
exec "Snippet printf printf(\"".st."\"%s\"".et."\\n\"".st."\"%s\":CArgList(Count(@z, '%[^%]'))".et.");".st.et
exec "Snippet ret return ".st."0".et.";".st.et
exec "Snippet ass assert(".st."conditon".et.");".st.et

" Block
exec "Snippet if if(".st."condition".et.")<CR><SPACE><SPACE>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>}"
exec "Snippet if- if(".st."conditon".et.") ".st.et
exec "Snippet for for(".st."i".et." = ".st."0".et."; ".st.et."; ".st."i".et."++)<CR><SPACE><SPACE>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>}"
exec "Snippet for- for(".st."i".et." = ".st."0".et."; ".st.et."; ".st."i".et."++) ".st.et
exec "Snippet swi switch(".st."var".et.")<CR><SPACE><SPACE>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>}"
exec "Snippet case case ".st."value".et.":<CR><SPACE><SPACE>".st.et."<CR>break;"
exec "Snippet case- case ".st."value".et.": ".st.et." break;".st.et
exec "Snippet while while(".st.et.")<CR><SPACE><SPACE>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>}"
exec "Snippet while- while(".st.et.") ".st.et
exec "Snippet main int<CR>main(int argc,<CR><SPACE><SPACE>char *argv[])<CR><BS><BS>{<CR><SPACE><SPACE>".st.et."<CR>return 0;<CR><BS><BS>}"
exec "Snippet struct struct ".st."name".et."<CR>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>};"
exec "Snippet union union ".st."name".et."<CR>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>};"
exec "Snippet void /* ".st."func".et." {{{ */<CR>static void<CR>".st."func".et."(".st."void".et.")<CR>{<CR><SPACE><SPACE>".st.et."<CR><BS><BS>} /* }}} */"

" Doc
exec "Snippet doc <SPACE>/** ".st."func".et."<CR>@brief ".st."brief".et."<CR>".st.et."<CR><BS>*/"
exec "Snippet par @param[".st."in".et."]<SPACE><SPACE>".st."var".et."  ".st."description".et.st.et
exec "Snippet retv @retval  ".st."value".et."<SPACE><SPACE>".st."description".et.st.et
exec "Snippet retu @return ".st."description".et.st.et
