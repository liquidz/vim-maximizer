" vim-maximizer - Maximizes and restores the current window
" Maintainer:   Szymon Wrozynski
" Version:      1.0.5
"
" Installation:
" Place in ~/.vim/plugin/maximizer.vim or in case of Pathogen:
"
"     cd ~/.vim/bundle
"     git clone https://github.com/szw/vim-maximizer.git
"
" License:
" Copyright (c) 2012-2015 Szymon Wrozynski and Contributors.
" Distributed under the same terms as Vim itself.
" See :help license
"
" Usage:
" See :help maximizer
" https://github.com/szw/vim-maximizer/blob/master/README.md

if exists('g:loaded_vim_maximizer') || &cp || v:version < 700
    finish
endif

let g:loaded_vim_maximizer = 1

if !exists('g:maximizer_restore_on_winleave')
    let g:maximizer_restore_on_winleave = 1
endif

fun! s:maximize()
    let t:maximizer_sizes = { 'before': winrestcmd() }
    vert resize | resize
    let t:maximizer_sizes.after = winrestcmd()
    normal! ze
endfun

fun! s:restore()
    if exists('t:maximizer_sizes')
        silent! exe t:maximizer_sizes.before
        if t:maximizer_sizes.before != winrestcmd()
            wincmd =
        endif
        unlet t:maximizer_sizes
        normal! ze
    end
endfun

command! MaximizerMaximize :call s:maximize()
command! MaximizerRestore :call s:restore()

if g:maximizer_restore_on_winleave
    augroup maximizer
        au!
        au WinLeave * call s:restore()
    augroup END
endif
