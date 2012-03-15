#!/bin/bash

if [ "`pidof firefox`" ]; then
  firefox -P default -new-tab $1
elif [ "`pidof chromium`" ]; then
  chromium -new-tab $1
fi
