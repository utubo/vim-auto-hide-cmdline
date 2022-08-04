let s:save_cpo = &cpo
set cpo&vim

aug autohidecmdline
  au!
aug END

let s:laststatus = &laststatus
let s:timer = 0

function! s:ClearEvents()
  au! autohidecmdline
  if s:timer
    call timer_stop(s:timer)
    let s:timer = 0
  endif
endfunction

function! auto_hide_cmdline#Show(count, nowait, switch = 0) abort
  call s:ClearEvents()
  let &cmdheight = a:switch ? 0 : get(g:, 'auto_hide_cmdline_height', 1)
  if &laststatus !=# 0
    let s:laststatus = &laststatus
    if a:switch || get(g:, 'auto_hide_cmdline_switch_statusline', 0)
      set laststatus=0
    endif
  endif
  redraw
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
    au autohidecmdline ModeChanged c:* ++once call auto_hide_cmdline#Hide(0)
  else
    if &cmdheight !=# 0
      redraw
      set cmdheight=0
    endif
    let &laststatus = s:laststatus
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

