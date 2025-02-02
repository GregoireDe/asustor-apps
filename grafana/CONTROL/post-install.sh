#!/bin/sh

echo "post-install"

. "/usr/local/AppCentral/grafana-docker/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=472
ADMIN_GID=$(id -g root)
chown -R 472:root /share/Docker/$APP_NAME
cat '' > /share/Docker/$APP_NAME/config/grafana.ini
docker create -i -t --name=$APP_NAME \
        -p 43000:3000  \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/$APP_NAME/data:/var/lib/grafana \
        -v /share/Docker/$APP_NAME/log:/var/log/grafana \
        -v /share/Docker/$APP_NAME/config:/etc/grafana \
        --restart unless-stopped \
         $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

exit 0