function youtube
   set -l links \
      "https://www.youtube.com/watch?v=VsWn1Gb2Ds4"

   for link in $links
      youtube-dl --audio-format mp3 $link
   end
end
