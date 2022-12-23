function vol
switch $argv[1]
case reset
bash /sdcard/shizuku/rish -c 'settings put system volume_alarm 12'
bash /sdcard/shizuku/rish -c 'settings put system volume_ring 14'
case custval
bash /sdcard/shizuku/rish -c "settings put system volume_alarm $argv[2]"
bash /sdcard/shizuku/rish -c "settings put system volume_ring $argv[2]"
end
end
