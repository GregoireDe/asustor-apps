#!/bin/sh

echo "pre-uninstall"

. "/usr/local/AppCentral/immich-docker/CONTROL/conf.sh"

docker compose down --rmi

sleep 2
