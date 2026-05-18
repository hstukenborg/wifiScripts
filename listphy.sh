#!/usr/bin/env bash
#
# List all of the current physical interfaces along with the matching WLAN
iw dev | awk '/phy/{ PHY=$0; next } /Interface/{ print PHY "=" $2 }'
