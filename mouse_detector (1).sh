#!/bin/bash
# This script uses the dmesg command to check whether a USB mouse is plugged 
# into this linux machine. This script is  
DATE=`date`
echo running script on $DATE.. 	#timestamp of script execution
#dmesg > dmesg_messages 	#uncomment if you wish to save current logs in a file

usbDis=`dmesg | grep -i -c "usb disconnect"`
detectMouse=`dmesg | grep -i -c "mouse as /devices"` #mouse prints 2 messages
usbCon=$((detectMouse/2)) 	#each pair is one instance of the device detected 
#echo "connects: $usbCon"
#echo "disconnects: $usbDis"

if [ $usbCon -le $usbDis -a $usbCon -ne 0 ]
then
	echo "BAD: Mouse is NOT present."
elif [ $usbCon == 0 -a $usbDis == 0 ]	
then
	echo "ERROR: try reconnecting the mouse." #dmesg emptied with mouse unplugged
elif [ $usbCon -gt $usbDis -o $detectMouse -gt $usbDis ] #greater connects than disconnects
then
	echo "GOOD: Mouse is present."
else    
	#dmesg was emptied with mouse connected
	echo "WARN: This script cannot properly detect the USB mouse without a reboot."
fi
