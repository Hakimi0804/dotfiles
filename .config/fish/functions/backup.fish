function backup
for part in $argv
adb shell "su -c dd if=/dev/block/by-name/$part of=/data/local/tmp/$part.img"
adb shell "su -c chown shell:shell /data/local/tmp/$part.img"
adb pull "/data/local/tmp/$part.img"
end
end
