#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/readarr-docker/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME \
        -p 28787:8787 \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/$APP_NAME/config:/config:rw \
        -v /share/Docker/$APP_NAME/books:/books:rw \
        -v /share/Download:/downloads:rw \
        --restart unless-stopped \
        $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

exit 0