#! /bin/sh
# Copyright (c) 2000 SuSE GmbH Nuernberg, Germany.  All rights reserved.
#
# Author     : Stefan Wintermeyer <stefan@suse.de>
# last change: 13.12.2000
#
# eo collects a couple of important information for installation support.
# It was not written to solve all problems or to give you a perfect world.
#
# For new versions or updates have a look at http://support.suse.de/
#

VERSION="0.42"

# check if we are started as root
# only one of UID and USER must be set correctly
if test "$UID" != "0" -a "$USER" != root -a -z "$ROOT" ; then
    echo "You must be root to start $0"
    exit 1
fi

echo "<eo>"
echo -n "<!-- "
echo -n `date` 
echo " -->"
echo  "<!-- eo version $VERSION -->"

for i in $* ; do
  case $i in
    --software)
      echo "<rpm -qa>"
      rpm -qa
      echo "</rpm -qa>"
    ;;
    --hardware)
      echo "<lspci>"
      lspci -vv
      echo "</lspci>"
      
      echo "<lsusb>"
      lsusb -v
      echo "</lsusb>"
      
      echo "<messages>"
      tail -n 250 /var/log/messages
      echo "</messages>"
      
      echo "<boot.msg>"
      cat /var/log/boot.msg
      echo "</boot.msg>"
      
      echo "<lsmod>"
      /sbin/lsmod
      echo "</lsmod>"
    ;;
    --help)
      echo
      echo Usage: eo "[--hardware|--software]"
      echo version $VERSION
      echo
      echo eo collects a couple of important information for installation support.
      echo It was not written to solve all problems or to give you a perfect world.
      echo
      echo Hang loose! \:\-\)
      echo
      echo Report bugs to \<support\@suse.de\>
      echo
      echo "</eo>"
      exit 1
    ;;
  esac
done

echo "<df>"
df
echo "</df>"

echo "<uptime>"
uptime
echo "</uptime>"

echo "<SuSE-release>"
cat /etc/SuSE-release
echo "</SuSE-release>"

echo -n "<!-- "
echo -n `date` 
echo " -->"
echo "</eo>"

 