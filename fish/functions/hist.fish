function hist --description 'search histroy with ripgrep'
   set -q argv[2] || set argv[2] 50
   history | rg $argv[1] --max-count $argv[2]
end
