#!/sbin/sh
#
# www.osbusters.net
#
# This script should be flashed after ROM installation.
# It will check for large apps in system and move it to data.
#
# This will neither delete any app nor will it break its functionality
# This will increase free space in system partition
#
# AUTHOR: nitesh9 (Nitesh Prasad)
#ui_print "##################################################### "
outfile="/tmp/recovery.log"

# Create separate directories in /data
mkdir -p "/data/system_app"
chmod 755 "/data/system_app"
mkdir -p "/data/system_privapp"
chmod 755 "/data/system_privapp"

# Mount /system and /data
echo "#####START mounting system and data" >> ${outfile} 2>&1
mount | grep " /system " || /sbin/mount /system >> ${outfile} 2>&1
mount | grep " /data " || /sbin/mount /data >> ${outfile} 2>&1
mount >> ${outfile} 2>&1
df -h >> ${outfile} 2>&1
echo "#####END mounting system and data" >> ${outfile} 2>&1
# Moving files to data partition
# From system/app folder
cp -rf "/system/app/Email" "/data/system_app/Email"
rm -rf "/system/app/Email"
cp -rf "/system/app/GoogleTTS" "/data/system_app/GoogleTTS"
rm -rf "/system/app/GoogleTTS"
cp -rf "/system/app/Wallpaper" "/data/system_app/Wallpaper"
rm -rf "/system/app/Wallpaper"
cp -rf "/system/app/Weather" "/data/system_app/Weather"
rm -rf "/system/app/Weather"
cp -rf "/system/app/webview" "/data/system_app/webview"
rm -rf "/system/app/webview"
# From system/priv-app folder
cp -rf "/system/priv-app/Velvet" "/data/system_privapp/Velvet"
rm -rf "/system/priv-app/Velvet"
# Set back permissions and symlink (the copied file has the same permissons, still doing for precaution)
# Email
chmod 755 "/data/system_app/Email"
chmod 644 "/data/system_app/Email/Email.apk"
ln -sf "/data/system_app/Email" "/system/app/Email"
# GoogleTTS
chmod 755 "/data/system_app/GoogleTTS"
chmod 644 "/data/system_app/GoogleTTS/GoogleTTS.apk"
ln -sf "/data/system_app/GoogleTTS" "/system/app/GoogleTTS"
# Wallpaper
chmod 755 "/data/system_app/Wallpaper"
chmod 644 "/data/system_app/Wallpaper/Wallpaper.apk"
ln -sf "/data/system_app/Wallpaper" "/system/app/Wallpaper"
# Weather
chmod 755 "/data/system_app/Weather"
chmod 644 "/data/system_app/Weather/Weather.apk"
ln -sf "/data/system_app/Weather" "/system/app/Weather"
# webview
chmod 755 "/data/system_app/webview"
chmod 644 "/data/system_app/webview/webview.apk"
ln -sf "/data/system_app/webview" "/system/app/webview"
# Velvet
chmod 755 "/data/system_privapp/Velvet"
chmod 644 "/data/system_privapp/Velvet/Velvet.apk"
ln -sf "/data/system_privapp/Velvet" "/system/priv-app/Velvet"
