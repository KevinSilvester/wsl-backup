# TODO:  - make option for msys gcc compiler
#        - make code neater
function _cmake_helper --description "Initialize a cmake project with some basic cmake and clang-format configurations and/or run a compiled project"
   if [ (count $argv) -gt 0 ]
      set -l dir     (eval pwd)
      set -l project (string split -r -m1 / $dir)[2]

      # colours
      set -l warning ef4444 
      set -l info    fbbf24 
      set -l reset   normal

      getopts $argv | while read -l arg value
         switch $arg
            case i init
               echo -e "---\nBasedOnStyle: Microsoft\nIndentWidth: '3'\n\n..."   >> .clang-format >&1
               echo "cmake_minimum_required(VERSION 3.20)"  >> CMakeLists.txt >&1
               echo "project($project)"                     >> CMakeLists.txt >&1
               echo "set(CMAKE_CXX_STANDARD 17)"            >> CMakeLists.txt >&1
               echo "add_executable($project main.cpp)"     >> CMakeLists.txt >&1

               cmake --no-warn-unused-cli \
                     -DCAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
                     -DCMAKE_BUILD_TYPE:STRING=Debug \
                     -DCMAKE_C_COMPILER:FILEPATH=(which gcc-11) \
                     -DCMAKE_CXX_COMPILER:FILEPATH=(which g++-11) \
                     -H(echo $dir) -B(echo $dir/build) -G Ninja

               echo -e "\n" >&1
            case c compile
               if [ -d $dir/build ]
                  cmake --build (echo $dir/build) --config Debug --target $project -j 10 --
                  echo -e "\n" >&1
               else
                  set_color $warning; echo -e "No build directory found" >&2 
                  set_color $info;    echo "Run 'ch --init' first" >&2
                  set_color $reset
                  return 1
               end
            case r run
               if [ -d $dir/build ]; and [ -e $dir/build/$project ]
                  eval $dir/build/$project                      
               else
                  set_color $warning; echo "No build directory or compiled file found" >&2
                  set_color $info;    echo "Run 'ch --compile' to compile project" >&2
                  set_color $reset
                  return 1
               end
            case '*'
               set_color $warning; echo "Unexpected argument recieved" >&2
               set_color $info;    echo "Arguments expected ( -i/--init | -c/--compile | -r/--run )" >&2
               set_color $reset
               return 1
         end
      end
   else
      echo -e "\n" >&2
      echo "Arguments expected ( -i/--init | -c/--compile | -r/--run )" >&2
      return 1
   end
end
