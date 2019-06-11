" Vim indent file
" Language         : Scala (http://scala-lang.org/)
" Original Author  : Stefan Matthias Aust
" Modifications by : Derek Wyatt
" Last Change: 2011 Mar 19 (Derek Wyatt)

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=scala#indent#GetScalaIndent()
setlocal indentkeys=0{,0},0),!^F,<>>,o,O,e,=case,<CR>

let b:undo_indent = get(b:, 'undo_indent', '')

if ! empty(b:undo_indent)
  let b:undo_indent .= ' | '
endif

let b:undo_indent .= 'setlocal autoindent< indentexpr< indentkeys<'
