#!/system/bin/sh
resetprop -n -p init.svc.adb_root ""
val="$(getprop service.adb.root)"
if [ -n "$val" ]; then
    resetprop -n -p service.adb.root ""
fi