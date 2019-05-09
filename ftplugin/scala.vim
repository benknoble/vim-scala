" Vim filetype plugin
" Language:             Scala
" Maintainer:           Derek Wyatt
" URL:                  https://github.com/derekwyatt/vim-scala
" License:              Apache 2
" ----------------------------------------------------------------------------

if exists('b:did_ftplugin') || &cp
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty(b:undo_ftplugin)
  let b:undo_ftplugin .= ' | '
endif

" j is fairly new in Vim, so don't complain if it's not there
setlocal formatoptions-=t formatoptions+=croqnl
silent! setlocal formatoptions+=j
let b:undo_ftplugin .= 'setlocal formatoptions< | '

" Just like c.vim, but additionally doesn't wrap text onto /** line when
" formatting. Doesn't bungle bulleted lists when formatting.
if get(g:, 'scala_scaladoc_indent', 0)
  setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s2:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://
else
  setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://
endif
setlocal commentstring=//\ %s
let b:undo_ftplugin .= 'setlocal comments< commentstring< | '

setlocal shiftwidth=2 softtabstop=2 expandtab
let b:undo_ftplugin .= 'setlocal shiftwidth< softtabstop< expandtab< | '

setlocal include='^\s*import'
setlocal includeexpr='substitute(v:fname,"\\.","/","g")'
let b:undo_ftplugin .= 'setlocal include< includeexpr< | '

setlocal path+=src/main/scala,src/test/scala
setlocal suffixesadd=.scala
let b:undo_ftplugin .= 'setlocal path< suffixesadd< | '

function! s:CreateOrExpression(keywords)
  return '('.join(a:keywords, '|').')'
endfunction

function! s:NextSection(backwards)
  if a:backwards
    let dir = '?'
  else
    let dir = '/'
  endif
  let keywords = [ 'def', 'class', 'trait', 'object' ]
  let keywordsOrExpression = s:CreateOrExpression(keywords)

  let modifiers = [ 'public', 'private', 'private\[\w*\]', 'protected', 'abstract', 'case', 'override', 'implicit', 'final', 'sealed']
  let modifierOrExpression = s:CreateOrExpression(modifiers)

  let regex = '^ *('.modifierOrExpression.' )* *'.keywordsOrExpression."\r"
  execute 'silent normal! ' . dir . '\v'.regex
endfunction

nnoremap <script> <buffer> <silent> ]] :call <SID>NextSection(0)<cr>
nnoremap <script> <buffer> <silent> [[ :call <SID>NextSection(1)<cr>
let b:undo_ftplugin .= "execute 'silent! nunmap <buffer> ]]' | "
let b:undo_ftplugin .= "execute 'silent! nunmap <buffer> [[' | "

let b:undo_ftplugin = trim(b:undo_ftplugin, ' |')
