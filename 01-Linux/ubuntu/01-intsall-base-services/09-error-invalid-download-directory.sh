#!/bin/bash
# Program:
#       jdownloader2 and qBittorrent need to access the removable media, so we need to connect the snap to the removable media interface.
# History:
# 2026/06/09	Kyle	First release
# jdownloader2
sudo snap connect jdownloader2:removable-media
# qBittorrent
sudo snap connect qbittorrent-desktop-tak:removable-media