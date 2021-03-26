#!/bin/sh
res0=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "power supply|percentage"`
isbat=`echo $res0 | head -1 | awk '{print $3}'`
if [ "$isbat" != 'yes' ]; then
    echo "ﮣ "
    exit 0
fi
res1=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|percentage"`
state=`echo $res1 | head -1 | awk '{print $2}'`
if [ "$state" = 'charging' ]; then
    echo "ﮣ top"
else
    bat0=`echo $res0 | awk '{print $5}'`
    bat1=`echo $res1 | awk '{print $4}'`
    bat_ave=`echo "(${bat0%\%} + ${bat1%\%}) / 2" | bc`
    if [ "$bat_ave" -gt 60 ]; then
        if [ "$bat_ave" -gt 80 ]; then
            echo ''`echo $bat_ave | awk '{printf ("%3d", $1)}'`' '
        else
            echo ''`echo $bat_ave | awk '{printf ("%3d", $1)}'`' '
        fi
    else
        if [ "$bat_ave" -gt 40 ]; then
            echo ''`echo $bat_ave | awk '{printf ("%3d", $1)}'`' '
        elif [ "$bat_ave" -gt 20 ]; then
            echo ''`echo $bat_ave | awk '{printf ("%3d", $1)}'`' '
        else
            echo ''`echo $bat_ave | awk '{printf ("%3d", $1)}'`' '
        fi
    fi
fi
