#!/bin/sh

echo "start-stop"

APP_DIR=/usr/local/AppCentral/extended-settings/CONTROL

case "$1" in
    start)
        "$APP_DIR/post-install.sh"
        sleep 1
        ;;
    stop)
        "$APP_DIR/pre-uninstall.sh"
        sleep 1
        ;;
    reload)
        "$APP_DIR/pre-uninstall.sh"
        sleep 1
        "$APP_DIR/post-install.sh"
        sleep 1
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
