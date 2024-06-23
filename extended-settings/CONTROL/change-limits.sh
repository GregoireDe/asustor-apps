#!/bin/sh

PORTAL_LIMIT_FILE=/volume0/usr/builtin/webman/portal/build/launcherBuild.js
sed -i "s/WARNING:[0-9.]\+,/WARNING:$EXT4_WARNING,/g" "$PORTAL_LIMIT_FILE"
sed -i "s/LIMIT:[0-9.]\+/LIMIT:$EXT4_LIMIT/g" "$PORTAL_LIMIT_FILE"
sed -i "s/TOBE_EXHAUSTED_PERCENT:[0-9]\+,/TOBE_EXHAUSTED_PERCENT:$BTRFS_FREE_LIMIT,/g" "$PORTAL_LIMIT_FILE"
