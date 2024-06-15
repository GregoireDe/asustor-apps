#!/bin/sh

echo "pre-uninstall"

container=$(docker container ls -a | grep FlareSolverr | awk '{print $1}')
im=$(docker images | grep flaresolverr | grep latest | awk '{print $3}')

echo $container
echo $im

#stop container and image, don't use docker kill

if [ ! -z $container ]; then
        docker stop $container
        sleep 2
        docker rm -f $container
fi

if [ ! -z $im ]; then
        if [ "$APKG_PKG_STATUS" == "uninstall" ]; then
                docker rmi -f $im
        fi
fi

