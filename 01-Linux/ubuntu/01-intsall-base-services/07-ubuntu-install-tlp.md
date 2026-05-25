## 安裝 TLP 可以大幅最佳化筆電的電池續航力與電源管理
在 Ubuntu 26.04 中，安裝 TLP 可以大幅最佳化筆電的電池續航力與電源管理。然而，新版本的 TLP 會與系統預設的 ```power-profiles-daemon``` 衝突，因此建議在安裝 TLP 前先將其移除，以免造成桌面環境異常。
### 安裝與設定步驟
#### 步驟 1：移除預設的電源管理服務
開啟終端機（Terminal）並輸入以下指令，這會移除預設的電源設定並安裝 TLP：
```sh
sudo apt remove power-profiles-daemon
sudo apt install tlp tlp-rdw
```
<p style="color: red;">(注意：如果您使用的是 Ubuntu Studio 等桌面環境，請不要移除此預設服務，以免破壞桌面環境。)</p>

#### 步驟 2：啟動 TLP 服務
安裝完成後，執行以下指令來啟用並啟動 TLP 服務：
```sh
sudo systemctl enable --now tlp
```
#### 步驟 3：檢查 TLP 狀態
您可以透過以下指令確認 TLP 是否正在運作，以及目前的電源設定檔：
```sh
sudo tlp-stat -s
```
若想查看詳細的電池與硬體狀態，可以使用：
```sh
sudo tlp-stat -b
```
### 延伸實用功能：電池充電閾值
如果您希望保護筆電電池，限制充電上限（例如充到 80% 就停止充電，延長電池壽命），可以安裝 acpi-call 工具來配合 TLP 使用（支援多數 ThinkPad、ASUS 及部分機型）：
```sh
sudo apt install acpi-call-dkms
```
安裝完成後，可透過編輯 ```/etc/tlp.conf``` 設定檔來調整 ```START_CHARGE_THRESH_BAT0```（開始充電閾值）與 ```STOP_CHARGE_THRESH_BAT0```（停止充電閾值）的數值。
更多詳細的進階設定與機型相容性，可參考[ TLP 官方網站](https://www.ubuntuupdates.org/package/core/resolute/main/base/tlp)。
## 限制 CPU 頻率
### 步驟 1：修改 TLP 配置檔
打開 TLP 的主配置檔（Ubuntu 新版通常位於 ```/etc/tlp.conf```）：
```sh
sudo nano /etc/tlp.conf
```
在檔案中找到以下對應參數，刪除前方的 # 註解符號並修改數值。
#### 1. 如果你的 CPU 驅動是 ```intel_pstate``` 或 ```amd_pstate```（現代主流 CPU）
這類 CPU 不建議直接鎖定頻率數值，而是要限制最大效能百分比：
```ini
# 限制接上電源（AC）時的最大效能為 70%，使用電池（BAT）時為 50%
CPU_MAX_PERF_ON_AC=70
CPU_MAX_PERF_ON_BAT=50
```
---
<p>
The amd-pstate driver is built directly into the modern Linux kernel used by Ubuntu 26.04, so you don't need to download or install any external files. You just need to enable it by adding it as a boot parameter in your GRUB configuration.<br>
Follow these steps to activate the driver:<br>
<b>Step 1: Edit the GRUB Configuration</b><br>
<ol>
<li>Open your terminal.</li>
<li>Open the GRUB configuration file using the nano editor:</li>
</ol>

```sh
sudo nano /etc/default/grub
```
**Step 2: Add the ```amd_pstate``` Parameter**<br>
<ol>
<li>Use your arrow keys to find the line beginning with GRUB_CMDLINE_LINUX_DEFAULT.</li>
<li>Add amd_pstate=active to the list of parameters inside the double quotes. Ensure there is a space separating it from other parameters (like quiet splash).<br>Example: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_pstate=active"</li>
<li>Press Ctrl+O then Enter to save, and Ctrl+X to exit.</li>
</ol>

**Step 3: Update GRUB and Reboot**<br>
<ol start=1>
<li>Apply the changes by updating GRUB:</li>
</ol>

```sh
sudo update-grub
```

<ol start=2>
<li>Restart your computer:</li>
</ol>

```sh
sudo reboot
```

**Step 4: Verify the Driver**<br>
After rebooting, open your terminal and run the following command to check if the driver is successfully active:<br>

```sh
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
```
<p style="color: red;">If successful, the terminal will output amd-pstate-epp or amd-pstate.</p>

</p>

---

#### 2. 如果你的 CPU 驅動是舊款的 ```acpi-cpufreq```
可以直接鎖定具體的最高頻率（頻率數值請參考 ```tlp-stat -p``` 輸出的可用頻率）：
```ini
# 範例：將最高頻率鎖定在 1.5GHz (1500000 kHz)
CPU_SCALING_MAX_FREQ_ON_AC=1500000
CPU_SCALING_MAX_FREQ_ON_BAT=1200000
```
#### 3. 強烈建議：關閉 CPU 核心加速 (Turbo Boost / Core Performance Boost)
這是最立竿見影的降速降溫手段，關閉後 CPU 只會運行在基礎頻率：
```ini
# 0 代表關閉加速，1 代表開啟
CPU_BOOST_ON_AC=0
CPU_BOOST_ON_BAT=0
```
#### 4. 調整能源偏好策略 (EPP)
將調頻傾向完全改為省電模式：
```ini
CPU_ENERGY_PERF_POLICY_ON_AC=power
CPU_ENERGY_PERF_POLICY_ON_BAT=power
```
修改完成後，按下 ```Ctrl + O``` 儲存，```Ctrl + X``` 離開。
### 步驟 2：重啟 TLP 服務讓設定生效
執行以下指令重新啟動 TLP：
```sh
sudo tlp start
sudo systemctl restart tlp
```
### 步驟 3：驗證降速效果
你可以使用以下指令查看當前 CPU 的限制狀態與實時頻率：
```sh
sudo tlp-stat -p
```
在輸出中檢查 ```cpu max performance``` 百分比或 ```scaling_max_freq``` 是否已經變成你剛才設定的限制數值。
##### 參考資料：
<ol>
<li><a href="https://www.ubuntuupdates.org/package/core/resolute/main/base/tlp" target="_blank">Package "tlp"</a></li>
<li><a href="https://discourse.ubuntu.com/t/ubuntu-studio-26-04-lts-release-notes/79113" target="_blank">Ubuntu Studio 26.04 LTS Release Notes</a></li>
<li><a href="https://linuxize.com/post/things-to-do-after-installing-ubuntu-26-04/" target="_blank">Things to Do After Installing Ubuntu 26.04</a></li>
<li><a href="https://askubuntu.com/questions/1169677/can-not-launch-tlp" target="_blank">Can not launch tlp</a></li>
<li><a href="https://www.reddit.com/r/Ubuntu/comments/1sxrtp8/laptop_battery_management_in_2604/?tl=zh-hant" target="_blank">筆記型電腦電池管理於 26.04</a></li>
<li><a href="https://oneuptime.com/blog/post/2026-03-02-how-to-set-up-tlp-for-laptop-power-management-on-ubuntu/view" target="_blank">How to Set Up TLP for Laptop Power Management on Ubuntu</a></li>
<li><a href="https://amanusk.medium.com/an-extensive-guide-to-optimizing-a-linux-laptop-for-battery-life-and-performance-27a7d853856c" target="_blank">An extensive guide to optimizing a Linux laptop for battery life and performance</a></li>
<li><a href="https://linrunner.de/tlp/settings/processor.html" target="_blank">CPU_DRIVER_OPMODE_ON_AC/BAT/SAV</a></li>
<li><a href="https://linuxblog.io/boost-battery-life-on-linux-laptop-tlp/" target="_blank">Boost Battery Life on Your Linux Laptop with TLP</a></li>
<li><a href="https://www.reddit.com/r/linuxmasterrace/comments/n7xy1n/tlp_can_adjust_your_cpu_governor_and_save_your/" target="_blank">TLP can adjust your CPU governor and save your laptop power.</a></li>
<li><a href="https://forums.linuxmint.com/viewtopic.php?t=176091" target="_blank">Limit CPU max frequency</a></li>
</ol>