#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/flaresolverr-docker/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

echo "Create arr_default network"
docker network inspect $NETWORK  >/dev/null || docker network create $NETWORK


C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME --network=$NETWORK \
        -p 18191:8191  \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/$APP_NAME/config:/config:rw \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

. "/usr/local/AppCentral/flaresolverr-docker/CONTROL/network.sh"

exit 0