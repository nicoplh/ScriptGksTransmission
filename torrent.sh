#! /bin/bash

TORRENTS_DIR=/home/transmission/torrent #le chemin vers le répertoire surveillé

AUTOGET_ID=xxxx #votre autoget_id

USERNAME=xxxx #votre login web

PASSWORD=xxxx # votre mot de passe web

T_EXISTS=FALSE

rm -f $TORRENTS_DIR/*.torrent > /dev/null

cd $TORRENTS_DIR

for TODL in $(curl -s "https://gks.gs/rss/autoget/$AUTOGET_ID" | grep "enclosure" | cut -d '"' -f2 ); do

  if [ -n "$TODL" ];then

    T_EXISTS=TRUE

  fi

  curl -s -J -O $TODL

done

#Purge autoget Feed

if [ "$T_EXISTS" == "TRUE" ];then

  wget --save-cookies /tmp/cookies.txt --post-data "username=${USERNAME}&password=${PASSWORD}" -O /dev/null "https://gks.gs/login"

  wget --load-cookies /tmp/cookies.txt -O /dev/null "https://gks.gs/autoget/alldelete&id=$AUTOGET_ID"

fi
