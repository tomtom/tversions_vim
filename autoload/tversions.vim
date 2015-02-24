" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2008-09-19.
" @Revision:    9

if !exists('g:tversions#marker_rx')
    let g:tversions#marker_rx = '@Revision:\s\+'   "{{{2
endif

if !exists('g:tversions#number_rx')
    let g:tversions#number_rx = '\(RC\d*\|pre\d*\|p\d\+\|-\?\d\+\)\.'   "{{{2
endif

if !exists('g:tversions#group_idx')
    let g:tversions#group_idx = 3   "{{{2
endif


function! tversions#IncreaseVersionNumber() "{{{3
    let rev = exists("b:tversions_marker_rx") ? b:tversions_marker_rx : g:tversions#marker_rx
    let ver = exists("b:tversions_number_rx")  ? b:tversions_number_rx : g:tversions#number_rx
    let pos = getpos('.')
    let rs  = @/
    try
        silent exec '%s/'.rev.'\('.ver.'\)*\zs\(-\?\d\+\)/\=(submatch(g:tversions#group_idx) + 1)/e'
    finally
        let @/ = rs
        call setpos('.', pos)
    endtry
endf

