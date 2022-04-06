# TODO:  - make option for msys gcc compiler
#        - make code neater
#        - dynically add check for and add header and c++ files "add_executable"
function _cmake_helper --description "Initialize a cmake project with some basic cmake and clang-format configurations and/or run a compiled project"
   # colours
   set -l warning ef4444 
   set -l info    fbbf24
   set -l success 4ade80
   set -l reset   normal

   if [ (count $argv) -gt 0 ]
      set -l dir     (eval pwd)
      set -l project (string split -r -m1 / $dir)[2]
      set -l files   (eval fd -e h -e cpp -E release -E build -E cmake-build-debug -X echo)
      set -l config  .ch-config.yml

      set -l GCC (which gcc-11)
      set -l GPP (which g++-11)

      # if [ -e $dir/$config ]
      #    set project (eval yq '.project' $config)
      # end

      getopts $argv | while read -l arg value
         switch $arg
            case _
               if [ $value = 'win' ]
                  set GCC C:/msys64/mingw64/bin/gcc.exe
                  set GPP C:/msys64/mingw64/bin/g++.exe
                  set dir (string replace '/mnt/c' 'C:' (pwd))
               end
            case clear
               test -d $dir/build-release;  and rm -r build-release
               test -d $dir/build-debug;    and rm -r build-debug
               test -e $dir/CMakeLists.txt; and rm CMakeLists.txt
               test -e $dir/.clang-format;  and rm .clang-format
               set_color $info; echo -e "\nProject cleared" >&1
               set_color $reset
               return
            case i init
               # touch $config
               # yq -i ".project = \"$project\"" $config
               echo -e "BasedOnStyle: Google\nIndentWidth: '3'\nColumnWidth: 100"   >> .clang-format >&1
               echo "cmake_minimum_required(VERSION 3.20)"  >> CMakeLists.txt >&1
               echo "project($project)"                     >> CMakeLists.txt >&1
               echo "set(CMAKE_CXX_STANDARD 17)"            >> CMakeLists.txt >&1
               echo "add_executable($project $files)"       >> CMakeLists.txt >&1

               cmake --no-warn-unused-cli \
                     -DCAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
                     -DCMAKE_BUILD_TYPE:STRING=Debug \
                     -DCMAKE_C_COMPILER:FILEPATH=$GCC \
                     -DCMAKE_CXX_COMPILER:FILEPATH=$GPP \
                     -H(echo $dir) -B(echo $dir/build-debug) -G Ninja

               cmake -DCMAKE_BUILD_TYPE:STRING=Debug \
                     -DCMAKE_C_COMPILER:FILEPATH=(which gcc-11) \
                     -DCMAKE_CXX_COMPILER:FILEPATH=(which g++-11) \
                     -B(echo (pwd)/build-debug) -G Ninja

               set_color $success; echo -e "\n'🎊 CMakeLists.txt', '.clang-format' and 'build-debug' created 🎊" >&2
               set_color $reset
            case b build
               if [ $value = 'release' ]
                  if [ -d $dir/build-release ]
                     cmake --build \"$dir/build-release\" --config Release --target $project -j 10 --

                     set_color $success; echo -e "\nRelease build built to 'build-release'" >&2
                     set_color $reset
                     return 0
                  else
                     cmake --no-warn-unused-cli \
                        -DCMAKE_BUILD_TYPE:STRING=Release \
                        -DCMAKE_C_COMPILER:FILEPATH=(which gcc-11) \
                        -DCMAKE_CXX_COMPILER:FILEPATH=(which g++-11) \
                        -H(echo $dir) -B(echo $dir/build-release) -G Ninja

                     cmake --build $dir/build-release --config Release --target $project -j 10 --

                     set_color $success; echo -e "\nRelease build built to 'build-release'" >&2
                     set_color $reset
                     return 0
                  end
               else
                  if [ -d $dir/build-debug ]
                     cmake --build $dir/build-debug --config Debug --target $project -j 10 --
                     set_color $success; echo -e "\nProject built to 'build-debug'" >&2
                     set_color $reset
                  else
                     set_color $warning; echo -e "\nNo build directory found" >&2 
                     set_color $info;    echo "Run 'ch --init' first to initialize project with build directory" >&2
                     set_color $reset
                     return 1
                  end
               end
            case r run
               if [ -d $dir/build-debug ]; and [ -e $dir/build-debug/$project ]
                  eval \"$dir/build-debug/$project\"                      
               else
                  set_color $warning; echo -e "\nNo build directory or executable file found" >&2
                  set_color $info;    echo "Run 'ch --build' to build project" >&2
                  set_color $reset
                  return 1
               end
            case '*'
               set_color $warning; echo -e "\nUnexpected argument recieved" >&2
               set_color $info;    echo "Arguments expected ( -i/--init | -b/--build [release] | -r/--run | --clear )" >&2
               set_color $reset
               return 1
         end
      end
   else
      set_color $info; echo -e "\nArguments expected ( -i/--init | -b/--build [release] | -r/--run | --clear )" >&2
      set_color $reset
      return 1
   end
end

