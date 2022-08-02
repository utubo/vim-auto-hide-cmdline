# vim-auto-hide-cmdline

## Install
```vim
call dein#add('utubo/vim-auto-hide-cmdline')

" Example easy-motion.
" Before
"   map s <Plug>(easymotion-s)
" Add `<Plug>(ahc)`
map s <Plug>(ahc)<Plug>(easymotion-s)
```

## KEY-MAPPINGS

### `<Plug>(ahc)`
  Show the cmdline, and hide when leave the cmdline.<br>
  This delays by &updatetime msec.


### `<Plug>(ahc-nowait)`
  Show the cmdline, and hide when leave the cmdline.<br>
  This delays by 1 msec.<br>
  for a plugin that echos empty string at end.

##  Configurations
### g:auto_hide_cmdline_height
  default value: = `1`<br>
  Number of screen lines to use for the command-line.