#!/bin/sh

echo "post-install"

. "$APKG_PKG_DIR/CONTROL/conf.sh"

. "$APKG_PKG_DIR/CONTROL/network-install.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
  docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME --network=$NETWORK \
        -p 27474:7474 \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/$APP_NAME/config:/config:rw \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH


docker start $APP_NAME

#Always check if there is any images tag with none, and remove it.
oldim=$(docker images | grep  $APP_IMAGE | grep none | awk '{print $3}')
echo $oldim

if [ ! -z $oldim ]; then
        docker rmi -f $oldim
fi

exit 0