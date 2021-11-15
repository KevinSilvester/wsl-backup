# Helper function to make using git easier
# Usage:
#  --r         to remove git ignore file
#  --ra        to remove git folder and git ignore file
#  -m          to create gitignore file for mern app
#  -w          to create gitignore file for gereral web apps
#  -i          initialise git repo without linking to remote repo
#  -i:<arg>    initialise git repo, add link to remote repo after ':'
#  -ip:<arg>   initialise git repo, add link to remote repo after ':', and push to remote
#  -p:<arg>    add, commit and push to repo. enter commit message as argument.
#  -pd         add, commit and push to repo. No 'arg' means commit message will be date
#  -pd:<arg>   add, commit and push to repo. Commit message will be message date and string in 'arg'
git_helper() {
   touch .gitignore
   if [[ $# -gt 0 ]]; then
      for arg in "$@"; do
         [[ $arg = -* ]] || echo "$arg" >> \.gitignore;
         case $arg in
            --r)
               rm \.gitignore
               ;;
            --ra)
               rm -rf \.git \.gitignore
               ;;
            -m)
               echo "**/node_modules"        >> \.gitignore;
               echo "*/yarn.lock"            >> \.gitignore;
               echo "*/build"                >> \.gitignore;
               echo "*/dist*"                >> \.gitignore;
               echo "*/pnpm-lock.yaml"       >> \.gitignore;
               echo "client/.pnp"            >> \.gitignore;
               echo "client/.pnp.js"         >> \.gitignore;
               echo "client/coverage"        >> \.gitignore;
               echo "client/.DS_Store"       >> \.gitignore;
               echo "client/.env.local"      >> \.gitignore;
               echo "client/.env*"           >> \.gitignore;
               echo "client/npm-debug.log*"  >> \.gitignore;
               echo "client/yarn-debug.log*" >> \.gitignore;
               echo "client/yarn-error.log*" >> \.gitignore;
               echo "server/pnpm-lock.yaml"  >> \.gitignore;
               ;;
            -w)
               echo "node_modules"     >> \.gitignore;
               echo "yarn.lock"        >> \.gitignore;
               echo "pnpm-lock.yaml"   >> \.gitignore;
               echo ".pnp"             >> \.gitignore;
               echo ".pnp.js"          >> \.gitignore;
               echo "coverage"         >> \.gitignore;
               echo "build"            >> \.gitignore;
               echo "dist*"            >> \.gitignore;
               echo ".DS_Store"        >> \.gitignore;
               echo ".env.local"       >> \.gitignore;
               echo ".env*"            >> \.gitignore;
               echo "npm-debug.log*"   >> \.gitignore;
               echo "yarn-debug.log*"  >> \.gitignore;
               echo "yarn-error.log*"  >> \.gitignore;
               ;;
            -i*)
               git init;
               git add \.;
               git commit -m "first commit";
               git branch -M main;
               [ ${#arg} -gt 2 ] && case $arg in
                     -ip*) git remote add origin $(echo $arg | cut -b 5-); git push -u origin main; ;;
                     *)    git remote add origin $(echo $arg | cut -b 4-) ;;
                  esac
               ;;
            -p*)
               git add \.;
               case $arg in
                  -pd:*)   git commit -m "$(echo $(date +%d-%m-%Y)) $(echo $arg | cut -b 5-)"; ;;
                  -pd)     git commit -m "$(echo $(date +%d-%m-%Y))"; ;;
                  *)       git commit -m  "$(echo $arg | cut -b 4-)"; ;;
               esac
               git push -u origin main;
               ;;
         esac
      done
   fi
}