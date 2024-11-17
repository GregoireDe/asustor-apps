#!/bin/sh

echo "start-stop"

. "/usr/local/AppCentral/grafana-docker/CONTROL/conf.sh"

case "$1" in
    start)
        echo "Start $APP_NAME container..."
        docker start $APP_NAME
        sleep 3
        ;;
    stop)
        echo "Stop $APP_NAME container..."
        docker stop $APP_NAME
        sleep 3
        ;;
    reload)
        echo "Reload $APP_NAME container..."
        docker stop  $APP_NAME
        sleep 3
        docker start $APP_NAME
        sleep 3
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
