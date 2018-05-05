用adb push来解压supersu.zip的文件到指定位置来root
查看supersu.zip解压后的META-INF/com/google/android/update-binary.sh

adb root
adb remount
adb push common/Superuser.apk /system/app/Superuser.apk
adb shell chmod 0644 /system/app/Superuser.apk
adb push armv7/su /system/bin/su
adb reboot

https://android.stackexchange.com/questions/127230/android-adb-has-root-access-but-no-su-binary
---------------------------
sudo adb root; adb shell 就以root登录android
所有wifi的密码存储在　/data/misc/wifi/wpa_supplicant.conf
sudo fastboot devices 查看是否已连接上，需要root权限
sudo fastboot flash recovery recovery.img
sudo fastboot reboot
------------------------
adb push .ssh/joe /sdcard
复制.ssh/joe到手机/sdcard里面，当jmtpfs不能使用时，这个很棒
--------------------
设置里７下点击版本号开启开发者模式，开启adb功能
adb install xxx.apk 直接把电脑上的apk安装到手机上
adb shell
adb reboot recovery
adb reboot bootloader

adb devices 显示一串数字表明连接正常
同fastboot一样　fastboot devices显示数字显示在在bootloader连接正常
adb reboot recovery 重启进recovery mode然后选apply update from adb
adb sideload your-rom.zip 替代卡刷,不用把ROM复制到内存卡


