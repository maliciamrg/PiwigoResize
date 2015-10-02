#!/bin/bash
#
#
#cd /media/kitchen/source_code/Script_Bash/PiwigoResize/;bash piwigo-resize.sh /var/www/html/galerie
#
#
NOW=$(date +"%F %T")
outfile="/media/kitchen/source_code/Script_Bash/PiwigoResize/log-piwigo-resize-`date +%Y-%m-%d`.log"
PIWIGO="$1" #Où est piwigo ?
repertoire="galleries"
sousrepsource="$1/$repertoire/photo/"
filets=$sousrepsource"PiwigoResize.ts" 

echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Début de traitement de $sousrepsource " >> $outfile

exec 9<$0
flock -n 9 || exit 1

#récupérer dernière timestamp
if [ -f $filets ]; then
 PiwigoResizets=$(cat $filets) 
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)]  récupération du timestamp   $PiwigoResizets" >> $outfile
else
 PiwigoResizets="0001-01-01"
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)] pas de fichier timestamp" >> $outfile
fi


for fichier in $( find $sousrepsource -type f -newermt $PiwigoResizets )
do
 

unbis=$(echo "$fichier" | sed -e 's/[^a-zA-Z0-9_./-]/_/g')

IMG=$(basename -s .jpg $unbis) #Récupère le nom de fichier
REP=$(dirname $unbis) #Récupère le nom de dossier
nREPsrc=`expr ${#repertoire} + ${#PIWIGO} + 2 `
REPSrc=${REP:$nREPsrc}

fullfilename=$(basename "$unbis")
extension=${fullfilename##*.}
filename=${fullfilename%.*}

case "$extension" in
JPG | jpg | GIF | gif | MP4 ) 

echo "-*****- $fichier -*****-" >> $outfile

mkdir $REP >> $outfile

#renomega des repertoire mal formater
mv "$fichier" "$REP" -v >> $outfile

#creation repertoire dest
mkdir $PIWIGO/_data/i/$repertoire/$REPSrc/
#Redimensionnement 

if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-sq.$extension ]; then
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-sq.$extension existe déjà, passe" >> $outfile
else
	echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-sq.$extension" >> $outfile
	convert -quality 90 -auto-orient -thumbnail 120\>x120\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-sq.$extension
fi
if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-th.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-th.$extension existe déjà, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-th.$extension" >> $outfile
	convert -quality 90 -auto-orient -thumbnail 144\>x144\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-th.$extension
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-2s.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-2s.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-2s.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 240\>x240\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-2s.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xs.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xs.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-xs.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 432\>x324\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xs.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-sm.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-sm.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-sm.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 576\>x432\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-sm.$extension
#fi
if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-me.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-me.$extension existe déjà, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-me.$extension" >> $outfile
	convert -quality 96 -auto-orient -thumbnail 792\>x594\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-me.$extension
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-la.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-la.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-la.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 1008\>x576\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-la.$extension
#fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xl.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xl.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-xl.$extension" >> $outfile
#	convert -quality 96 -auto-orient -thumbnail 1224\>x918\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xl.$extension
#fi
if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xx.$extension ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-xx.$extension existe déjà, passe" >> $outfile
else
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-xx.$extension" >> $outfile
	convert -quality 96 -auto-orient -thumbnail 1656\>x1242\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-xx.$extension 
fi
#if [ -f $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-cu_s9999x200.$extension ]; then
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] $filename-cu_s9999x200.$extension existe déjà, passe" >> $outfile
#else
#        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Génère $filename-cu_s9999x200.$extension" >> $outfile
#	convert -quality 90 -auto-orient -thumbnail 9999\>x200\> $PIWIGO/$repertoire/$REPSrc/$filename.$extension $PIWIGO/_data/i/$repertoire/$REPSrc/$filename-cu_s9999x200.$extension
#fi
chmod 777 $PIWIGO/_data/i/$repertoire/$REPSrc/ >> $outfile

;;
*)
echo "-*****- extensions exclu $fichier -*****-" >> $outfile
;;
esac

done

echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Fin de traitement de  $sousrepsource " >> $outfile

echo `date +%Y-%m-%d` > $filets
