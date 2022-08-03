let s:save_cpo = &cpo
set cpo&vim

aug autohidecmdline
  au!
aug END

let s:timer = 0

function! s:ClearEvents()
  au! autohidecmdline
  if s:timer
    call timer_stop(s:timer)
    let s:timer = 0
  endif
endfunction

function! auto_hide_cmdline#Show(count, nowait) abort
  call s:ClearEvents()
  let &cmdheight = get(g:, 'auto_hide_cmdline_height', 1)
  if a:nowait
    au autohidecmdline CmdLineLeave * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
  else
    au autohidecmdline CursorHold   * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
    au autohidecmdline CursorMoved  * ++once let s:timer = timer_start(&updatetime, 'auto_hide_cmdline#Hide')
  endif
  if a:count !=# 0
    call feedkeys(string(a:count), 'i')
  endif
endfunction

function! auto_hide_cmdline#Hide(_) abort
  call s:ClearEvents()
  if mode() ==# 'c'
    au autohidecmdline CmdLineLeave * ++once set cmdheight=0
  else
    redraw
    set cmdheight=0
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

