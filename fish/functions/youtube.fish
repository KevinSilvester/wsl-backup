function youtube
   set -l links \
      "https://www.youtube.com/watch?v=hvL-2TF9bLY"

   for link in $links
      youtube-dl --audio-format mp3 $link
   end
end
