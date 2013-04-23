function! redir#clear()
  let s:stack = []
  let s:vars = {}
  let s:current = ''
endfunction

function! redir#push(v)
  if len(s:stack) > 0
    exe 'redir END'
    if len(s:current) > 0
      let s:vars[s:stack[-1]] .= s:current[1:] . "\n"
    endif
  endif
  let s:vars[a:v] = ''
  call add(s:stack, a:v)
  let s:current = ''
  exe 'redir => s:current'
endfunction

function! redir#pop()
  if len(s:stack) > 0
    exe 'redir END'
    let k = s:stack[-1]
    let s:vars[k] .= s:current[1:] . "\n"
    let s:stack = s:stack[:-2]
  else
    throw "no redir stack"
  endif
  let s:current = ''
  if len(s:stack) > 0
    exe 'redir => s:current'
  end
  return s:vars[k]
endfunction

call redir#clear()
