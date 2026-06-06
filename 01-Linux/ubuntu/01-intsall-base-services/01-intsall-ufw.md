# 安裝 ubuntu 防火牆 : 資料來源[「在 Ubuntu 24.04 LTS 上使用 UFW 防火牆」](https://kirin.idv.tw/ufw-firewall-on-ubuntu-24-linux/)
## 1. 安裝 ubuntu 防火牆與狀態查詢
### 1-1. 安裝 ufw 防火牆
```sh
sudo apt install ufw
```
```console
root@31-ub-26-dev:/home/dengkai# sudo apt install ufw
ufw 已是最新版本 (0.36.2-9build1)。
Summary:                    
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0
```
### 1-2. 查看 ufw 狀態
#### 1-2-1. 查看 ufw 防火牆狀態
```sh
sudo ufw status
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態： 啓用

至                          動作          來自
-                          --          --
22                         ALLOW       192.168.1.0/24            
3389                       ALLOW       192.168.1.0/24            
9090                       ALLOW       192.168.1.0/24
```
#### 1-2-2. 查看 ufw 防火牆狀態較多資訊：
```sh
sudo ufw status verbose
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw status verbose
狀態: 啓用
日誌: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
新建設定檔案: skip

至                          動作          來自
-                          --          --
22                         ALLOW IN    192.168.1.0/24            
3389                       ALLOW IN    192.168.1.0/24            
9090                       ALLOW IN    192.168.1.0/24
```
## 2. ufw 防火牆啟用和停用
### 2-1. 啟動 ufw 防火牆
```sh
sudo ufw enable
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw enable
在系統啟動時啟用防火牆
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態： 啓用

至                          動作          來自
-                          --          --
22                         ALLOW       192.168.1.0/24            
3389                       ALLOW       192.168.1.0/24            
9090                       ALLOW       192.168.1.0/24
```
### 2-2. 關閉 ufw 防火牆
```sh
sudo ufw disable
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw disable
在系統啟動時停用防火牆
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態：不活動
```
### 2-3. 設定 UFW 預設允許、拒絕所有連線
#### 2-3-1. 設定 ufw 防火牆預設允許所有連線
```sh
sudo ufw default allow
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw default allow
預設的 incoming 策略更改為 'allow'
（請相應更新您的防火牆規則）
```
#### 2-3-2. 設定 ufw 防火牆預設拒絕所有連線
```sh
sudo ufw default deny
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw default deny
預設的 incoming 策略更改為 'deny'
（請相應更新您的防火牆規則）
```
## 3. 設定 ufw 防火牆規則
### 3-1. 設定允許、拒絕規則
#### 3-1-1. 特定 port
| prefix | allow/deny | port/protocol | 說明 |
| :--- | :--- | :--- | :--- |
| sudo ufw | allow | 80 | 允許 port 80 的 tcp and udp |
| sudo ufw | allow | 80/tcp | 允許 port 80 的 tcp |
| sudo ufw | allow | 80/udp | 允許 port 80 的 udp |
| sudo ufw | deny | 80 | 拒絕 port 80 的 tcp and udp |
| sudo ufw | deny | 80/tcp | 拒絕 port 80 的 tcp |
| sudo ufw | deny | 80/udp | 拒絕 port 80 的 udp |
```sh
sudo ufw allow 80
sudo ufw allow 80/tcp
sudo ufw allow 80/udp
sudo ufw deny 80
sudo ufw deny 80/tcp
sudo ufw deny 80/udp
```
#### 3-1-2. 指定 IP 連線開放、拒絕所有 port
| prefix | allow/deny | 從 | 指定 IP |
| :--- | :--- | :--- | :--- |
| sudo ufw | allow | from | 192.168.1.100 |
| sudo ufw | deny | from | 192.168.1.100 |
```sh
sudo ufw allow from 192.168.1.100
sudo ufw deny from 192.168.1.100
```
#### 3-1-3. 指定 IP 的特定 port
| prefix | allow/deny | 從 | 指定 IP | 到 | port/protocol |
| :--- | :--- | :--- | :--- | :--- | :--- |
| sudo ufw | allow | from | 192.168.1.100 | to any port | 80 |
| sudo ufw | deny | from | 192.168.1.100 | to any port | 80 |
```sh
sudo ufw allow from 192.168.1.100 to any port 80
sudo ufw deny from 192.168.1.100 to any port 80
```
#### 3-1-4. 指定 IP 整個網段的特定 port
| prefix | allow/deny | 從 | 指定 IP 子網域 | 到 | port/protocol |
| :--- | :--- | :--- | :--- | :--- | :--- |
| sudo ufw | allow | from | 192.168.1.0/24 | to any port | 80 |
| sudo ufw | deny | from | 192.168.1.0/24 | to any port | 80 |
```sh
sudo ufw allow from 192.168.1.0/24 to any port 80
sudo ufw deny from 192.168.1.0/24 to any port 80
```
### 3-2. 刪除 ufw 防火牆規則
```sh
sudo ufw delete allow 80
```
### 3-3. 使用序號刪除
#### 3-3-1. 查看 ufw 防火牆規則序號
```sh
sudo ufw status numbered
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw status numbered
狀態： 啓用

     至                          動作          來自
     -                          --          --
[ 1] 22                         ALLOW IN    192.168.1.0/24            
[ 2] 3389                       ALLOW IN    192.168.1.0/24            
[ 3] 9090                       ALLOW IN    192.168.1.0/24
```
#### 3-3-2. 刪除序號 [3] 規則
```sh
sudo ufw delete 3
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw delete 3
刪除中:
 allow from 192.168.1.0/24 to any port 9090
 繼續執行(y|n)？ y
已刪除規則
root@31-ub-26-dev:/home/dengkai# sudo ufw reload
已經重新載入防火牆
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態： 啓用

至                          動作          來自
-                          --          --
22                         ALLOW       192.168.1.0/24            
3389                       ALLOW       192.168.1.0/24
```
### 3-4. 實作範例
#### 3-4-1. 新增 ufw 防火牆規則 (ssh、mstsc、cockpit)
```sh
sudo ufw allow from 192.168.1.0/24 to any port 22
sudo ufw allow from 192.168.1.0/24 to any port 3389
sudo ufw allow from 192.168.1.0/24 to any port 3390
sudo ufw allow from 192.168.1.0/24 to any port 9090
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw allow from 192.168.1.0/24 to any port 22
sudo ufw allow from 192.168.1.0/24 to any port 3389
sudo ufw allow from 192.168.1.0/24 to any port 9090
已添加規則
已添加規則
已添加規則
root@31-ub-26-dev:/home/dengkai# sudo ufw reload
已經重新載入防火牆
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態： 啓用

至                          動作          來自
-                          --          --
22                         ALLOW       192.168.1.0/24            
3389                       ALLOW       192.168.1.0/24            
9090                       ALLOW       192.168.1.0/24
```
#### 3-4-2. 刪除 ufw 防火牆規則 (ssh、mstsc、cockpit)
```sh
sudo ufw delete allow from 192.168.1.0/24 to any port 22
sudo ufw delete allow from 192.168.1.0/24 to any port 3389
sudo ufw delete allow from 192.168.1.0/24 to any port 9090
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw delete allow from 192.168.1.0/24 to any port 22
sudo ufw delete allow from 192.168.1.0/24 to any port 3389
sudo ufw delete allow from 192.168.1.0/24 to any port 9090
已刪除規則
已刪除規則
已刪除規則
root@31-ub-26-dev:/home/dengkai# sudo ufw reload
已經重新載入防火牆
root@31-ub-26-dev:/home/dengkai# sudo ufw status
狀態： 啓用
```
## 4. 重設 UFW 規則
```sh
sudo ufw reset
```
```console
root@31-ub-26-dev:/home/dengkai# sudo ufw reset
重設所有規則為預設值。繼續執行(y|n)？ y
備份 'user.rules' 到 '/etc/ufw/user.rules.20260502_160340
備份 'before.rules' 到 '/etc/ufw/before.rules.20260502_160340
備份 'after.rules' 到 '/etc/ufw/after.rules.20260502_160340
備份 'user6.rules' 到 '/etc/ufw/user6.rules.20260502_160340
備份 'before6.rules' 到 '/etc/ufw/before6.rules.20260502_160340
備份 'after6.rules' 到 '/etc/ufw/after6.rules.20260502_160340
```