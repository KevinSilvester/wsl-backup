set fish_greeting

set -e fish_user_paths
set -U fish_user_paths $HOME/.cargo/bin $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $HOME/.pyenv/bin  $HOME/.local/bin $HOME/.nvm/bin $fish_user_paths

# fish_add_path "$HOME/.cargo/bin:$PATH"
# fish_add_path "$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
# fish_add_path "$HOME/.pyenv/bin:$PATH"
# fish_add_path "$HOME/.local/bin:$PATH"
# fish_add_path $(/usr/bin/printenv PATH | /usr/bin/perl -ne 'print join(":", grep { !/\/mnt\/[a-z]/ } split(/:/));')
# fish_add_path "/mnt/c/Users/kevin/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
# # fish_add_path "/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application:$PATH"
# # fish_add_path "/mnt/c/WINDOWS/system32:$PATH"
# # fish_add_path "/mnt/c/WINDOWS:$PATH"

# . "$HOME/.cargo/env"

# export ZSH="$HOME/.oh-my-zsh"
# export ROOT="$HOME/__root__"
# export C="/mnt/c"

# export FZF_DEFAULT_OPS="--extended"
# export NVM_DIR="$HOME/.nvm"

set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end
### END OF SPARK ###


### FUNCTIONS ###
# Spark functions
function letters
    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | lolcat
    printf '%s\n' abcdefghijklmnopqrstuvwxyz ' ' | lolcat
end

colorscript random
starship init fish | source
