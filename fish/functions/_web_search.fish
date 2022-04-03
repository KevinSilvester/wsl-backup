function _web_search --description "search on browser"
   if [ (count $argv) -gt 1 ]
      # if [ (string match '*anilist*' "$argv[2]") ]
         set -g url (string join '' $argv[1] (string join '%20' $argv[2..-1]))
      # else
         # set -g url (string join '' $argv[1] (string join '+' $argv[2..-1]))
      # end
   else
      set -g url $argv[1]
   end

   $BROWSER "$url"
end
