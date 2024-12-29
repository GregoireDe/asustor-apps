#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/immich-docker/CONTROL/conf.sh"

FILE_DOCKER_COMPOSE="docker-compose.yml"
FILE_TRANSCODING="hwaccel.transcoding.yml"
FILE_ML="hwaccel.ml.yml"

if [ ! -f $FILE_DOCKER_COMPOSE ]; then
  wget -O $FILE_DOCKER_COMPOSE $IMMICH_REPO/download/$FILE_DOCKER_COMPOSE.default
  cp $FILE_DOCKER_COMPOSE.default $FILE_DOCKER_COMPOSE
fi


if [ ! -f $FILE_TRANSCODING ]; then
  wget -O $FILE_TRANSCODING $IMMICH_REPO/download/$FILE_TRANSCODING.default
  cp $FILE_TRANSCODING.default $FILE_TRANSCODING
fi

if [ ! -f $FILE_ML ]; then
  wget -O $FILE_ML $IMMICH_REPO/download/$FILE_ML.default
  cp $FILE_ML.default $FILE_ML
fi

mkdir -p  /share/Docker/$APP_NAME/config
ln -s  $FILE_DOCKER_COMPOSE /share/Docker/$APP_NAME/config/$FILE_DOCKER_COMPOSE
ln -s  $FILE_TRANSCODING /share/Docker/$APP_NAME/config/$FILE_TRANSCODING
ln -s  $FILE_ML /share/Docker/$APP_NAME/config/$FILE_ML

docker compose pull
docker compose up -d

echo "Completed docker compose"

exit 0