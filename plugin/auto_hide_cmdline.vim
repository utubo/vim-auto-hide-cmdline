if exists('g:auto_hide_cmdline')
  finish
endif
let g:auto_hide_cmdline = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <Plug>(ahc) <Cmd>call auto_hide_cmdline#Show(v:count, 0)<CR>
noremap <Plug>(ahc-nowait) <Cmd>call auto_hide_cmdline#Show(v:count, 1)<CR>
noremap <Plug>(ahc-switch) <Cmd>call auto_hide_cmdline#Show(v:count, 1, 1)<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

