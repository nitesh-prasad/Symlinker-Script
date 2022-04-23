![Space Xtend Banner](https://3.bp.blogspot.com/-FY_lmV7-eXE/Wha1BSO34SI/AAAAAAAACNU/lZHccSicVXIhPCkEg91__9Lvx5DsdDzaACLcBGAs/s640/Space-Xtend-Banner.jpg)
___
## Brief Info
This is a script for Android

It frees up space in /system partition.

Best for devices with small system partition size.

_How does it work?_

Basically it moves some large apps like webview, Velvet, GoogleTTS etc. to /data partition and symlinks them back to /system partition in their respective directories. Thus it befools the system to think that those files are there in their actual places i.e. in /system.
___
Technology is changing very rapidly. New software and devices are releasing almost every month. In this scenario we sometimes could not make co-ordination with the every changing technological demand.

Same thing happens with our smartphones as well. Sometimes our present devices are unable to run newer firmware (software) efficiently and sometimes becomes totally incompatible. **Google is releasing newer Android OS versions every year**. This year it has released **Android 8.0 Oreo**.

With the release of newer Android versions, **the size of the ROM also increases**. That means it needs more space to store the system files. As you may remember in the days of Android Gingerbread (2.3) the size of the ROMs used to be around 200 MB. But now, it’s sometimes more than 2 GB. So see the change it has become more than 10 times larger. Software are really becoming bulky space eaters!

As previously, the size of system files was smaller, the device manufacturers (OEMs) allocated smaller system partition for the android system. Thus allocating more usable space for users. However, this was for good but now this becomes hurdle for updating the device to newer Android versions.

So when you buy an Android smartphone you get updates for two-three years but after that the newer android versions either become incompatible or less functional. This is because your device has less system space and an outdated hardware. However, having an outdated hardware won’t stop you from trying out latest android features in our smartphone. The biggest hurdle is the inadequate system space.

So, is there any way to cope up with this problem? Well, yes. I have developed a recovery (obviously custom recovery) flashable script to counter the issue. It works on a special well known feature of linux systems. I was inspired to develop this script or better say the technique, when I faced the same space issue in my own android device. I called this script : **Space Xtend Script**.

**Here is the Github repo of Space Xtend Script: https://github.com/nitesh-prasad/Symlinker-Script/**

>_**Tested on Andriod 5, Android 6, Android 7 and Android 8.**_

So, how does it work. Let’s see…


# How does Space-Xtend Script work?

Before learning the working of the **Space Xtend Script** we must have some basic idea about **Android eMMC (memory) partitions**. So, let’s discuss a little about that.

![android-partitions.png](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4NubOSUIkRNbkBsEixUqYZSO9P6UCsvXgC9vw6nVrDpOO7KCHp_eBbhyOc_8quuFRPddfU4TtXRh3i4cufHGD3dWx6C173j0zYcm0aZriQ37okv_qy7HMHDh0JQk7l6pOz82vSEVEK7lzBoJlITM3cEdWZdvZL0urKTlB7PUmTvmOHTMf2fOOvNEYeQ/s16000/ANDROID-PARTITIONS.png)<br/>
<sub>Android partitions</sub>


Android doesn’t consist of a solid single partitioned memory. It has different compartments where different types of data are stored. These are the standard partitions available in an Android emmc:

- **/system** – this partition contains all the system files which cannot be modified without root access.

- **/boot** – this partition contains all the drivers, kernel and other files (RAMDISK) required to boot your device.

- **/aboot** – this is the partition (bootloader) which some mimimal files to mount other partitions while booting. Wiping this partition will render your device useless and possibly brick it. However, wiping this partition is not an easy task so nothing to worry about.

- **/recovery** – this partition contains another small Linux system with its own kernel independent of the OS. This partition, as the name suggests, is used to recover your device from any possible corruption. Recovery mode is used to wipe the whole of /data partition and clean the /cache partition. However, a custom recovery is capable of wiping the /system partition as well and flash new ROMs.

- **/data** – this is the partition which contains all the files created during the first boot (remember the loading screen saying “Android is starting”) for proper functioning of the OS. All the apps you later on install in your device, installs in this partition.

- **/cache** – this partition temporarily stores the downloaded Android update ready to be installed.

- **/radio** – this partition contains all the radio, modem files required for communincation.

There are yet many other partitions like /misc, /persist, /ril, /efs, /oem, /tz etc. which are beyond the scope of this post.

Although there are many partitions available, most are inaccessible to the users. What we see as **SD Card (internal storage)** in our android phones is just an emulated storage inside /data partition. And we have default access to SD Card (internal storage) only.

So, for **Space Xtend Script** to work two partitions are most important: **/system** and **/data**. To understand the functioning of the script, let’s take a deeper look to the problem first. Basically our problem is that, **we have more system files than our /system partition can actually accommodate**. So we are unable to fit all the important system files in our system partition, thus rendering our OS half functional or fully incompatible.

But what if we place the extra system files (which are not fitting in /system partition) inside the /data partition. And fool the system into thinking that those file are very much inside the /system partition. This is what this Space-Xtend Script does.

**Space-Xtend Script moves large files such as apps (like webview, Velvet, GoogleTTS etc.) to /data partition and symlinks them back /system partition in their respective directories. Thus it befools Android OS to think that those files are there in their actual places i.e. in /system partition.**

Let me tell you more about **“symlink”**, the special feature of linux or other UNIX based systems like Mac OS etc. Symlink is also called **Symbolic Link**. You may think it like a Windows shortcut, but it’s far better than that (*that’s why I love linux :D*). You may learn more about it on [Wikipedia](https://en.wikipedia.org/wiki/Symbolic_link):

> “A symbolic link contains a text string that is automatically interpreted and followed by the operating system as a path to another file or directory.”

Now let’s see the code and how we can use the script.

# How to Use and Modify Space Xtend Script?

To use this script in your smartphone you need a custom recovery like **[TWRP](https://twrp.me/about/)** installed. You simply have to flash the **Space_Xtend-Script-v_.zip** using the custom recovery in your smartphone.

![Space-Xtend-Script.jpg](https://1.bp.blogspot.com/-rC7tiMVi-q0/WUE7i1RF12I/AAAAAAAABsw/jcRc2XiRhk4VHnx8SJtw9hpdlVs9RCLEgCLcBGAs/s1600/Space-Xtend-Script.jpg)
<sub>Free system space before and after flashing the script</sub>

Now for ROM/Mod developers let’s take a look at the code used in the script. This Space-Xtend Script basically uses **Linux Shell Scripting** to carry out the task. You may learn more about Shell Script [here](http://www.freeos.com/guides/lsst/).

Let’s discuss about important part of codes from [runme.sh](https://github.com/nitesh-prasad/Symlinker-Script/blob/master/runme.sh) that you can modify.
```shell
# Create separate directories in /data
mkdir -p "/data/system_app"
chmod 755 "/data/system_app"
mkdir -p "/data/system_privapp"
chmod 755 "/data/system_privapp"
```
<br/>
This code, as the comment suggests, creates some special folders in the **/data** partition. These are the places where the large apps will be moved. We will be moving apps from **system/app/** and **system/priv-app** so we create the two folders named **system_app** and **system_privapp** in the **/data partition**.

Now see this code that we can modify to add new apps to the list:
```shell
# Moving files to data partition
# From system/app folder
cp -rf "/system/app/GoogleTTS" "/data/system_app/GoogleTTS"
rm -rf "/system/app/GoogleTTS"
cp -rf "/system/app/webview" "/data/system_app/webview"
rm -rf "/system/app/webview"
# From system/priv-app folder
cp -rf "/system/priv-app/Velvet" "/data/system_privapp/Velvet"
rm -rf "/system/priv-app/Velvet"
#
# Set back permissions and symlink (the copied file has the same permissons, still doing for precaution)
# GoogleTTS
chmod 755 "/data/system_app/GoogleTTS"
chmod 644 "/data/system_app/GoogleTTS/GoogleTTS.apk"
ln -sf "/data/system_app/GoogleTTS" "/system/app/GoogleTTS"
# webview
chmod 755 "/data/system_app/webview"
chmod 644 "/data/system_app/webview/webview.apk"
ln -sf "/data/system_app/webview" "/system/app/webview"
# Velvet
chmod 755 "/data/system_privapp/Velvet"
chmod 644 "/data/system_privapp/Velvet/Velvet.apk"
ln -sf "/data/system_privapp/Velvet" "/system/priv-app/Velvet"
```
<br/>
In the above code we are moving some selected apps to the directories we created in **/data** partition. And therefore, we are symlinking them back to **/system**. You can easily understand what is being done if you notice the comments (lines starting with ‘#’) in the code. Like here this code is for moving **GoogleTTS** from **/system/app** to **/data/system_app** :

```shell
cp -rf "/system/app/GoogleTTS" "/data/system_app/GoogleTTS"
rm -rf "/system/app/GoogleTTS"
```
<br/>
And this code is for **symlinking** **Google TTS** back to **/system/app** :
```shell
ln -sf "/data/system_app/GoogleTTS" "/system/app/GoogleTTS"
```
<br/>
And this one for setting correct usage **permissions** to the moved **GoogleTTS.apk** file :
```shell
chmod 755 "/data/system_app/GoogleTTS"
chmod 644 "/data/system_app/GoogleTTS/GoogleTTS.apk"
```
<br/>
Developers can add more apps to the code in the similar way. Also they can simply use the basic technique in their ROMs. They may use [edify scripting](https://forum.xda-developers.com/wiki/Edify_script_language) in their *updater-script* to symlink apps in /data partition back to /system.

### Proof of Work:
This is my Github repository of **Space Xtend Script**: https://github.com/nitesh-prasad/Symlinker-Script
Here are my commits: https://github.com/nitesh-prasad/Symlinker-Script/commits/master

Development thread in **XDA Developers**:

- https://forum.xda-developers.com/yureka/development/mod-space-xtend-script-space-increaser-t3621733


Hope this helps a lot of interested android developers out there. Happy developing.

Thanks. :)

