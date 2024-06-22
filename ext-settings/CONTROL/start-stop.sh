#!/bin/sh

echo "start-stop"

case "$1" in
    start)
        ./post-install.sh
        sleep 3
        ;;
    stop)
        ./pre-uninstall.sh
        sleep 3
        ;;
    reload)
        ./post-uninstall.sh
        sleep 3
        ./pre-uninstall.sh
        sleep 3
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
