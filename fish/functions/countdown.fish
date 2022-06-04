function countdown --description "countdown"

   # check for start time
   # '&>/dev/null' to silence all output
   # '1>/dev/null' to silence all standard output
   # '2>/dev/null' to silence all standard error
   math "0+$argv[1]" &>/dev/null
   if [ $status -ne 0 ]
      echo -e "\nNo start time provided"
      return 1
   end

   set -l start (math (date +%s) + $argv[1])

   echo ""

   while [ $start -ge (date +%s) ]
      set -l time (math $start - (date +%s)) 
      printf '%s\r' (date -u -d "@$time" +%H:%M:%S)
      sleep 0.1
   end
end
