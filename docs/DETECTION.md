# BShield Detection in Android

This documents will list of all detection that BShield detected in android. The date of this documents is **November 16th, 2025** so if you know what BShield detects more, feel free to report on Github issues tab.

## Android System Properties

BShield detects some of system properties we can take a look at:

- init.svc.adb_root
- service.adb.root

With this kind of detection, we can easily hide it by using:

```sh
resetprop -n -p init.svc.adb_root ""
```

## Maps detection

BShield also detect whenever maps contains lineage or injection or not. With this we can check from [Native Detector](https://dl.reveny.me/) (Found Injection Detecton or LineageOS Detected (14) from what I remembered) or do example command:

```sh
cat /proc/self/maps | grep "lineage"
```

For solution, is quite hard to hide so you may need to changes the AOSP / Pixel based custom rom to avoid this lineage trace.

If you have kernel with KernelSU + SuSFS (SUS_MAP enabled), you can add the leaked map in sus map path (using [sidex's susfs module](https://github.com/sidex15/susfs4ksu-module))

If you're using font module, is neccessary to remove it or just out it's path to SUS_MAP like I said above

You maybe can try Pedro's TreatWheel module to hide not I don't think it's really working and yes it will need ReZygisk build to operate

## Enforcing Status

This is the classic detection on most of the app. Now I really don't recommended to use custom rom with **permissive selinux** since it's insecure in this modern day.

If you're using rom with **permissive selinux**, you may experience with some attacks. BSheild also required **SElinux** to be **Enforced** respectfully

## Android package name detection

Another classic detection from most of app, it will read the list of app to see which app is for root users

Some list of app that BShield detected right now (it will have more app but since I only have tested this app, you can ask me to update in issues tab):

```txt
com.rifsxd.ksunext
me.bmax.apatch
me.weishu.kernelsu
com.topjohnwu.magisk
com.drdisagree.iconify
```

For solution, you can use combination like [ReLspoed](https://github.com/ThePedroo/ReLSPosed) + [HMA-OSS](https://github.com/frknkrc44/HMA-OSS) to hide.

## Leaks from custom Launcher

I have not much idea about detection, but BShield have ability to detect most of custom launcher module. Maybe it's from mounts, maps,...

The only solution for me is to remove those launchers and use the default one. Or we can just use app launchers, it does not matter much

## [UNCONFIRMED] JNI hook detection

In the some release of VNeID, BSheild can detect if the app hooked on it. This issues may have been resolved in newer ReZygisk CI version and ZygiskNext version.

If you still have it, may check your ReZygisk or ZygiskNext version

## [UNCONFIRMED] Bootloader check, sys call check?

In the recent release of VNeID, it act so weird liek auto kick out when already inside. It take a bit long to detect and response.

Currently we don't know what it detects but current solution is to put their package name into [TrickyStore](https://github.com/5ec1cff/TrickyStore) target.txt file like:

```txt
com.vnid
```

## Disclaimer

This project is for educational purposes only. The intention is to highlight the weaknesses of current security solutions and to encourage the development of better, more reliable alternatives. Use this information responsibly. Do NOT use this for malicious intent. I am not responsible for the actions taken by users of this module or project.
