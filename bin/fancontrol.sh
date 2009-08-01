#!/bin/zsh

cd /sys/class/hwmon/hwmon0/

echo 1 > pwm1_enable
sleep 2
echo 0 > pwm1_enable
