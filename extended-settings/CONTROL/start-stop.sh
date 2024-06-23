#!/bin/sh

echo "start-stop"

CURRENT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )

case "$1" in
    start)
        "$CURRENT_DIR/post-install.sh"
        sleep 1
        ;;
    stop)
        "$CURRENT_DIR//pre-uninstall.sh"
        sleep 1
        ;;
    reload)
        "$CURRENT_DIR/pre-uninstall.sh"
        sleep 1
        "$CURRENT_DIR/post-install.sh"
        sleep 1
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
