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

SECRET_KEY=
if [ -e /share/Docker/$APP_NAME/secret.key ]; then
        SECRET_KEY=$(cat /share/Docker/$APP_NAME/secret.key | awk '{print $1}')

else
        SECRET_KEY=$(openssl rand -hex 32)
        echo "$SECRET_KEY" >> /share/Docker/$APP_NAME/secret.key
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME --network=$NETWORK \
        -p 27575:7575 \
        -e PUID=$C_UID -e PGID=$ADMIN_GID -e  SECRET_ENCRYPTION_KEY=$SECRET_KEY  DISABLE_ANALYTICS=true \
        -v /etc/localtime:/etc/localtime:ro \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v /share/Docker/$APP_NAME/data:/appdata:rw \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

exit 0