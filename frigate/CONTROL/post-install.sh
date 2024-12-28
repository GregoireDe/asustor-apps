#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/frigate-docker/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME \
        -p 18971:8971 \
        -p 18970:5000 \
        -p 18554:8554 \
        -p 18555:8555/tcp \
        -p 18555:8555/udp \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        --mount type=tmpfs,target=/tmp/cache,tmpfs-size=1000000000 \
        --device /dev/bus/usb:/dev/bus/usb \
        --device /dev/dri/renderD128 \
        --shm-size=128m \
        --privileged \
        -v /etc/localtime:/etc/localtime:ro \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v /share/Docker/$APP_NAME/configs:/config:rw \
        -v /share/Docker/$APP_NAME/data:/media/frigat:rw \
        -e FRIGATE_RTSP_PASSWORD='_Adm!n2024' \
        -v /share/Docker/$APP_NAME/icons:/app/public/icons:rw \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH


docker start $APP_NAME

exit 0