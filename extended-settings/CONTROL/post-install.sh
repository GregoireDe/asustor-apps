#!/bin/sh

echo "post-install"

CURRENT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )
SETTINGS_FILE=/volmain/Web/extended-settings/settings.conf
APP_DIR=/volmain/.@plugins/AppCentral/extended-settings/CONTROL

. "$SETTINGS_FILE"
. "$CURRENT_DIR/change-limits.sh"

chmod a+w "$SETTINGS_FILE"
if [ -z "$(grep 'extended-settings' /etc/sudoers )" ]; then echo "ALL ALL=NOPASSWD: $APP_DIR/start-stop.sh" >> /etc/sudoers ; fi;

exit 0