## 在 Ubuntu 中，最標準且推薦的開機自動執行 ```.sh``` 腳本方式是建立 Systemd 服務。這能確保腳本在系統啟動完成後穩定執行。
以下為您整理的具體操作步驟(以 ```root``` 權限執行)：
### 1. 建立 Systemd 服務檔案
使用終端機建立並編輯服務設定檔(名稱可自訂，如 ```myscript.service```)：
```sh
sudo nano /etc/systemd/system/myscript.service
```
### 2. 貼上並修改服務內容
將以下內容貼入檔案中，請務必將 ```/path/to/your_script.sh``` 替換為您 ```.sh``` 檔案的實際絕對路徑：
```ini
[Unit]
# 服務名稱
Description=My Custom Startup Script

# 設定服務啟動的先後相依姓，例如在網路啟動之後：
# After=network.target

[Service]
# 行程類型
Type=simple

# 啟動服務指令
ExecStart=/path/to/your_script.sh

# 服務終止時自動重新啟動
# Restart=always

# 執行服務的使用者（名稱或 ID 皆可）
User=root

[Install]
WantedBy=multi-user.target
```
*<font color="red">註：若需以特定一般使用者身份執行，請將 ```User=root``` 改為 ```User=您的帳號名稱```。</font>*<br>
### 3. 啟用並啟動服務
依序執行以下指令來重新載入 Systemd、設定開機自動啟動，並立即啟動該服務：
```sh
sudo systemctl daemon-reload
sudo systemctl enable myscript.service
sudo systemctl start myscript.service
```
### 常見檢查指令
若要確認腳本是否正常執行，可檢查該服務的狀態：
```sh
sudo systemctl status myscript.service
```
### Systemd 服務單位設定檔範本
以下是一個比較詳細的 Systemd 服務單位設定檔範本，在撰寫自訂服務的設定檔時，可以先複製這份設定再接著修改：
```ini
[Unit]
# 服務名稱
Description=Your Server

# 服務相關文件
# Documentation=https://example.com
# Documentation=man:nginx(8)

# 設定服務啟動的先後相依姓，例如在網路啟動之後：
# After=network.target

[Service]
# 行程類型
Type=simple

# 啟動服務指令
ExecStart=/opt/your_command

# 服務行程 PID（通常配合 forking 的服務使用）
# PIDFile=/run/your_server.pid

# 啟動服務前，執行的指令
# ExecStartPre=/opt/your_command

# 啟動服務後，執行的指令
# ExecStartPost=/opt/your_command

# 停止服務指令
# ExecStop=/opt/your_command

# 停止服務後，執行的指令
# ExecStopPost=/opt/your_command

# 重新載入服務指令
# ExecReload=/opt/your_command

# 服務終止時自動重新啟動
Restart=always

# 重新啟動時間格時間（預設為 100ms）
# RestartSec=3s

# 啟動服務逾時秒數
# TimeoutStartSec=3s

# 停止服務逾時秒數
# TimeoutStopSec=3s

# 執行時的工作目錄
# WorkingDirectory=/opt/your_folder

# 執行服務的使用者（名稱或 ID 皆可）
# User=myuser

# 執行服務的群組（名稱或 ID 皆可）
# User=mygroup

# 環境變數設定
# Environment="VAR1=word1 word2" VAR2=word3 "VAR3=$word 5 6"

# 服務輸出訊息導向設定
# StandardOutput=syslog

# 服務錯誤訊息導向設定
# StandardError=syslog

# 設定服務在 Syslog 中的名稱
# SyslogIdentifier=your-server

[Install]
WantedBy=multi-user.target
```
## 💡 實用技巧：簡單的 ```@reboot``` 方法
如果您只需要最簡單的背景執行，且不需要複雜的管理，也可以使用內建的排程工具 ```cron```：<br>
1. 輸入 ```crontab -e```<br>
2. 在最下方加入這行(同樣將路徑替換掉)：<br>
```@reboot bash /path/to/your_script.sh > /dev/null 2>&1```<br>
##### 參考資料：
[1] [SH 腳本以 root 身份在啟動時運行](https://www.reddit.com/r/Ubuntu/comments/1fiqwpa/sh_script_run_as_root_as_startup/?tl=zh-hant)<br>
[2] [使用 Systemd 開機自動執行腳本](cjkuo.net/systemd-run-script-on-startup/)<br>
[3] [嘗試用 crontab 在開機時啟動 Mod 版 Minecraft 伺服器的 Shell Script](https://www.reddit.com/r/Ubuntu/comments/15nymi0/attempting_to_start_modded_minecraft_server_shell/?tl=zh-hant)<br>
[4] [開機自動執行指定程式](https://kejyuntw.gitbooks.io/ubuntu-learning-notes/content/system/system-boot-auto-execute.html)<br>