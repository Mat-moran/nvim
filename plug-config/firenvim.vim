" delays and poor user experience
set updatetime=50

let g:firenvim_config = {
      \ 'globalSettings': {
          \ 'alt': 'all',
      \ },
      \ 'localSettings': {
      \ '.*': {
          \ 'cmdline': 'neovim',
          \ 'priority': 0,
          \ 'selector': 'textarea',
          \ 'takeover': 'always',
        \},
      \},
    \}

let fc = g:firenvim_config['localSettings']
let fc['https?://https://mail.google.com/mail/'] = { 'takeover': 'never', 'priority': 1 }
