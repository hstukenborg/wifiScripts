# wifiScripts
Personal scripts used to manage capturing WiFi data on Linux

# Files
- wifictl : single entry point for managing 802.11 monitor mode capture. Subcommands:
  - `wifictl monitor enable [-i <interface>] [-n] [-v]` : create monitor-mode interfaces
  - `wifictl monitor disable [-v]`                       : remove monitor-mode interfaces, restore managed mode
  - `wifictl monitor list`                               : list phy/interface mappings
  - `wifictl freq calc -c <channel> -b <band> [-v]`      : channel -> center frequency
  - `wifictl freq channel -f <frequency> -b <band> [-v]` : frequency -> channel
  - `wifictl channel set -p <phy> -c <channel> [-b <band>] [-w <width>] [-F <center freq>] [-v]` : set the operating frequency on a phy
  - `wifictl scan [-i <interface>] [-b <band>] [-s <ssid>]` : trigger a wpa_cli scan, optionally filtered by band (24,5,6) and/or SSID substring

  Run `wifictl` with no arguments (or `-h`/`--help`) for the full usage summary.
