#!/bin/sh

echo "pre-uninstall"

APP_DIR=/usr/local/AppCentral/extended-settings/CONTROL
DEFAULT_SETTINGS_FILE=/volmain/Web/extended-settings/default.conf

. "$DEFAULT_SETTINGS_FILE"
. "$APP_DIR/change-limits.sh"

exit 0