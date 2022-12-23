function checkOta
cat /odm/etc/flags.prop | tr -d '\r' | while read line
if echo $line | grep -qE '^#'
continue
else if test -z "$line"
continue
end

set -l prop (string split = $line)
set -l nvid $prop[1]
set -l region $prop[2]

echo -n "Checking update for $region ($nvid)... "
set -l ota_version (realme-ota -s1 RMX2086T2 RMX2086_11.C.15_1150_000000000000 2 $nvid)
if test $status -ne 0
echo "[failed]"
else
set -l ota_actual_version (echo $ota_version | jq -C .realOsVersion)
echo -e $ota_actual_version
end

true
end
end
