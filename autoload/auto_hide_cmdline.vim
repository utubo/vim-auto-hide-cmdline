let s:save_cpo = &cpo
set cpo&vim

aug autohidecmdline
  au!
aug END

let s:timer = 0

function! auto_hide_cmdline#Show(count, nowait) abort
  let &cmdheight = get(g:, 'auto_hide_cmdline_height', 1)
  au! autohidecmdline
  if s:timer
    call timer_stop(s:timer)
  endif
  if a:nowait
    au autohidecmdline CmdLineLeave * ++once redraw | call timer_start(1, 'auto_hide_cmdline#Hide')
  else
    au autohidecmdline CursorHold * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
    au autohidecmdline CursorMoved * ++once let s:timer = timer_start(&updatetime, 'auto_hide_cmdline#Hide')
  endif
  if a:count !=# 0
    call feedkeys(string(a:count), 'i')
  endif
endfunction

function! auto_hide_cmdline#Hide(_) abort
  au! autohidecmdline
  if mode() ==# 'c'
    au autohidecmdline CmdLineLeave * ++once set cmdheight=0
  else
    set cmdheight=0
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

