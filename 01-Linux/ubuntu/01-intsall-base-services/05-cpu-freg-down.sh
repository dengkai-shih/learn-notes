#!/bin/bash
# Program:
#       The processor is being "slowed down".
# History:
# 2026/05/22	Kyle	First release
sudo cpupower frequency-set -g powersave
read -n 1 -s -p "Press any key to continue..."