# 安裝 ssh server 服務
## 1. 系統更新
```sh
sudo apt update
sudo apt upgrade
```
```console
root@31-ub-26-dev:/home/dengkai# sudo apt update
已有:1 http://security.ubuntu.com/ubuntu resolute-security InRelease                                                 
已有:2 http://archive.ubuntu.com/ubuntu resolute InRelease
已有:3 http://archive.ubuntu.com/ubuntu resolute-updates InRelease
已有:4 http://archive.ubuntu.com/ubuntu resolute-backports InRelease
所有套件都是最新。

root@31-ub-26-dev:/home/dengkai# sudo apt upgrade
Summary:                         
  Upgrading: 0, Installing: 0, Removing: 0, Not Upgrading: 0
```
## 2. 安裝 ssh server 服務
```sh
sudo apt install openssh-server
```
```console
root@31-ub-26-dev:/home/dengkai# sudo apt install openssh-server
Installing:                      
  openssh-server

Installing dependencies:
  ncurses-term  openssh-sftp-server  ssh-import-id

建議套件：
  molly-guard  monkeysphere  ssh-askpass

Summary:
  Upgrading: 0, Installing: 4, Removing: 0, Not Upgrading: 0
  Download size: 949 kB
  Space needed: 7,581 kB / 784 GB available

Continue? [Y/n] Y
下載:1 http://archive.ubuntu.com/ubuntu resolute/main amd64 ncurses-term all 6.6+20251231-1 [280 kB]
下載:2 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 openssh-sftp-server amd64 1:10.2p1-2ubuntu3.2 [37.5 kB]
下載:3 http://archive.ubuntu.com/ubuntu resolute-updates/main amd64 openssh-server amd64 1:10.2p1-2ubuntu3.2 [622 kB]
下載:4 http://archive.ubuntu.com/ubuntu resolute/main amd64 ssh-import-id all 5.11-0ubuntu4 [10.2 kB]
取得 949 kB 用了 3s (278 kB/s)           
正在預先設定套件 ...
選取了原先未選的套件 ncurses-term。
（讀取資料庫 ... 目前共安裝了 177124 個檔案和目錄。）
正在準備解包 .../ncurses-term_6.6+20251231-1_all.deb……
解開 ncurses-term (6.6+20251231-1) 安裝中...
選取了原先未選的套件 openssh-sftp-server。
正在準備解包 .../openssh-sftp-server_1%3a10.2p1-2ubuntu3.2_amd64.deb……
解開 openssh-sftp-server (1:10.2p1-2ubuntu3.2) 安裝中...
選取了原先未選的套件 openssh-server。
正在準備解包 .../openssh-server_1%3a10.2p1-2ubuntu3.2_amd64.deb……
解開 openssh-server (1:10.2p1-2ubuntu3.2) 安裝中...
選取了原先未選的套件 ssh-import-id。
正在準備解包 .../ssh-import-id_5.11-0ubuntu4_all.deb……
解開 ssh-import-id (5.11-0ubuntu4) 安裝中...
設定 openssh-sftp-server (1:10.2p1-2ubuntu3.2) ...
設定 openssh-server (1:10.2p1-2ubuntu3.2) ...
Creating config file /etc/ssh/sshd_config with new version
Creating user 'sshd' (sshd user) with UID 973 and GID 65534.
Created symlink '/etc/systemd/system/sockets.target.wants/ssh.socket' → '/usr/lib/systemd/system/ssh.socket'.
Created symlink '/etc/systemd/system/ssh.service.requires/ssh.socket' → '/usr/lib/systemd/system/ssh.socket'.
Created symlink '/etc/systemd/system/ssh.service.wants/sshd-keygen.service' → '/usr/lib/systemd/system/sshd-keygen.service'.
Created symlink '/etc/systemd/system/sshd.service.wants/sshd-keygen.service' → '/usr/lib/systemd/system/sshd-keygen.service'.
Created symlink '/etc/systemd/system/sshd@.service.wants/sshd-keygen.service' → '/usr/lib/systemd/system/sshd-keygen.service'.
Created symlink '/etc/systemd/system/ssh.socket.wants/sshd-keygen.service' → '/usr/lib/systemd/system/sshd-keygen.service'.
設定 ssh-import-id (5.11-0ubuntu4) ...
設定 ncurses-term (6.6+20251231-1) ...
執行 man-db (2.13.1-1build1) 的觸發程式……
執行 ufw (0.36.2-9build1) 的觸發程式……
```
## 3. 啟動 ssh server 服務
```sh
sudo systemctl enable ssh
sudo systemctl restart ssh
sudo systemctl status ssh
```
```console
root@31-ub-26-dev:/home/dengkai# sudo systemctl enable ssh
sudo systemctl restart ssh
sudo systemctl status ssh
Synchronizing state of ssh.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable ssh
Created symlink '/etc/systemd/system/sshd.service' → '/usr/lib/systemd/system/ssh.service'.
Created symlink '/etc/systemd/system/multi-user.target.wants/ssh.service' → '/usr/lib/systemd/system/ssh.service'.
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/usr/lib/systemd/system/ssh.service; enabled; preset: enabled)
     Active: active (running) since Sat 2026-05-02 16:19:50 CST; 26ms ago
 Invocation: c5b3d94b31644cf59112713cb339a8ae
TriggeredBy: ● ssh.socket
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 24526 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 24528 (sshd)
      Tasks: 1 (limit: 37167)
     Memory: 1.4M (peak: 2M)
        CPU: 33ms
     CGroup: /system.slice/ssh.service
             └─24528 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

 5月 02 16:19:50 31-ub-26-dev systemd[1]: Starting ssh.service - OpenBSD Secure Shell server...
 5月 02 16:19:50 31-ub-26-dev sshd[24528]: Server listening on 0.0.0.0 port 22.
 5月 02 16:19:50 31-ub-26-dev sshd[24528]: Server listening on :: port 22.
 5月 02 16:19:50 31-ub-26-dev systemd[1]: Started ssh.service - OpenBSD Secure Shell server.
```
## 4. ssh server 服務防火牆規則設定
### 4-1. add firewall rule
```sh
sudo ufw allow from 140.117.121.23 to any port 22
sudo ufw allow from 140.117.121.24 to any port 22
sudo ufw allow from 140.117.121.26 to any port 22
sudo ufw allow from 140.117.121.27 to any port 22
sudo ufw allow from 140.117.121.40 to any port 22
sudo ufw allow from 140.117.121.41 to any port 22
sudo ufw allow from 140.117.121.42 to any port 22
sudo ufw allow from 140.117.121.43 to any port 22
sudo ufw allow from 140.117.121.120 to any port 22
```
### 4-2. delete firewall rule
```sh
sudo ufw delete allow from 140.117.121.23 to any port 22
sudo ufw delete allow from 140.117.121.24 to any port 22
sudo ufw delete allow from 140.117.121.26 to any port 22
sudo ufw delete allow from 140.117.121.27 to any port 22
sudo ufw delete allow from 140.117.121.40 to any port 22
sudo ufw delete allow from 140.117.121.41 to any port 22
sudo ufw delete allow from 140.117.121.42 to any port 22
sudo ufw delete allow from 140.117.121.43 to any port 22
sudo ufw delete allow from 140.117.121.120 to any port 22
```
### 4-3. reload firewall rules
```sh
sudo ufw reload
sudo systemctl restart ufw
```
## 5 install wtmpdb, lastlog2 app
```sh
sudo apt install wtmpdb
sudo apt install lastlog2
```
```console
root@31-ub-26-dev:/home/dengkai# sudo apt install wtmpdb
Installing:                      
  wtmpdb

Installing dependencies:
  libpam-wtmpdb  libwtmpdb0

Summary:
  Upgrading: 0, Installing: 3, Removing: 0, Not Upgrading: 0
  Download size: 43.0 kB
  Space needed: 174 kB / 784 GB available

Continue? [Y/n] Y
下載:1 http://archive.ubuntu.com/ubuntu resolute/universe amd64 libwtmpdb0 amd64 0.75.0-5ubuntu1 [11.9 kB]
下載:2 http://archive.ubuntu.com/ubuntu resolute/universe amd64 libpam-wtmpdb amd64 0.75.0-5ubuntu1 [9,544 B]
下載:3 http://archive.ubuntu.com/ubuntu resolute/universe amd64 wtmpdb amd64 0.75.0-5ubuntu1 [21.6 kB]
取得 43.0 kB 用了 2s (23.1 kB/s) 
選取了原先未選的套件 libwtmpdb0:amd64。
（讀取資料庫 ... 目前共安裝了 180068 個檔案和目錄。）
正在準備解包 .../libwtmpdb0_0.75.0-5ubuntu1_amd64.deb……
解開 libwtmpdb0:amd64 (0.75.0-5ubuntu1) 安裝中...
選取了原先未選的套件 libpam-wtmpdb:amd64。
正在準備解包 .../libpam-wtmpdb_0.75.0-5ubuntu1_amd64.deb……
解開 libpam-wtmpdb:amd64 (0.75.0-5ubuntu1) 安裝中...
選取了原先未選的套件 wtmpdb。
正在準備解包 .../wtmpdb_0.75.0-5ubuntu1_amd64.deb……
解開 wtmpdb (0.75.0-5ubuntu1) 安裝中...
設定 libwtmpdb0:amd64 (0.75.0-5ubuntu1) ...
設定 libpam-wtmpdb:amd64 (0.75.0-5ubuntu1) ...
設定 wtmpdb (0.75.0-5ubuntu1) ...
Converting wtmp login records into wtmpdb database ... done
Created symlink '/etc/systemd/system/default.target.wants/wtmpdb-update-boot.service' → '/usr/lib/systemd/system/wtmpdb-update-boot.service'.
執行 man-db (2.13.1-1build1) 的觸發程式……
執行 libc-bin (2.43-2ubuntu2) 的觸發程式……
root@31-ub-26-dev:/home/dengkai# sudo apt install lastlog2
Installing:                      
  lastlog2

Installing dependencies:
  liblastlog2-2  libpam-lastlog2

Summary:
  Upgrading: 0, Installing: 3, Removing: 0, Not Upgrading: 0
  Download size: 81.7 kB
  Space needed: 227 kB / 784 GB available

Continue? [Y/n] Y
下載:1 http://archive.ubuntu.com/ubuntu resolute/main amd64 liblastlog2-2 amd64 2.41.3-3ubuntu2 [26.7 kB]
下載:2 http://archive.ubuntu.com/ubuntu resolute/universe amd64 lastlog2 amd64 2.41.3-3ubuntu2 [27.9 kB]
下載:3 http://archive.ubuntu.com/ubuntu resolute/universe amd64 libpam-lastlog2 amd64 2.41.3-3ubuntu2 [27.1 kB]
取得 81.7 kB 用了 2s (36.3 kB/s)          
選取了原先未選的套件 liblastlog2-2:amd64。
（讀取資料庫 ... 目前共安裝了 180096 個檔案和目錄。）
正在準備解包 .../liblastlog2-2_2.41.3-3ubuntu2_amd64.deb……
解開 liblastlog2-2:amd64 (2.41.3-3ubuntu2) 安裝中...
選取了原先未選的套件 lastlog2。
正在準備解包 .../lastlog2_2.41.3-3ubuntu2_amd64.deb……
解開 lastlog2 (2.41.3-3ubuntu2) 安裝中...
選取了原先未選的套件 libpam-lastlog2:amd64。
正在準備解包 .../libpam-lastlog2_2.41.3-3ubuntu2_amd64.deb……
解開 libpam-lastlog2:amd64 (2.41.3-3ubuntu2) 安裝中...
設定 liblastlog2-2:amd64 (2.41.3-3ubuntu2) ...
設定 libpam-lastlog2:amd64 (2.41.3-3ubuntu2) ...
設定 lastlog2 (2.41.3-3ubuntu2) ...
執行 man-db (2.13.1-1build1) 的觸發程式……
執行 libc-bin (2.43-2ubuntu2) 的觸發程式……
```