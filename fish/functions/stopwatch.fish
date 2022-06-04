function stopwatch --description "stopwatch"
   set -l start (date +%s)

   echo ""

   while true
      set -l time (math (date +%s) - $start)
      printf '%s\r' (date -u -d "@$time" +%H:%M:%S)
      sleep 0.1
   end
end
