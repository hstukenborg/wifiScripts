# wifiScripts
Personal scripts used to manage capturing WiFi data on Linux

# Files
- wifictl : single entry point for managing 802.11 monitor mode capture. Subcommands:
  - `wifictl monitor enable [-i <interface>] [-n] [-v] [-C <specs>] [-I]` : create monitor-mode interfaces
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

  `monitor enable -C <specs>` sets a channel per interface as it's brought into monitor
  mode, from a comma-separated `<interface>=<channel>:<band>[:<width>[:<centerfreq>]]` list
  (e.g. `-C "wlan0=6:24,wlan1=36:5:80"`). Add `-I` to interactively prompt for the
  channel/band/width of any interface with no matching `-C` entry (requires a terminal).

  For widths above 20 MHz, both `channel set -F` and `monitor enable -C`'s center frequency
  are auto-calculated from standard 5/6 GHz bonded-channel segment tables when omitted
  (verified against the values Wi-Fi vendors/regulators publish for these segments) --
  pass one explicitly only to override, or when the channel/width isn't a recognized
  standard segment (2.4 GHz, or a 5 GHz combination that crosses the 144/149 DFS gap).

- iwoutput.txt : sample real-world `iw phy` output (multiple phys, 2.4/5/6 GHz), used as a
  fixture to validate wifictl's band-detection parsing against actual Linux formatting.
