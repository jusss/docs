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


