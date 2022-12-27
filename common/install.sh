LogFile="//storage/emulated/0/GMSDozeInstall.log"
ui_print "GMS Doze Install: Starting..." 2>&1 | tee -a $LogFile

gxml=$(find /system /system_ext /product /vendor /india /my_bigball -not -path "*product/etc/preferred-apps*" -name "google.xml" -maxdepth 4 -print 2> /dev/null | sed 's|/[^/]*$||')

if [[ -z $gxml ]]
then
    ui_print "google.xml NOT found in modules expected paths" 2>&1 | tee -a $LogFile
    ui_print "please read the Troublehooting section of the repo" 2>&1 | tee -a $LogFile
  	ui_print "and also post an issue or PM 73sydney at XDA" 2>&1 | tee -a $LogFile
	  abort "GMS Doze Install: Incomplete" 2>&1 | tee -a $LogFile
else
    for i in $gxml
    do
        ui_print "google.xml found at: $i" 2>&1 | tee -a $LogFile
	      root_folder=$(echo $i | cut -d "/" -f2)
	      if [ "$root_folder" == "system" ]; then
		        #use the standard /system folder path
		        finalgxmlpath="system/etc/sysconfig"
	      else
		        #add /system folder prefix for product, system_ext and vendor paths
		        finalgxmlpath="system/$i"
		        ui_print "creating directory: $MODPATH/$finalgxmlpath" 2>&1 | tee -a $LogFile
		        mkdir -p "$MODPATH/$finalgxmlpath"
	      fi
	      #copy original google.xml file to modules path and correct path under it
	      ui_print "copying $i/google.xml to $MODPATH/$finalgxmlpath" 2>&1 | tee -a $LogFile
	      cp -af "$i/google.xml" "$MODPATH/$finalgxmlpath"
	      #modify modules copy of google.xml 
	      ui_print "modifying $MODPATH/$finalgxmlpath/google.xml" 2>&1 | tee -a $LogFile
	      # add <!=== prefix and --> suffix around relevant line in google.xml
	      sed -i 's/<allow-in-power-save package=\"com.google.android.gms\" \/>/<!--  &  -->/' "$MODPATH/$finalgxmlpath/google.xml"
    done
    ui_print "Fixing possible delayed incoming messages..." 2>&1 | tee -a $LogFile
    cd /data/data
    find . -type f -name '*gms*' -delete
    ui_print "GMS Doze Install: Complete" 2>&1 | tee -a $LogFile
fi
