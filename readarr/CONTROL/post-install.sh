#!/bin/sh

echo "post-install"

. "$APKG_PKG_DIR/CONTROL/conf.sh"

ARR_LIST="Jackett|Lidarr|Bazarr|Radarr|Overseer|Prowlarr|Sonarr|Readarr"
ALL_ARR_LIST=$(docker container ps --format "table {{.Names}}" | grep -E $ARR_LIST | paste -sd' ')

for i in $ALL_ARR_LIST; do
    if [ ! "$(docker inspect $i -f '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' |grep $NETWORK)" ]; then
       echo "$i need to be attached."
       docker network connect $NETWORK $i
    else
       echo "$i already attached."
    fi
done

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep $APP_NAME | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

echo "Create $NETWORK network"
docker network inspect $NETWORK  >/dev/null || docker network create $NETWORK

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=$APP_NAME --network=$NETWORK \
        -p 28787:8787 \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/$APP_NAME/config:/config:rw \
        -v /share/Docker/$APP_NAME/books:/books:rw \
        -v /share/Download:/downloads:rw \
        -v /share:/shared:rw \
        --restart unless-stopped \
        $APP_IMAGE:$APP_IMAGE_BRANCH

docker start $APP_NAME

exit 0