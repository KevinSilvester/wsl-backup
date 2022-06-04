function _print --description "A simplet way to print with colours"
   # colours
   set -l warning ef4444 
   set -l info    fbbf24
   set -l success 4ade80
   set -l reset   normal

   # command flags
   set -l FLAGS --warning -w --info -i --success -s

   # outup message
   set -l str

   # return if nothing to print
   [ (count $argv) -eq 0 ] && return 1

   # remove command flags from outup message
   if contains -- $argv[1] $FLAGS
      set str $argv[2..-1]
   else
      set str $argv
   end

   switch $argv[1]
      case -w --warning
         set_color $warning; echo -e $str >&2
      case -i --info
         set_color $info; echo -e $str >&1
      case -s --success
         set_color $success; echo -e $str >&1
      case '*'
         echo -e $str >&1
   end

   set_color $reset;
end
