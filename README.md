# vim-auto-hide-cmdline

vim-auto-hide-cmdline is a Vim plugin to prevent wating for Enter when cmdheight is 0.

## Install
```vim
call dein#add('utubo/vim-auto-hide-cmdline')

" Example easy-motion.
" Before
"   map s <Plug>(easymotion-s)
" You can add `<Plug>(ahc)` to prevent waiting for Enter.
map s <Plug>(ahc)<Plug>(easymotion-s)
```

## KEY-MAPPINGS

### `<Plug>(ahc)`
  Show the cmdline, and hide when leave the cmdline.<br>
  This delays by `&updatetime` msec.


### `<Plug>(ahc-nowait)`
  Show the cmdline, and hide when leave the cmdline.<br>
  This delays by 1 msec.<br>
  for a plugin that echos empty string at end.

### `<Plug>(ahc-switch)`
  Switch the cmdline and the statusline.
  This does not prevent waiting for Enter.
  ```vim
  " Example
  nnoremap : <Plug>(ahc-switch):
  vnoremap : <Plug>(ahc-switch):
  nnoremap / <Plug>(ahc-switch)/
  nnoremap ? <Plug>(ahc-switch)?
  " save original :
  nnoremap <Leader>: :
  ```

##  Configurations

### `g:auto_hide_cmdline_height`
  default value: = `1`<br>
  Number of screen lines to use for the command-line.

### `g:auto_hide_cmdline_switch_statusline`
  default value: unlet<br>
              `1`: When show the cmdline, hide the statusline.

