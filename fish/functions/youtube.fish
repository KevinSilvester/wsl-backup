function youtube
   set -l links \
      "https://youtu.be/4bbDZ6tJnGY" \
      "https://youtu.be/RBtlPT23PTM" \
      "https://youtu.be/atgjKEgSqSU" \
      "https://youtu.be/TO-_3tck2tg" \
      "https://youtu.be/T2fjQrsKbAM" \
      "https://youtu.be/PEnJbjBuxnw"

   for link in $links
      youtube-dl --audio-format mp3 $link
   end
end
