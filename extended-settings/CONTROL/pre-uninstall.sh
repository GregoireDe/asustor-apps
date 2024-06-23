#!/bin/sh

echo "pre-uninstall"

CURRENT_DIR=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )
DEFAULT_SETTINGS_FILE=/volmain/Web/extended-settings/default.conf

. "$DEFAULT_SETTINGS_FILE"
. "$CURRENT_DIR/change-limits.sh"

exit 0