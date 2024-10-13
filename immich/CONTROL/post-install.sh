#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/immich-docker/CONTROL/conf.sh"

wget -O docker-compose.yml $IMMICH_REPO/download/docker-compose.yml
wget -O hwaccel.transcoding.yml $IMMICH_REPO/download/hwaccel.transcoding.yml
wget -O hwaccel.ml.yml $IMMICH_REPO/download/hwaccel.ml.yml

docker compose up -d

echo "Completed docker compose"

exit 0