let s:save_cpo = &cpo
set cpo&vim

aug autohidecmdline
  au!
aug END

let s:laststatus = &laststatus
let s:scrolloff = &scrolloff
let s:timer = 0

function! s:ClearEvents()
  au! autohidecmdline
  if s:timer
    call timer_stop(s:timer)
    let s:timer = 0
  endif
  silent! cunmap <script> <CR>
endfunction

function! s:SaveVimSettings()
  if &laststatus !=# 0
    let s:laststatus = &laststatus
  endif
  if &scrolloff !=# 0
    let s:scrolloff = &scrolloff
  endif
endfunction

function! s:ResetVimSettings()
  if &cmdheight !=# 0
    redraw
    set cmdheight=0
  endif
  let &laststatus = s:laststatus
  let &scrolloff = s:scrolloff
endfunction

" Auto hide cmdline
function! auto_hide_cmdline#Show(count, nowait) abort
  call s:ClearEvents()
  call s:SaveVimSettings()
  set scrolloff&
  let &cmdheight = get(g:, 'auto_hide_cmdline_height', 1)
  if &laststatus !=# 0 && get(g:, 'auto_hide_cmdline_switch_statusline', 0)
    set laststatus=0
  endif
  redraw
  if a:nowait
    au autohidecmdline CmdLineLeave * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
  else
    au autohidecmdline CursorHold   * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
    au autohidecmdline CursorMoved  * ++once let s:timer = timer_start(&updatetime, 'auto_hide_cmdline#Hide')
    au autohidecmdline CmdlineLeave * ++once let &scrolloff = s:scrolloff
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
    call s:ResetVimSettings()
  endif
endfunction

" Switch statusline
function! auto_hide_cmdline#Switch(for_blink) abort
  if &laststatus ==# 0 || ! get(g:, 'auto_hide_cmdline_switch_statusline', 0)
    return
  endif
  call s:SaveVimSettings()
  if a:for_blink
    set scrolloff&
    set cmdheight=1
    au autohidecmdline CmdLineLeave * ++once call s:ResetVimSettings()
  else
    au autohidecmdline CmdLineLeave * ++once call timer_start(1, 'auto_hide_cmdline#Hide')
  endif
  set laststatus=0
  redraw
endfunction

let s:row = line('.')
function! auto_hide_cmdline#SaveScrPos() abort
  if &cmdheight || &laststatus ==# 0 || s:row ==# line('.') || ! get(g:, 'auto_hide_cmdline_switch_statusline', 0)
    return
  endif
  let s:row = line('.')
  " set laststatus=0 to save the scroll position for switch statusline.
  set laststatus=0
  let &laststatus  = s:laststatus
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

