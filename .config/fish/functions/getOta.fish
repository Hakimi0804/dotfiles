function getOta
realme-ota (adb shell getprop ro.product.name) (adb shell getprop ro.build.version.ota) (adb shell getprop ro.build.version.realmeui | tr -d '^V' | tr -d '.0$') (adb shell getprop ro.build.oplus_nv_id)
end
