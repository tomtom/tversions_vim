" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-02-25.
" @Revision:    17


if !exists('g:tversions#defs')
    " :read: let g:tversions#defs = {...}   "{{{2
    " Can be extended by |g:tversions|.
    " Can be buffer-local as b:tversions.
    let g:tversions#defs = {
                \ 'last change': {
                \   'marker_rx': '@Last Change:\s\+\zs\d\+-\d\+-\d\+',
                \   'group_idx': -1,
                \   'inc': 'strftime("%Y-%m-%d")',
                \   },
                \ 'rev': {
                \   'marker_rx': '@Revision:\s\+\(RC\d*\|pre\d*\|p\d\+\|-\?\d\+\)\.\zs-\?\d\+',
                \   'inc': '%s + 1',
                \   },
                \ }
endif


if exists('g:tversions')
    let g:tversions#defs = extend(g:tversions#defs, g:tversions)
endif


function! tversions#IncreaseVersionNumber() "{{{3
    if exists('b:tversions')
        let defs = b:tversions
    else
        let defs = g:tversions#defs
    endif
    let pos = getpos('.')
    let rs  = @/
    try
        for def in values(defs)
            let group_idx = get(def, 'group_idx', 0)
            if group_idx >= 0
                let inc = printf(def.inc, 'submatch('. group_idx .')')
            else
                let inc = def.inc
            endif
            silent exec '%s/'. def.marker_rx .'/\='. inc .'/e'
        endfor
    finally
        let @/ = rs
        call setpos('.', pos)
    endtry
endf

