NUMBER+$((RANDOM%3))
if [ $NUMBER -eq "0" ]; then
    feh --bg-scale /home/justin/Pictures/BackgroundPictures/Interstellar_Gargantua.jpg
if [ $NUMBER -eq "1" ]; then
    feh --bg-scale /home/justin/Pictures/icev2/icev2.png
else
    feh --bg-scale /home/justin/Pictures/BackgroundPictures/Interstellar_Tron.jpg
fi

exec $HOME/Documents/Code/BashScriptSources/dwm-start-status
