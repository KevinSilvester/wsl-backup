# TODO:  - allow parsing for config file (.ch-config.yml)
#          file should allow for custom project names
function _cmake_helper --description "Initialize a cmake project with some basic cmake and clang-format configurations and/or run a compiled project"
   # colours
   set -l warning ef4444 
   set -l info    fbbf24
   set -l success 4ade80
   set -l reset   normal

   if [ (count $argv) -gt 0 ]
      set -l EXPECTED_ARGS win -h --help --clear -i --init -b --build release -r --run

      set -l dir     (eval pwd)
      set -l dir_rel (eval pwd)
      set -l project (string split -r -m1 / $dir)[2]
      set -l files   (eval fd -e h -e cpp -E release -E build -E cmake-build-debug -X echo)
      set -l config  .ch-config.yml
      set -l bin     $project

      set -l GCC     (which gcc-11)
      set -l GPP     (which g++-11)
      set -l CMAKE   (which cmake)
      set -l MAKE    (which make)
      set -l gen     'CodeBlocks - Unix Makefiles'

      # create config file with name and append name to list of expected arguments
      getopts $argv | while read -l arg value
         if [  $arg = i ] || [ $arg = init ] && [ $value != true ]
            set project $value
            set bin     $value
            set -a EXPECTED_ARGS $value
            touch $config
            yq -i ".project = \"$value\"" $config
         end
      end

      # check if the arguments passed are found in the expected argument array
      # if the -i --init is passed and there is an error remove the config file
      for i in $argv
         if not contains -- $i $EXPECTED_ARGS
            set_color $warning; echo -e "\nUnexpected argument recieved" >&2
            set_color $reset
            if contains -- -i $argv || contains -- --init $argv
               test -e $dir/$config && rm $config
            end
            return 1
         end
      end

      # use the 
      if [ -e $dir/$config ]
         set project (eval yq '.project' $config)
         set bin     $project
      end

      if contains win $argv
         set dir_rel (string replace '/mnt/c' 'C:' (pwd))
         set bin     $project.exe

         set GCC     C:/msys64/mingw64/bin/gcc.exe
         set GPP     C:/msys64/mingw64/bin/g++.exe
         set CMAKE   '/mnt/c/Program Files/CMake/bin/cmake.exe'
         set GEN     'CodeBlocks - MinGW Makefiles'
         set MAKE    '/mnt/c/Users/kevin/scoop/apps/make/current/bin/make.exe'
      end

      getopts $argv | while read -l arg value
         switch $arg
            case clear
               test -d $dir/build-release  && rm -r build-release
               test -d $dir/build-debug    && rm -r build-debug
               test -e $dir/CMakeLists.txt && rm CMakeLists.txt
               test -e $dir/.clang-format  && rm .clang-format
               test -e $dir/$config        && rm $config
               set_color $info; echo -e "\nProject cleared" >&1
               set_color $reset
               return
            case i init
               echo -e "BasedOnStyle: Google\nIndentWidth: '3'\nColumnWidth: 100"   >> .clang-format >&1
               echo "cmake_minimum_required(VERSION 3.21)"  >> CMakeLists.txt >&1
               echo "project($project)"                     >> CMakeLists.txt >&1
               echo "set(CMAKE_CXX_STANDARD 14)"            >> CMakeLists.txt >&1
               echo "add_executable($project $files)"       >> CMakeLists.txt >&1
            case b build
               if [ -e $dir/CMakeLists.txt ]
                  if [ $value = 'release' ]
                     if [ -d $dir/build-release ]
                        eval \"$CMAKE\" --build \"$dir_rel/build-release\" --config Release --target $project -j 10 --
                        cd build-release && eval $MAKE && cd ..
                        set_color $success; echo -e "\nRelease build built to 'build-release'" >&1
                        set_color $reset
                        return 0
                     else
                        eval \"$CMAKE\" "-DCMAKE_C_COMPILER:FILEPATH=$GCC" \
                                        "-DCMAKE_CXX_COMPILER:FILEPATH=$GPP" \
                                        "-DCMAKE_BUILD_TYPE=Release" \
                                        -G \"$gen\" -S . \
                                        -B "build-release"

                        cd build-release && eval $MAKE && cd ..

                        set_color $success; echo -e "\nRelease build built to 'build-release'" >&2
                        set_color $reset
                        return 0
                     end
                  else
                     if [ -d $dir/build-debug ]
                        eval \"$CMAKE\" --build \"$dir_rel/build-debug\" --config Debug --target $project -j 10 --
                        cd build-debug && eval $MAKE && cd ..
                        set_color $success; echo -e "\nProject built to 'build-debug'" >&2
                        set_color $reset
                        return 0
                     else
                        eval \"$CMAKE\" "-DCMAKE_C_COMPILER:FILEPATH=$GCC" \
                                        "-DCMAKE_CXX_COMPILER:FILEPATH=$GPP" \
                                        "-DCMAKE_BUILD_TYPE=Debug" \
                                        -G \"$gen\" -S . \
                                        -B "build-debug"

                        cd build-debug && eval $MAKE && cd ..

                        set_color $success; echo -e "\nDebug build built to 'build-debug'" >&2
                        set_color $reset
                        return 0
                     end
                  end
               else
                  set_color $warning; echo -e "\nNo 'CMakeLists.txt' found" >&2
                  set_color $info;    echo "Run 'ch [win] --init <name>' first to get started" >&2
                  set_color $reset
                  return 1
               end
            case r run
            echo  $dir/build-debug/$bin
               if [ -d $dir/build-debug ] && [ -e $dir/build-debug/$bin ]
                  set_color $success; echo -e "\nStarting $bin....\n" >&2
                  set_color $reset
                  eval \"$dir/build-debug/$bin\"                      
               else
                  set_color $warning; echo -e "\nNo build directory or executable file found" >&2
                  set_color $info;    echo "Run 'ch [win] --build' to build project" >&2
                  set_color $reset
                  return 1
               end
            case h help
               echo "Usage"
               echo "   ch [win] [...options]"
               echo ""
               echo "Windows Executables"
               echo "   win                      = Passing 'win' argument forces the function to use Windows cmake, make and gcc/g++ compilers"
               echo "                              The resulting binary will be Windows executable (.exe file)"
               echo ""
               echo "Options"
               echo "   --clear                  = Deletes the following files/folders if present:"
               echo "                                 'build-debug', 'build-release', 'CMakeLists.txt', '.clang-format'"
               echo "   -i, --init <name>        = Initialize project with Clion project structure with additional '.clang-format' file."
               echo "                              The default initialization will use the project directory name as the project name."
               echo "                              If a custom name is passed in, a new file '.ch-config.yml' will be generated with the custom project name."
               echo "                              To change the custom, manually change the 'project' property in the config file and in 'CMakeLists.txt'"
               echo "   -b, --build [release]    = Rebuild the project after changes made (Requires 'ch -i' to be run first)."
               echo "                              If 'release' also passed in, a cmake release build of the project will be built."
               echo "   -r, --run                = Runs the executable file in 'build-debug' folder"
               return 0
         end
      end
   else
      set_color $info; echo -e "\nNo argument recieved" >&2
      set_color $reset
      return 1
   end
end

