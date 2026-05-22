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
Description=My Custom Startup Script
After=network.target

[Service]
ExecStart=/bin/bash /path/to/your_script.sh
Restart=always
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