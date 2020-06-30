if !exists('g:buffertree_compress')
    let g:buffertree_compress = 0
endif

if !exists('g:buffertree_path_sep')
    let g:buffertree_path_sep = '/'
endif

if !exists('g:buffertree_arrow')
    let g:buffertree_arrow = " ⇒ "
endif

command! BufferTree :call tree#BufferTree()
