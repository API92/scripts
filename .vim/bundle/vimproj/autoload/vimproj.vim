
function! vimproj#UpdateCommands()
    let g:compiler_id = get(g:, 'compiler_id', 'GNU')

    if g:compiler_id ==# 'Clang'
        let cxx = '/usr/bin/clang++'
        let cc  = '/usr/bin/clang'
    elseif g:compiler_id ==# 'GNU'
        let cxx = '/usr/bin/g++'
        let cc = '/usr/bin/gcc'
    else
        echoerr 'Unknown compiler "'.g:compiler_id.'"'
        return
    endif

    let g:build_type = get(g:, 'build_type', 'Debug')
    if !get(g:, 'custom_build_dir', 0)
        let g:build_dir = getcwd().'/build/'.g:compiler_id.'/'.g:build_type
    endif

    let &makeprg = 'time cmake --build "'.g:build_dir.'" -- -j '.(system('nproc --all') + 1)

    execute 'command! -nargs=* Cmake :!cmake -H. "-B'.g:build_dir
                \.'" -DCMAKE_CXX_COMPILER="'.cxx.'" -DCMAKE_C_COMPILER="'.cc
                \.'" -DCMAKE_BUILD_TYPE='.g:build_type
                \.' -DCMAKE_EXPORT_COMPILE_COMMANDS=on <args>'
                \.' && '
                \.'ln -s "'.g:build_dir.'/compile_commands.json" "compile_commands.json" '
endfunction

function! vimproj#SetCompilerId(compiler_id)
    if a:compiler_id ==? 'Clang'
        let g:compiler_id = 'Clang'
    elseif a:compiler_id ==? 'GNU' || a:compiler_id == 'g++' ||
          \a:compiler_id == 'gcc'
        let g:compiler_id = 'GNU'
    else
        let g:compiler_id = a:compiler_id
    endif
    call vimproj#UpdateCommands()
endfunction

function! vimproj#SetBuildType(build_type)
    if a:build_type ==? 'Debug'
        let g:build_type = 'Debug'
    elseif a:build_type ==? 'Release'
        let a:build_type = 'Release'
    else
        let g:build_type = a:build_type
    endif
    call vimproj#UpdateCommands()
endfunction

function vimproj#SetBuildDir(build_dir)
    let g:build_dir = a:build_dir
    let g:custom_build_dir = 1
    call vimproj#UpdateCommands()
endfunction

function! vimproj#Proj(...)
    if a:0 >= 1
        let compiler_id = a:1
    else
        let compiler_id = 'GNU'
    endif
    call vimproj#SetCompilerId(compiler_id)

    if a:0 >= 2
        let build_type = a:2
    else
        let build_type = 'Debug'
    endif
    call vimproj#SetBuildType(build_type)

    if a:0 >= 3
        call vimproj#SetBuildDir(a:3)
    else
        let g:custom_build_dir=0
    endif

    NERDTree
endfunction
