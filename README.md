# GMS Doze Simplified
A simple Magisk Module to use the simplest Doze method for Google Play Services (GMS)

This Magisk Module uses the oldest method of "dozing" Google Play Services (GMS), as discussed in the this post many years ago now:

https://android.stackexchange.com/questions/143247/how-to-make-google-play-services-and-other-default-white-listed-system-apps-doze

While there are other GMS Doze modules out there, and they can work perfectly fine across some devices, they can sometimes try and do too much, and can (depending on the device) break some functionality.

The only deviation my module has from the method mentioned above is that it includes a couple of lines of code to (hopefully) avoid possible delayed messages - this is an optional manual step in one of the other GMS Doze modules, but included here as part of install:

```
cd /data/data

find . -type f -name '*gms*' -delete
```

**What it does/How it works:**

- The module automates finding the correct path to google.xml under the following (currently known) paths:
  - /system 
  - /system_ext
  - /product
  - /vendor 
  - /india 
  - /my_bigball 
  
  If google.xml is not found on your device in one of these paths, please see troubleshooting below
  
  it excludes the following path in its search:
  
  - product/etc/preferred-apps
  
- Recreates the path matching the found google.xml under the modules /system directory and copies google.xml there
- Patches the relevant line in the newly copied google.xml file to comment it out:

  ``` 
  #add <!=== prefix and --> suffix around relevant line in google.xml
  sed -i 's/<allow-in-power-save package=\"com.google.android.gms\" \/>/<!--  &  -->/' "$MODPATH/$finalgxmlpath/google.xml"
  ```
- Finally, it deletes any gms files in apps /data/data directies to try and prevent delayed messages
```
cd /data/data

find . -type f -name '*gms*' -delete

```


**Usage:**

- Install via Magisk Manager

The module will create a logfile (/storage/emulated/0/GMSDozeInstall.log) on install, which mirrors the information onscreen. If you have any issues, you'll need to start by looking there, and by opening an issue on this repo's Issues


**Troubleshooting**

As mentioned, the module ONLY searches the noted paths above. If you find the module fails to install, check the install log at: 
/storage/emulated/0/GMSDozeInstall.log. If it tells you the path isnt found, please try the following, in a root temrinal prompt, and then feel free to either trying adding the path yourself to 



**Please note:** the included LICENSE **only** covers the module components provided by the excellent work of Zack5tpg's 
Magisk Module Extended, which is available for here for module creators

https://github.com/Zackptg5/MMT-Extended/

All other work is credited above and **no one may fork or re-present this module as their own for the purposes of trying to monetize this module or its content without all parties permission. The module comes specifically without an overall license for this intent.**


### Changelog ###

Please see: https://github.com/stylemessiah/GMSDozeSimplified/blob/main/CHANGELOG.md


### Project Stats ###

![GitHub release (latest by date)](https://img.shields.io/github/v/release/stylemessiah/GMSDozeSimplified?label=Release&style=plastic)
![GitHub Release Date](https://img.shields.io/github/release-date/stylemessiah/GMSDozeSimplified?label=Release%20Date&style=plastic)
![GitHub Releases](https://img.shields.io/github/downloads/stylemessiah/GMSDozeSimplified/latest/total?label=Downloads%20%28Latest%20Release%29&style=plastic)
![GitHub All Releases](https://img.shields.io/github/downloads/stylemessiah/GMSDozeSimplified/total?label=Total%20Downloads%20%28All%20Releases%29&style=plastic)


