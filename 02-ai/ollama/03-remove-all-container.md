#### "清理 docker_data.vhdx 虛擬磁碟儲存空間"
要在 Windows 上清除和壓縮 docker_data.vhdx 文件，必須先刪除未使用的 Docker 數據，然後關閉 WSL 後端，最後使用 PowerShell 縮小虛擬磁碟大小。
#### 步驟 1：清理未使用的數據
(1) 打開終端機或命令列介面。
(2) 運行 ```docker system prune --all --volumes``` 以刪除所有未使用的容器、網路和鏡像。
```sh
docker system prune --all --volumes
```
#### 步驟 2：關閉 Docker 和 WSL
(1) 右鍵點選 Windows 系統匣中的 **Docker Desktop** 圖標，然後選擇「**退出 Docker Desktop**」。
(2) 以管理員身分開啟 PowerShell 並終止活動的 WSL 實例：
```powershell
# powershell
wsl --shutdown
```
#### 步驟 3：壓縮 VHDX 文件
在同一個管理員 PowerShell 視窗中，執行 Optimize-VHD 指令。該檔案位於 AppData 目錄中：
```powershell
# powershell
Optimize-VHD -Path "$env:LOCALAPPDATA\Docker\wsl\main\docker_data.vhdx" -Mode Full
```
<br>命令執行完畢後，磁碟空間將被回收，您可以安全地重新啟動 Docker Desktop。

#### + reference +
<ol>
<li><a href="https://dev.to/hamada147/docker-on-windows-eating-your-c-drive-how-i-reclaimed-over-350gb-from-bloated-vhdx-files-11dm" target="_blank">Docker on Windows: Eating Your C: Drive? How I Reclaimed Over 350GB from Bloated VHDX Files!</a></li>
<li><a href="https://stackoverflow.com/questions/77062392/how-to-properly-resize-disk-usage-in-docker-desktop-wsl2" target="_blank">How to properly resize disk usage in docker desktop WSL2?</a></li>
<li><a href="https://codesignal.com/learn/courses/managing-data-working-with-volumes/lessons/cleaning-up-docker-volumes" target="_blank">Cleaning Up Docker Volumes</a></li>
<li><a href="https://forums.docker.com/t/proper-docker-cleanup-on-command-line-only/145022" target="_blank">Proper docker cleanup on command line only</a></li>
</ol>