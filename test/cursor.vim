set nomore
set rtp^=.
runtime plugin/caser.vim

function! s:finish() abort
  if empty(v:errors)
    qa!
  endif

  for error in v:errors
    echom error
  endfor
  cquit
endfunction

function! s:new_buffer(lines, lnum, col) abort
  enew!
  call setline(1, a:lines)
  call cursor(a:lnum, a:col)
endfunction

call s:new_buffer(['foo_bar baz_qux'], 1, 5)
call caser#ActionSetup('CamelCase')
normal! g@iw
call assert_equal('fooBar baz_qux', getline(1), 'normal charwise changes selected word')
call assert_equal([0, 1, 5, 0], getpos('.'), 'normal charwise preserves cursor')

call s:new_buffer(['foo_bar', 'baz_qux'], 1, 3)
call caser#ActionSetup('UpperCase')
normal! g@j
call assert_equal(['FOO_BAR', 'BAZ_QUX'], getline(1, 2), 'normal linewise changes selected lines')
call assert_equal([0, 1, 3, 0], getpos('.'), 'normal linewise preserves cursor')

call s:new_buffer(['foo_bar baz_qux'], 1, 1)
normal v6lgsc
call assert_equal('fooBar baz_qux', getline(1), 'visual mapping changes selected text')
call assert_equal([0, 1, 1, 0], getpos('.'), 'visual mapping preserves cursor')

call s:finish()
