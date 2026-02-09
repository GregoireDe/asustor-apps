#!/bin/sh

echo "pre-install"

. "$APKG_TEMP_DIR/CONTROL/conf.sh"

ARR_LIST="Jackett|Lidarr|Bazarr|Radarr|Overseer|Prowlarr|Sonarr|Readarr"
ALL_ARR_LIST=$(docker container ps --format "table {{.Names}}" | grep -E $ARR_LIST | paste -sd' ')

for i in $ALL_ARR_LIST; do
    if [ ! "$(docker inspect $i -f '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' |grep $NETWORK)" ]; then
       echo "$i need to be attached."
       docker network connect $NETWORK $i
    else
       echo "$i already attached."
    fi
done

exit 0