# wifiScripts
Personal scripts used to manage capturing WiFi data on Linux

# Files
- wifictl : single entry point for managing 802.11 monitor mode capture. Subcommands:
  - `wifictl monitor enable [-i <interface>] [-n] [-v]` : create monitor-mode interfaces
  - `wifictl monitor disable [-v]`                       : remove monitor-mode interfaces, restore managed mode
  - `wifictl monitor list`                               : list phy/interface mappings, with each interface's current channel/band/width
  - `wifictl freq calc -c <channel> -b <band> [-v]`      : channel -> center frequency
  - `wifictl freq channel -f <frequency> -b <band> [-v]` : frequency -> channel
  - `wifictl channel set -p <phy> -c <channel> [-b <band>] [-w <width>] [-F <center freq>] [-v]` : set the operating frequency on a phy
  - `wifictl scan [-i <interface>] [-b <band>] [-s <ssid>] [-v]` : trigger a wpa_cli scan, optionally filtered by band (24,5,6) and/or SSID substring

  Run `wifictl` with no arguments (or `-h`/`--help`) for the full usage summary, or a command
  with no subcommand (e.g. `wifictl monitor`) for that command's full per-flag descriptions.

  `channel set` and `scan -b` both check the target phy against the requested band before
  issuing any commands (via `iw phy <phy> info`), and print the phy's current regulatory
  domain (via `iw reg get`) if the band isn't supported/usable. On an interactive terminal,
  they'll then offer to set a different country domain (`iw reg set <CC>`) and retry.
