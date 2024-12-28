#!/bin/sh

echo "pre-uninstall"

. "/usr/local/AppCentral/frigate-docker/CONTROL/conf.sh"

container=$(docker container ls -a | grep $APP_NAME  | awk '{print $1}')
im=$(docker images | grep $APP_IMAGE | grep latest | awk '{print $3}')

echo $container
echo $im


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

