#!/bin/sh

ARR_LIST="Jackett|Lidarr|Bazarr|Radarr|Overseer|Prowlarr|Sonarr|Readarr"
ALL_ARR_LIST=$(docker container ps --format "table {{.Names}}" | grep -E $ARR_LIST | paste -sd' ')

for i in $ALL_ARR_LIST; do
    if [ ! "$(docker inspect $i -f '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' |grep arr_default)" ]; then
       echo "$i need to be attached."
       docker network connect arr_default $i
    else
       echo "$i already attached."
    fi
done

