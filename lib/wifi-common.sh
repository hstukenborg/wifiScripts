#!/usr/bin/env bash
#
# Shared functions for the wifiScripts tools. Source this file; it is not
# meant to be executed directly.

##############################################################################################################
#
# err()
#
# Output supplied text to stderr.
#
# Taken from Google Style Guide.
#
##############################################################################################################
function err() {
  echo "[$(date +'%Y-%m-%dT_%H:%M:%S%z')]: $*" >&2
}

##############################################################################################################
#
# calcCenterFreq()
#
# Calculate 2.4/5/6 GHz center frequency.
# Basic Formulas:
# - 2.4 GHz == Frequency (MHz) = (Channel Number * 5) + 2407 (else 2484 for ch 14).
# [Wi-Fi 7]: Center Frequency: 2412 + (Channel Number - 1) * 5
# - 5 GHz == 5000 + channel * 5
# - 6 GHz == 5950 + channel * 5
#
##############################################################################################################
function calcCenterFreq() {
  local -i lChannel=$1
  local lBand=$2
  local -i cFrequency

  case "${lBand}" in
    24) if [ "$lChannel" -eq 14 ]; then
          cFrequency=2484
        elif [ "$lChannel" -gt 14 ]; then
          err "Invalid channel: $lChannel"
          return 1
        else
          cFrequency=$((2407 + lChannel * 5))
        fi
        ;;
    5) cFrequency=$((5000 + lChannel * 5)) ;;
    6) cFrequency=$((5950 + lChannel * 5)) ;;
    *) err "Invalid band: $lBand"; return 1 ;;
  esac

  echo "$cFrequency"
}

##############################################################################################################
#
# getChannelFromFrequency()
#
# This function returns the channel number for a given frequency and band.
#
##############################################################################################################
function getChannelFromFrequency() {
  local -i lFrequency=$1
  local lBand=$2
  local -i cChannel

  case "${lBand}" in
    24) if [ "$lFrequency" -eq 2484 ]; then
          cChannel=14
        else
          cChannel=$(((lFrequency - 2407) / 5))
        fi
        ;;
    5) cChannel=$(((lFrequency - 5000) / 5)) ;;
    6) cChannel=$(((lFrequency - 5950) / 5)) ;;
    *) err "Invalid band: $lBand"; return 1 ;;
  esac

  echo "$cChannel"
}

##############################################################################################################
#
# listPhyInterfaceMap()
#
# Print "phyN=interface" pairs by walking `iw dev` output and associating
# each Interface with the phy block it actually appears under (adjacency in
# the output), rather than assuming interface/phy numeric suffixes line up.
# That assumption breaks whenever wlanN doesn't map to phyN (e.g. a USB
# adapter enumerated as phy0 but renamed wlan1), and it breaks entirely on
# systems using predictable interface names (wlp3s0, wlx00c0ca..., etc).
#
##############################################################################################################
function listPhyInterfaceMap() {
  iw dev | awk '/phy/{ PHY=$0; sub(/#/, "", PHY); next } /Interface/{ print PHY "=" $2 }'
}
