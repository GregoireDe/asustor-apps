#!/bin/sh

echo "post-install"

docker pull linuxserver/prowlarr:latest

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep Prowlarr | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=Prowlarr \
        -p 28989:28989 \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/Prowlarr/config:/config:rw \
        -v /share:/shared:rw \
        --restart unless-stopped \
        linuxserver/prowlarr:latest

docker start Prowlarr


#Always check if there is any images tag with none, and remove it.
oldim=$(docker images | grep linuxserver/prowlarr | grep none | awk '{print $3}')
echo $oldim

if [ ! -z $oldim ]; then
        docker rmi -f $oldim
fi

exit 0