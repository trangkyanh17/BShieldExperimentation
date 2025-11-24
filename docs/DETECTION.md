<p align="center">
  <img src="https://git.bnamm.org/namm/BSE-Improved/raw/branch/main/assets/detectionlist.png" width="800" />
</p>

<p align="center">
  <strong>This document lists all the detections observed in BShield for Android. The information is accurate as of November 16th, 2025. If you discover additional detections, feel free to report them in the Issues tab.</strong>
</p>

> [!CAUTION]
> **This project is for educational purposes only. The intention is to highlight the weaknesses of current security solutions and to encourage the development of better, more reliable alternatives. Use this information responsibly. Do NOT use this for malicious intent. I am not responsible for the actions taken by users of this module or project.**

## System properties

BShield also detects certain Android system properties. Some known examples include:

- `init.svc.adb_root`
- `service.adb.root`

**Solution:**  
These properties can be hidden easily by overriding them, for example:

```sh
resetprop -n -p init.svc.adb_root ""
resetprop -n -p service.adb.root ""

# by RainyXeon and Jan
resetprop init.svc.adb_root stopped
resetprop init.svc.adbd stopped
resetprop persist.sys.usb.config mtp
resetprop ro.adb.secure 1
resetprop ro.secure 1
resetprop ro.debuggable 0
resetprop service.adb.root 0
```

**Note:** These properties will reset on reboot.

## Maps detection

BShield can also detect whether the memory maps contain traces of **LineageOS** or injection-related entries.  

You can verify this using the **Native Detector** tool ([download](https://dl.reveny.me/)). 

For example, it may report "Injection Detection" or "LineageOS Detected (14)".  
Alternatively, you can check manually with:

```sh
cat /proc/self/maps | grep "lineage"
```

**Bypassing maps detection:**

Hiding these entries is difficult. To avoid LineageOS traces, you may need to modify your AOSP/Pixel-based custom ROM.

**Here is some solution:**
- If your kernel supports KernelSU + SuSFS (with SUS_MAP enabled), you can add the leaked map paths to the SuSFS map list. 
- If you're using font module, it may also leak map entries. Remove it or add its paths to SUS_MAP as mentioned above.
- You can also try Pedro's TreatWheel module to hide maps, but its effectiveness is limited and it requires a ReZygisk build to operate.

## Enforcing status

This is a common detection used by many applications. It is strongly recommended **not** to use a custom ROM with **permissive SELinux**, as it is considered insecure by modern standards.

If your ROM is running with **permissive SELinux**, certain attacks may be possible. BShield requires **SELinux** to be set to **Enforced** to function properly.

**Solution:**
- Set SELinux to **Enforcing**
```sh
setenforce 1
```
- Use a kernel or ROM with **Enforcing SELinux**

## Package name detection

Another classic detection used by many applications, BShield checks the installed app list to identify apps commonly associated with root access.

Below is the list of apps that BShield currently detects (there may be more; these are only the ones confirmed through testing. Feel free to request updates in the Issues tab):

```txt
com.rifsxd.ksunext
me.bmax.apatch
me.weishu.kernelsu
com.topjohnwu.magisk
com.drdisagree.iconify
```

**Solution:**
You can use a combination such as:

- [ReLSPosed](https://github.com/ThePedroo/ReLSPosed)
- [HMA-OSS](https://github.com/frknkrc44/HMA-OSS)

to hide these apps.

## Leaks from custom launchers

BShield can detect many custom launcher modules, possibly through mounts, memory maps, or other indicators. 

**Solution:**  
The simplest approach is to remove custom launchers and use the default system launcher. Alternatively, using standard app launchers typically does not trigger detection.

## [UNCONFIRMED] JNI hook detection

In some releases of VNeID, BShield was able to detect if the app was being hooked. This issue may have been resolved in newer versions of **ReZygisk CI** and **ZygiskNext**.

**Solution:**  
If you are still experiencing this detection, check your ReZygisk or ZygiskNext version.

## [UNCONFIRMED] Bootloader check, `syscall` check

In recent versions of VNeID (CA-E005 error), the app behaves strangely, such as kicking the user out after already logging in. The detection response also appears slower than usual.

It is currently unclear what BShield is detecting here. 

**Solution:**  
A temporary workaround is to add the package name (`com.vnid`) to the **TrickyStore** `target.txt` file.  
Open the Tricky Addon WebUI, select VNeID, press **Save**, and you’re done!