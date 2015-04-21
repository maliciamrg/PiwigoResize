#!/bin/bash 
NOW=$(date +"%F %T")
outfile="/media/kitchen/source_code/Script_Bash/PiwigoResize/log-piwigo-resize-`date +%Y-%m-%d`.log"

PIWIGO="/var/www/html/galerie" #O� est piwigo ?
repertoire="galleries"

unbis=$(echo "$1" | sed -e 's/[^a-zA-Z0-9_./-]/_/g')

IMG=$(basename -s .jpg $unbis) #R�cup�re le nom de fichier
REP=$(dirname $unbis) #R�cup�re le nom de dossier

fullfilename=$(basename "$unbis")
extension=${fullfilename##*.}
filename=${fullfilename%.*}

case "$extension" in
JPG | jpg | GIF | gif | MP4 ) 

mkdir $REP >> $outfile
mv "$1" "$REP"  >> $outfile

#creation repertoire dest
mkdir $PIWIGO/_data/i/$repertoire/$REP/
#Redimensionnement 
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] D�but de traitement de $REP/$filename.$extension" >> $outfile
if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-sq.$extension ]; then
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-sq.$extension existe d�j�, passe" >> $outfile
else
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-sq.$extension" >> $outfile
	convert -quality 90 -auto-orient -thumbnail 120\>x120\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-sq.$extension
fi
if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-th.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-th.$extension existe d�j�, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-th.$extension" >> $outfile
	convert -quality 90 -auto-orient -thumbnail 144\>x144\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-th.$extension
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-2s.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-2s.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-2s.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 240\>x240\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-2s.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-xs.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xs.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-xs.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 432\>x324\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-xs.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-sm.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-sm.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-sm.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 576\>x432\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-sm.$extension
#fi
if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-me.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-me.$extension existe d�j�, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-me.$extension" >> $outfile
	convert -quality 96 -auto-orient -thumbnail 792\>x594\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-me.$extension
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-la.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-la.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-la.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 1008\>x576\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-la.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-xl.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xl.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-xl.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 1224\>x918\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-xl.$extension
#fi
if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-xx.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xx.$extension existe d�j�, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-xx.$extension" >> $outfile
	convert -quality 96 -auto-orient -thumbnail 1656\>x1242\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-xx.$extension
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REP/$filename-cu_s9999x200.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-cu_s9999x200.$extension existe d�j�, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] G�n�re $filename-cu_s9999x200.$extension" >> $outfile
#	convert -quality 90 -auto-orient -thumbnail 9999\>x200\> $PIWIGO/$repertoire/$REP/$filename.$extension $PIWIGO/_data/i/$repertoire/$REP/$filename-cu_s9999x200.$extension
#fi
chmod 777 $REP >> $outfile
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Fin de traitement de $REP/$filename.$extension" >> $outfile
;;
*)
echo "-*****- extensions exclu $fullfilename -*****-" >> $outfile
;;
esac

