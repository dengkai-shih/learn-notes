# "clear docker_data.vhdx"
To clear and compact your docker_data.vhdx file on Windows, you must first delete unused Docker data, then shut down the WSL backend, and finally use PowerShell to shrink the virtual disk size.
##### reference : [DEV Community](https://dev.to/hamada147/docker-on-windows-eating-your-c-drive-how-i-reclaimed-over-350gb-from-bloated-vhdx-files-11dm) , [Stack Overflow](https://stackoverflow.com/questions/77062392/how-to-properly-resize-disk-usage-in-docker-desktop-wsl2)
## Step 1: Clean Up Unused Data
### (1) Open your terminal or command line interface.
### (2) Run ```docker system prune --all --volumes``` to remove all unused containers, networks, and images.
##### reference : [CodeSignal](https://codesignal.com/learn/courses/managing-data-working-with-volumes/lessons/cleaning-up-docker-volumes) , [Stack Overflow](https://stackoverflow.com/questions/77062392/)
## Step 2: Shut Down Docker and WSL
### (1) Right-click the **Docker Desktop icon** in your Windows system tray and select **Quit Docker Desktop**.
### (2) Open PowerShell as an Administrator and terminate active WSL instances:
```powershell
# powershell
wsl --shutdown
```
##### reference : [Stack Overflow](https://stackoverflow.com/questions/77062392/how-to-properly-resize-disk-usage-in-docker-desktop-wsl2)
## Step 3: Compact the VHDX File
### (1) In the same Administrator PowerShell window, run the Optimize-VHD command. The file is typically located in your AppData directory:
```powershell
# powershell
Optimize-VHD -Path "$env:LOCALAPPDATA\Docker\wsl\main\docker_data.vhdx" -Mode Full
```

Once the command finishes, the disk space will be reclaimed, and you can safely restart Docker Desktop. For further details on disk management, check the [Docker Community Forums](https://forums.docker.com/t/proper-docker-cleanup-on-command-line-only/145022).