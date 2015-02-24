"============================================================================
"File:        jscs.vim
"Description: Javascript syntax checker - using jscs
"Maintainer:  LCD 47 <lcd047@gmail.com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

if exists("g:loaded_syntastic_jsx_jsxcs_checker")
    finish
endif
let g:loaded_syntastic_jsx_jsxcs_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_jsx_jsxcs_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'post_args': '--no-colors --esnext --reporter checkstyle --esprima=esprima-fb' })
    let errorformat = '%f:%t:%l:%c:%m'

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style',
        \ 'preprocess': 'checkstyle',
        \ 'returns': [0, 2] })

    call self.setWantSort(1)

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'jsx',
    \ 'name': 'jsxcs'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
