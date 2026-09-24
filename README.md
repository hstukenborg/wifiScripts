# wifiScripts
Personal scripts used to manage capturing WiFi data on Linux

# Files
- lib/wifi-common.sh : shared functions (err, calcCenterFreq, getChannelFromFrequency, listPhyInterfaceMap)
                sourced by fqzoid, setchannel, and setmonitor. Not meant to be run directly.
- fqzoid      : script to calculate frequencies and channels for various bands.
- setchannel  : script to set the operating frequency for a monitor-mode phy, given a channel/band
                (and, for widths above 20 MHz, an explicit center frequency).
- setmonitor  : main script to enable monitor mode on available or specified wlan interfaces. Ultimately it will become a single 
                script to also set channels and initiate captures.
- wifiscan    : quick wrapper to initiate wifi scans using wlan0.
- listphy.sh  : quick script to list the physical interfaces and their mapping to wlan interfaces.