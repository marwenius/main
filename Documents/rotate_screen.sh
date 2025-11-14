#! /bin/bash
#  switch_keyboard.sh
#  http://ubuntuforums.org/showthread.php?t=2100744
#  https://www.linuxquestions.org/questions/bodhi-92/yoga-laptop-autodisable-keyboard-when-screen-folded-back-to-use-as-tablet-4175678048/
#  https://unix.stackexchange.com/questions/578208/get-current-screen-orientation

STATUS=`xrandr -q --verbose | grep eDP | sed 's/primary //' | awk '{print $5}'`

if [ "$STATUS" = "normal" ]
then
    xrandr --output eDP --rotate left
    notify-send -t 100 "rotate left" --icon=video-display
elif [ "$STATUS" != "normal" ]
then
    xrandr --output eDP --rotate normal
    notify-send -t 100 "rotate normal" --icon=video-display
else
    echo "Error : bad argument"
fi
