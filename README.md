# Symlinker-Script

This is a script for Android

It frees up space in /system partition.

Best for devices with small system partition size.

## How does it work?

Basically it moves some large apps like webview, Velvet, GoogleTTS etc. to /data partition and symlinks them back to /system partition in their respective directories. Thus it befools the system to think that those files are there in their actual places i.e. in /system.
