#!/bin/bash

running=$(curl -q http://deskdeck.lan/services/status | jq -r .running)

if [ "x$running" = "xtrue" ] ; then
    curl -q -X POST http://deskdeck.lan/services/stop
else
    curl -q -X POST http://deskdeck.lan/services/start
fi
