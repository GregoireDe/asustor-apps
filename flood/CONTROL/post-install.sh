#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/flood-docker/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME \
        -p 13025:3000  \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -e HOME=/config \
        -v /share/Docker/$APP_NAME/data:/data:rw \
        -v /share/Docker/$APP_NAME/config:/config:rw \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

exit 0