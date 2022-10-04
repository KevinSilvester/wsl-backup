function youtube
   set -l links \
      "https://youtube.com/watch?v=KMOU9YLvHDg" \
      "https://youtube.com/watch?v=ahdH8eTydWY" \
      "https://youtube.com/watch?v=SDTZ7iX4vTQ" \
      "https://youtube.com/watch?v=TAKR_6vNJR8"

   for link in $links
      youtube-dl --audio-format mp3 $link
   end
end
