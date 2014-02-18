RaspberryTV
===========

Basic manuals: 
http://thebugfreeblog.blogspot.ru/2013/04/hardware-accelerated-qtmultimedia.html
http://thebugfreeblog.blogspot.it/2013/03/raspberry-pi-wheezy-image-with-qt-and.html
http://thebugfreeblog.blogspot.it/2013/03/bring-up-qt-501-on-raspberry-pi-with.html
http://thebugfreeblog.blogspot.ru/2013/08/raspberry-pi-wheezy-image-with-openmax.html
http://thebugfreeblog.blogspot.it/2012/11/bring-up-qt-50-on-raspberry-pi.html
http://www.raspbmc.com/wiki/user/root-access/

http://www.raspberrypi.org/phpBB3/viewtopic.php?f=91&t=54946
http://raspberry-at-home.com/hotspot-wifi-access-point/

Basic repo: https://github.com/carlonluca/pi
Essential changes: remove local path check, remove "return false;" near line 389 in omx_mediaprocessor.cpp
https://github.com/huceke/omxplayer/issues/160