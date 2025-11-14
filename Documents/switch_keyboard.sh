#! /bin/bash
#  switch_keyboard.sh
#  http://ubuntuforums.org/showthread.php?t=2100744
#  https://www.linuxquestions.org/questions/bodhi-92/yoga-laptop-autodisable-keyboard-when-screen-folded-back-to-use-as-tablet-4175678048/

DEVICE="keyd virtual keyboard"
STATUS=`xinput list-props "$DEVICE" | grep 'Device Enabled' | sed 's/.*\([0-9]\)$/\1/'`

if [ "$STATUS" = "1" ]
then
    xinput set-prop "$DEVICE" 'Device Enabled' 0
    notify-send -t 100 "keyboard disabled" --icon=input-keyboard
elif [ "$STATUS" = "0" ]
then
    xinput set-prop "$DEVICE" 'Device Enabled' 1
    notify-send -t 100 "keyboard enabled" --icon=input-keyboard
else
    echo "Error : bad argument"
fi
