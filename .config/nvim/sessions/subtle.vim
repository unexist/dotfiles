
augroup SESSIONS
au! 
cd /home/unexist
badd projects/subtle/src/subtle/array.c
au BufReadPost projects/subtle/src/subtle/array.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/array.c
badd projects/subtle/src/subtle/client.c
au BufReadPost projects/subtle/src/subtle/client.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/client.c
badd projects/subtle/src/subtle/display.c
au BufReadPost projects/subtle/src/subtle/display.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/display.c
badd projects/subtle/src/subtle/event.c
au BufReadPost projects/subtle/src/subtle/event.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/event.c
badd projects/subtle/src/subtle/ewmh.c
au BufReadPost projects/subtle/src/subtle/ewmh.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/ewmh.c
badd projects/subtle/src/subtle/grab.c
au BufReadPost projects/subtle/src/subtle/grab.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/grab.c
badd projects/subtle/src/subtle/gravity.c
au BufReadPost projects/subtle/src/subtle/gravity.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/gravity.c
badd projects/subtle/src/subtle/hook.c
au BufReadPost projects/subtle/src/subtle/hook.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/hook.c
badd projects/subtle/src/subtle/panel.c
au BufReadPost projects/subtle/src/subtle/panel.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/panel.c
badd projects/subtle/src/subtle/ruby.c
au BufReadPost projects/subtle/src/subtle/ruby.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/ruby.c
badd projects/subtle/src/subtle/screen.c
au BufReadPost projects/subtle/src/subtle/screen.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/screen.c
badd projects/subtle/src/subtle/style.c
au BufReadPost projects/subtle/src/subtle/style.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/style.c
badd projects/subtle/src/subtle/subtle.c
au BufReadPost projects/subtle/src/subtle/subtle.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/subtle.c
badd projects/subtle/src/subtle/subtle.h
au BufReadPost projects/subtle/src/subtle/subtle.h setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/subtle.h
badd projects/subtle/src/subtle/tag.c
au BufReadPost projects/subtle/src/subtle/tag.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/tag.c
badd projects/subtle/src/subtle/text.c
au BufReadPost projects/subtle/src/subtle/text.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/text.c
badd projects/subtle/src/subtle/tray.c
au BufReadPost projects/subtle/src/subtle/tray.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/tray.c
badd projects/subtle/src/subtle/view.c
au BufReadPost projects/subtle/src/subtle/view.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/subtle/view.c
badd projects/subtle/src/shared/shared.c
au BufReadPost projects/subtle/src/shared/shared.c setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/shared/shared.c
badd projects/subtle/src/shared/shared.h
au BufReadPost projects/subtle/src/shared/shared.h setlocal fenc=utf-8 | au! SESSIONS BufReadPost projects/subtle/src/shared/shared.h
augroup END
edit projects/subtle/src/shared/shared.h
let v:this_session = "/home/unexist/.vim/sessions/subtle.vim"