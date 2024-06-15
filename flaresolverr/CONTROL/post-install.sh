#!/bin/sh

echo "post-install"

docker pull ghcr.io/flaresolverr/flaresolverr:latest

echo "Completed docker pull"

CONTAINER_TEST=$(docker container ls -a | grep FlareSolverr | awk '{print $1}')

if [ ! -z $CONTAINER_TEST ]; then
        docker rm -f $CONTAINER_TEST
fi

C_UID=$(id -u admin)
ADMIN_GID=$(id -g admin)

docker create -i -t --name=FlareSolverr \
        -p 18191:8191  \
        -e PUID=$C_UID -e PGID=$ADMIN_GID \
        -v /etc/localtime:/etc/localtime:ro \
        -v /share/Docker/FlareSolverr/config:/config:rw \
        --restart unless-stopped \
        ghcr.io/flaresolverr/flaresolverr:latest

docker start FlareSolverr

#Always check if there is any images tag with none, and remove it.
oldim=$(docker images | grep laresolverr | grep none | awk '{print $3}')
echo $oldim

if [ ! -z $oldim ]; then
        docker rmi -f $oldim
fi

exit 0