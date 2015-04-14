# PiwigoResize
script resize piwigo de antoineVE mis a ma sauce

cd /var/www/html/galerie/galleries
find ./photo/2015/04/ -type f -exec /media/kitchen/source_code/Script_Bash/PiwigoResize/piwigo-resize.sh {} \;