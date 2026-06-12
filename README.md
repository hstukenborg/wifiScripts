# wifiScripts
Personal scripts used to manage capturing WiFi data on Linux

# Files
- fqzoid      : script to calculate frequencies and channels for various bands. Really a proving ground for functions I'll ultimately
                incorporate into the main script, setmonitor.
- setchannel  : script to set the available wlan interfaces to a specified channel/frequency for monitor mode capture.
- setmonitor  : main script to enable monitor mode on available or specified wlan interfaces. Ultimately it will become a single 
                script to also set channels and initiate captures.
- wifiscan    : quick wrapper to initiate wifi scans using wlan0.
- listphy.sh  : quick script to list the physical interfaces and their mapping to wlan interfaces.