" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @GIT:         http://github.com/tomtom/vimtlib/
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2009-03-14.
" @Revision:    3
" GetLatestVimScripts: 0 0 :AutoInstall: tversions.vim

if &cp || exists("loaded_tversions")
    finish
endif
let loaded_tversions = 1

let s:save_cpo = &cpo
set cpo&vim


augroup TVersions
    autocmd BufWritePre * call tversions#IncreaseVersionNumber()
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
