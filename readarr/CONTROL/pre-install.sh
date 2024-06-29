#!/bin/sh

echo "pre-install"

. "$APKG_REPO_DIR/CONTROL/conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

exit 0