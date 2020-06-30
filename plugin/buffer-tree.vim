let s:arrow = get(g:, "buffertree_arrow", " ⇒ ")
let s:path_sep = get(g:, "buffertree_path_sep", "/")
let s:hidden_sep = "|||"
let s:compress = get(g:, "buffertree_compress", 0)

echohl None

function! GetTree(buffer_numbers)

  let tree = {}

  for buffer_number in a:buffer_numbers

    let file_path = split(expand("#" . string(buffer_number) . ":p"), s:path_sep)
    let dir = tree
    for step in file_path

      " check if this is the end
      if len(file_path) == 1
        let dir[step] = buffer_number
      else
        if !has_key(dir, step)
          let dir[step] = {}
        endif
        let dir = dir[step]
      endif

      let file_path = file_path[1:]

    endfor
  endfor

  return tree
endfunction

function! FillWhitespace(n, lines)

  let space = ""

  for i in range(a:n)
    if index(a:lines, i) == -1
      let space = space . " "
    else
      let space = space . "│"
    endif
  endfor

  return space

endfunction

function! GetLinesHelper(tree, lines, offset, vlines, fill)

  let items = items(a:tree)

  while len(items) > 0

    " pop
    let [key, value] = items[0]
    let items = items[1:]

    if len(items) > 0
      let last = 0
      let pipe = "├─ "

    else
      let pipe = "└─ "
      let last = 1

    endif

    if type(value) is v:t_dict

      call add(a:lines, FillWhitespace(a:offset, a:vlines) . pipe . key)
      if last == 1
        call GetLinesHelper(value, a:lines, a:offset + 3, a:vlines, last)
      else
        call GetLinesHelper(value, a:lines, a:offset + 3, a:vlines + [a:offset], last)
      endif

    else

      if a:fill
        call add(a:lines, FillWhitespace(a:offset, a:vlines) . pipe . s:hidden_sep . key . s:arrow . value)
      else
        call add(a:lines, FillWhitespace(a:offset, a:vlines[:-1]) . pipe . s:hidden_sep . key . s:arrow . value)
      endif

    endif

  endwhile

endfunction

function! GetLines(tree)
  let lines = []
  call GetLinesHelper(a:tree, lines, 0, [], 1)
  return lines
endfunction

function! CompressTree(tree)

    let sep = "/"

    if type(a:tree) is v:t_dict
      for [k1, v1] in items(a:tree)

        let a:tree[k1] = CompressTree(v1)

        if type(v1) is v:t_dict && len(items(v1)) == 1

          let [k2, v2] = items(v1)[0]
          let a:tree[k1 . sep . k2] = v2
          call remove(a:tree, k1)

        endif

      endfor
    endif
    return a:tree

endfunction

function! BufferTree()

  let buffer_numbers = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val.bufnr')
  let tree = GetTree(buffer_numbers)

  if s:compress == 1
    let tree = CompressTree(tree)
  endif

  let lines = GetLines(tree)

  for line in lines

    if stridx(line, s:hidden_sep) != -1
      let sections = split(line, s:hidden_sep)
      echo sections[0]
      echohl BufferTreeFile
      echon sections[1]
      echohl None

    else
      echo line

    endif

  endfor

endfunction

command! BufferTree call BufferTree()
