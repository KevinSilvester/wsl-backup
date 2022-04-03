# TODO:  - make option for msys gcc compiler
#        - make code neater
function _cmake_helper --description "Initialize a cmake project with some basic cmake and clang-format configurations and/or run a compiled project"
   if [ (count $argv) -eq 1 ]
      set -l dir (eval pwd)
      set -l arg1 $argv[1]
      set -l project (string split -r -m1 / $dir)[2]

      switch $arg1
         case -i --init
            echo -e "---\nBasedOnStyle: Microsoft\nIndentWidth: '3'\n\n..." >> .clang-format
            echo "cmake_minimum_required(VERSION 3.20)" >> CMakeLists.txt
            echo "project($project)" >> CMakeLists.txt
            echo "set(CMAKE_CXX_STANDARD 17)" >> CMakeLists.txt
            echo "add_executable($project main.cpp)" >> CMakeLists.txt
            cmake --no-warn-unused-cli -DCAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_C_COMPILER:FILEPATH=(which gcc-11) -DCMAKE_CXX_COMPILER:FILEPATH=(which g++-11) -H(echo $dir) -B(echo $dir/build) -G Ninja
            cmake --build (echo $dir/build) --config Debug --target $project -j 10 --
            echo -e "\n"
            eval $dir/build/(string split -r -m1 / $dir)[2]
         case -c --compile
            cmake --build (echo $dir/build) --config Debug --target $project -j 10 --
            echo -e "\n"
            eval $dir/build/$project
         case -r --run
            eval $dir/build/$project
         case '*'
            echo "Unexpected argument recieved" >&2
      end
   else
      echo "1 arguments expected ( -i/--init | -c/--compile | -r/--run )" >&2
   end
end
