#!/bin/bash
# Program:
#       ollama-docker-update is a script to update ollama-docker to the latest version.
# History:
# 2026/06/10	Kyle	First release
# 1. Pull newest github data
sudo git pull origin main
# 2. Pull updated image
sudo docker compose pull
# 3. Recreate containers
sudo docker compose up -d
# 4. Prune Old Images
sudo docker image prune -f