#!/bin/sh

echo "post-install"

APP_DIR=/volmain/.@plugins/AppCentral/extended-settings/CONTROL
SETTINGS_FILE=/volmain/Web/extended-settings/settings.conf

. "$SETTINGS_FILE"
. "$APP_DIR/change-limits.sh"

chmod a+w "$SETTINGS_FILE"
if [ -z "$(grep 'extended-settings' /etc/sudoers )" ]; then echo "ALL ALL=NOPASSWD: $APP_DIR/start-stop.sh" >> /etc/sudoers ; fi;

exit 0