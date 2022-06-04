# TODO:  - allow parsing for config file (.ch-config.yml)
#          file should allow for custom project names
function _cmake_helper --description "Initialize a cmake project with some basic cmake and clang-format configurations and/or run a compiled project"
   # colours
   set -l warning ef4444 
   set -l info    fbbf24
   set -l success 4ade80
   set -l reset   normal

   # abort function if no arguments passed in
   if [ (count $argv) -eq 0 ]
      set_color $warning; echo -e "\n   No argument recieved 😑" >&2
      set_color $info;    echo -e "   Type 'ch --help' for command usage and options" >&2
      set_color $reset
      return 1
   end

   set -l EXPECTED_ARGS win -h --help --clear -i --init -b --build release -r --run

   set -l dir     (eval pwd)
   set -l dir_rel (eval pwd)
   set -l project (string split -r -m1 / $dir)[2]
   set -l files   (eval fd -e h -e cpp -E build-release -E build-debug -E cmake-build-debug -X echo)
   set -l config  .ch-config.yml
   set -l bin     $project

   set -l GCC     (which gcc-11)
   set -l GPP     (which g++-11)
   set -l CMAKE   (which cmake)
   set -l MAKE    (which make)
   set -l gen     'CodeBlocks - Unix Makefiles'

   # create config file with name and append name to list of expected arguments
   getopts $argv | while read -l arg value
      if [ $arg = i ] || [ $arg = init ] && [ $value != true ]
         set -a EXPECTED_ARGS $value
         if [ -e $dir/$config ]
            set_color $warning; echo -e "\n   '$config' file already exists in this directory 🤨" >&2
            set_color $info;    echo -e "   Skipping file generation" >&2
            set_color $reset
         else
            set project $value
            set bin     $value
            touch $config
            yq -i ".project = \"$value\"" $config
         end
      end
   end

   # check if the arguments passed are found in the expected argument array
   # if the -i --init is passed and there is an error remove the config file
   for i in $argv
      if not contains -- $i $EXPECTED_ARGS
         set_color $warning; echo -e "\n   Unexpected argument '$i' recieved o((⊙﹏⊙))o." >&2
         set_color $info;    echo -e "   Type 'ch --help' for command usage and options" >&2
         set_color $reset
         if contains -- -i $argv || contains -- --init $argv
            test -e $dir/$config && rm $config
         end
         return 1
      end
   end

   # use the config file set the project name and bin name
   if [ -e $dir/$config ]
      set project (eval yq '.project' $config)
      set bin     $project
   end

   # if win argument is passed in, use windows cmake, gcc, c++ and make to build the project
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
            test -e $dir/.clangd        && rm .clangd
            set_color $info; echo -e "\n   Project cleared" >&1
            set_color $reset
            return 0
         case i init
            if [ -e $dir/.clang-format ]
               set_color $warning; echo -e "\n   '.clang-format' file already exists in this directory 🤨" >&2
               set_color $info;    echo -e "   Skipping file generation" >&2
               set_color $reset
            else
               echo "BasedOnStyle: Microsoft"               >> .clang-format >&1
               echo "IndentWidth: 3"                        >> .clang-format >&1
               echo "ColumnLimit: 120"                      >> .clang-format >&1
               echo "TabWidth: 3"                           >> .clang-format >&1
               echo "ConstructorInitializerIndentWidth: 3"  >> .clang-format >&1
               echo "ContinuationIndentWidth: 3"            >> .clang-format >&1
            end
            
            if [ -e $dir/CMakeLists.txt ]
               set_color $warning; echo -e "\n   'CMakeLists.txt' file already exists in this directory 🤨" >&2
               set_color $info;    echo -e "   Skipping file generation" >&2
               set_color $reset
            else
               echo "cmake_minimum_required(VERSION 3.21)"  >> CMakeLists.txt >&1
               echo "project($project)"                     >> CMakeLists.txt >&1
               echo "set(CMAKE_CXX_STANDARD 20)"            >> CMakeLists.txt >&1
               echo "add_executable($project $files)"       >> CMakeLists.txt >&1
            end

            if contains -- win $argv
               if [ -e $dir/.clangd ]
                  set_color $warning; echo -e "\n   '.clangd' file already exists in this directory 🤨" >&2
                  set_color $info;    echo -e "   Skipping file generation" >&2
                  set_color $reset
               else
                  touch .clangd
                  yq -I3 -i ".CompileFlags.Add = [\"--include-directory=/mnt/c/msys64/mingw64/x86_64-w64-mingw32/include\"]" .clangd
               end
            end
         case b build
            if ! [ -e $dir/CMakeLists.txt ]
               set_color $warning; echo -e "\n   No 'CMakeLists.txt' found 😑" >&2
               set_color $info;    echo "   Run 'ch [win] --init <name>' first to get started 🙂" >&2
               set_color $reset
               return 1
            end

            if [ $value = 'release' ]
               set_color $info; echo -e "\n   Building to 'build-release'...\n" >&1
               set_color $reset

               if [ -d $dir/build-release ]
                  eval \"$CMAKE\" --build \"$dir_rel/build-release\" --config Release --target $project -j 10 --
                  cd build-release && eval $MAKE

                  if ! [ $status = 0 ]
                     set -l stat $status
                     set_color $warning; echo -e "\n   Build Failed! 😵" >&2
                     set_color $reset
                     cd $dir
                     return $stat
                  end

                  cd $dir
               else
                  eval \"$CMAKE\" "-DCMAKE_C_COMPILER:FILEPATH=$GCC" \
                                  "-DCMAKE_CXX_COMPILER:FILEPATH=$GPP" \
                                  "-DCMAKE_BUILD_TYPE=Release" \
                                  -G \"$gen\" -S . \
                                  -B "build-release"

                  cd build-release && eval $MAKE

                  if ! [ $status = 0 ]
                     set -l stat $status
                     set_color $warning; echo -e "\n   Build Failed! 😵" >&2
                     set_color $reset
                     cd $dir
                     return $stat
                  end

                  cd $dir
               end

               set_color $success; echo -e "\n   Release build built to 'build-release' 🎊" >&2
               set_color $reset
               return 0
            else
               set_color $info; echo -e "\n   Building to 'build-debug'...\n" >&1
               set_color $reset

               if [ -d $dir/build-debug ]
                  eval \"$CMAKE\" --build \"$dir_rel/build-debug\" --config Debug --target $project -j 10 --
                  cd build-debug && eval $MAKE

                  if ! [ $status = 0 ]
                     set -l stat $status
                     set_color $warning; echo -e "\n   Build Failed! 😵" >&2
                     set_color $reset
                     cd $dir
                     return $stat
                  end

                  cd $dir
               else
                  eval \"$CMAKE\" "-DCMAKE_C_COMPILER:FILEPATH=$GCC" \
                                  "-DCMAKE_CXX_COMPILER:FILEPATH=$GPP" \
                                  "-DCMAKE_BUILD_TYPE=Debug" \
                                  -G \"$gen\" -S . \
                                  -B "build-debug"

                  cd build-debug && eval $MAKE
                  
                  if ! [ $status = 0 ]
                     set -l stat $status
                     set_color $warning; echo -e "\n   Build Failed! 😵" >&2
                     set_color $reset
                     cd $dir
                     return $stat
                  end

                  cd $dir
              end

               set_color $success; echo -e "\n   Project built to 'build-debug' 🎊" >&2
               set_color $reset
               return 0
            end
         case r run
            set -l b_dir build-debug
            [ $value = 'release' ] && set b_dir build-release

            if [ -d $dir/$b_dir ] && [ -e $dir/$b_dir/$bin ]
               set_color $success; echo -e "\n   Starting $bin....\n" >&2
               set_color $reset
               eval \"$dir/$b_dir/$bin\"                      
            else
               set_color $warning; echo -e "\n   No build directory or executable file found o((⊙﹏⊙))o." >&2
               set_color $info;    echo "   Run 'ch [win] --build' to build project" >&2
               set_color $reset
               return 1
            end
         case h help
            echo ""
            echo "Usage"
            echo "   ch [options]"
            echo "   ch win [options]"
            echo ""
            echo "Windows Executables"
            echo "   win                      = Passing 'win' argument forces the function to use Windows cmake, make and gcc/g++ compilers"
            echo "                              The resulting binary will be Windows executable (.exe file)"
            echo ""
            echo "Options"
            echo "   --clear                  = Deletes the following files/folders if present:"
            echo "                              'build-debug', 'build-release', 'CMakeLists.txt', '.clang-format', '.clangd', '.ch-config.yml'"
            echo "   -i, --init <string>      = Initialize project with Clion project structure with additional '.clang-format' file."
            echo "                              The default initialization will use the project directory name as the project name."
            echo "                              If a custom name is passed in, a new file '.ch-config.yml' will be generated with the custom project name."
            echo "                              To change the custom, manually change the 'project' property in the config file and in 'CMakeLists.txt'"
            echo "                              If 'win' argument is passed in, a '.clangd' file will be generated with the path to mingw64 windows header files"
            echo "   -b, --build [release]    = Rebuild the project after changes made (Requires 'ch -i' to be run first)."
            echo "                              If 'release' also passed in, a cmake release build of the project will be built."
            echo "   -h, --help               = View command options."
            echo "   -r, --run   [release]    = Runs the executable file in 'build-debug' folder"
            echo "                              If 'release' also passed in, runs the executable in 'build-release' folder."
            return 0
      end
   end
end

