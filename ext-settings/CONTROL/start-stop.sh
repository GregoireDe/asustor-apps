#!/bin/sh

echo "start-stop"

case "$1" in
    start)
        /volume1/.@plugins/AppCentral/ext-settings/CONTROL/post-install.sh
        sleep 3
        ;;
    stop)
        /volume1/.@plugins/AppCentral/ext-settings/CONTROL/pre-uninstall.sh
        sleep 3
        ;;
    reload)
        /volume1/.@plugins/AppCentral/ext-settings/CONTROL/pre-uninstall.sh
        sleep 3
        /volume1/.@plugins/AppCentral/ext-settings/CONTROL/post-install.sh
        sleep 3
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
