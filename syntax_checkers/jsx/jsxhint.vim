"============================================================================
"File:        jsxhint.vim
"Description: JSX syntax checker - using jsxhint
"Maintainer:  Martin Grenfell <martin.grenfell at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

if exists('g:loaded_syntastic_jsx_jsxhint_checker')
    finish
endif
let g:loaded_syntastic_jsx_jsxhint_checker = 1

if !exists('g:syntastic_jsxhint_exec')
    let g:syntastic_jsxhint_exec = 'jsxhint'
endif

if !exists('g:syntastic_jsx_jsxhint_conf')
    let g:syntastic_jsx_jsxhint_conf = ''
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_jsx_jsxhint_IsAvailable() dict
    return executable(expand(g:syntastic_jsxhint_exec))
endfunction

function! SyntaxCheckers_jsx_jsxhint_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'exe': expand(g:syntastic_jsxhint_exec),
        \ 'args_after': '--verbose --jsx-only ' })

    let errorformat = '%A%f: line %l\, col %v\, %m \(%t%*\d\)'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': {'bufnr': bufnr('')},
        \ 'returns': [0, 1, 2] })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'jsx',
    \ 'name': 'jsxhint'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
