function bird_fix_version
  # paths
  set -l P_RUST     "$HOME/rust"
  set -l P_BIRD     "$P_RUST/bird"
  set -l P_BIRD_V2  "$P_RUST/bird-v2"

  # git repo link
  set -l BIRD_REPO  "https://github.com/KevinSilvester/bird.git"

  # correct versions
  set -l VERSIONS (cat "$P_RUST/versions.txt")

  # commands
  set -l COPY_CMD   "rsync -a --quiet --delete --exclude .git $P_BIRD/* $P_BIRD_V2 && cp $P_BIRD/{.gitignore, .rustfmt.toml} $P_BIRD_V2"
  set -l RESET_CMD  "cd $P_RUST && rm -rf $P_BIRD && git clone $BIRD_REPO"

  # create bird-v2 dir
  rm -rf $P_BIRD_V2; mkdir $P_BIRD_V2

  # go to bird repo
  eval $RESET_CMD; cd $P_BIRD

  # get count of all commits
  set -l COMMIT_COUNT (git rev-list --count main)

  # set git variables
  set -l COMMIT_HASH  (git log --reverse --pretty=format:"%H")
  set -l COMMIT_TS    (git log --reverse --pretty=format:"%ad")
  set -l COMMIT_MSGS  (git log --reverse --pretty=format:"%s")
  
  cd $P_BIRD_V2 && git init
  git branch -M main

  echo $VERSIONS

  for i in (seq $COMMIT_COUNT)
    # go to bird repo
    eval $RESET_CMD; cd $P_BIRD

    # checkout repo with commit hash
    git checkout --quiet $COMMIT_HASH[$i]

    # copy the repo files to bird-v2 and cd
    eval $COPY_CMD; cd $P_BIRD_V2

    set_color green; echo "commit no.$i"; set_color normal;
    set_color blue; echo "commit hash $COMMIT_HASH[$i]"; set_color normal;

    # update version
    cat "$P_BIRD_V2/Cargo.toml" | sd \
      "version = \"$(dasel -f "$P_BIRD_V2/Cargo.toml" '.package.version')\"" \
      "version = \"$VERSIONS[$i]\"" > "$P_BIRD_V2/Cargo.toml.tmp"

    rm "$P_BIRD_V2/Cargo.toml"
    mv "$P_BIRD_V2/Cargo.toml.tmp" "$P_BIRD_V2/Cargo.toml"

    bcat "$P_BIRD_V2/Cargo.toml" 

    set -l ver (dasel -f Cargo.toml '.package.version')

    set_color yellow; echo -e "\npackage version: $ver";
    set_color yellow; echo -e "commit message:  $COMMIT_MSGS[$i]"; set_color normal;

    git add .
    git commit --message $COMMIT_MSGS[$i] --date="$COMMIT_TS[$i]"
    git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"'
    git remote add origin https://github.com/KevinSilvester/bird-v2.git
    git push -u origin main
  end
end
