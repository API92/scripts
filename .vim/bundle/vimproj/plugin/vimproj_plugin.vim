
command! -nargs=* Proj :call vimproj#Proj(<f-args>)
command! -nargs=1 Compiler :call vimproj#SetCompilerId(<f-args>)
command! -nargs=1 BuildType :call vimproj#SetBuildType(<f-args>)
command! -nargs=1 BuildDir :call vimproj#SetBuildDir(<f-args>)
