#!/bin/sh

echo "pre-install"

. "conf.sh"

docker pull $APP_IMAGE:$APP_IMAGE_BRANCH

exit 0