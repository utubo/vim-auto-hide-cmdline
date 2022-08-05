if exists('g:auto_hide_cmdline')
  finish
endif
let g:auto_hide_cmdline = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <Plug>(ahc) <Cmd>call auto_hide_cmdline#Show(v:count, 0)<CR>
noremap <Plug>(ahc-nowait) <Cmd>call auto_hide_cmdline#Show(v:count, 1)<CR>
noremap <Plug>(ahc-switch) <Cmd>echoe 'Sry, (ahc-switch) is duplicated !'<CR>

aug autohidecmdline_switch
  au!
  au CmdlineEnter * silent! call auto_hide_cmdline#Switch()
  au CursorMoved * silent! call auto_hide_cmdline#SaveScrPos()
aug END

let &cpo = s:save_cpo
unlet s:save_cpo

