#!/bin/sh

echo "start-stop"

. "/usr/local/AppCentral/immich-docker/CONTROL/conf.sh"

case "$1" in
    start)
        echo "Start $APP_NAME container..."
        docker compose up -d
        sleep 3
        ;;
    stop)
        echo "Stop $APP_NAME container..."
        docker compose stop
        sleep 3
        ;;
    reload)
        echo "Reload $APP_NAME container..."
        docker compose stop
        sleep 3
        docker compose up -d
        sleep 3
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
