## Ubuntu 26.04 AMD Ryzen 7 4800H 降速
在 Ubuntu 26.04 中，針對 AMD Ryzen 7 4800H 處理器進行「降速」（降低主頻、限制功耗或關閉自動加速）來達到降溫與省電的目的，主要可以透過關閉核心加速（Core Performance Boost）或調整調節器（Governor）來實現。
以下是三種最直接、有效的降速方法：
### 方法一：直接關閉 CPU 自動加速 (推薦降溫明顯)
Ryzen 7 4800H 的基礎頻率為 2.9GHz，加速頻率可達 4.2GHz。關閉加速(Boost)可以讓 CPU 最高只運行在 2.9GHz，能大幅降低發熱量。
#### 1. 暫時關閉(重啟後失效)：
開啟終端機，根據 Ubuntu 26.04 預設的 AMD 驅動模式，輸入以下指令：
```sh
# 如果使用的是 amd-pstate 驅動（Ubuntu 26.04 預設）
echo 0 | sudo tee /sys/devices/system/cpu/amd_pstate/cpb_boost

# 如果上述路徑不存在，請嘗試通用路徑：
echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
```
#### 2. 永久關閉(透過修改 GRUB 核心參數)：
(1) 輸入指令編輯設定檔：
```sh
sudo nano /etc/default/grub
```
(2) 找到 ```GRUB_CMDLINE_LINUX_DEFAULT``` 這一行，在引號內加入 ```amd_pstate=passive```(改為被動模式以便手動控頻)。例如：
```conf
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_pstate=passive"
```
(3) 存檔離開(Ctrl+O，Enter，Ctrl+X)。
(4) 更新 GRUB 並重啟電腦：
```sh
sudo update-grub
sudo reboot
```
(5) 重啟後，執行以下指令即可完美鎖定關閉加速：
```sh
echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
```
### 方法二：切換 CPU 電源調節器(Governor)
將 CPU 的工作模式從「效能(Performance)」或「排程(Schedutil)」切換至「省電(Powersave)」模式，系統會主動壓低 CPU 頻率。
#### 1. 安裝核心效能管理工具：
```sh
sudo apt install linux-tools-common linux-tools-generic
```
#### 2. 將所有 CPU 核心強制設定為 Powersave(省電) 模式：
```sh
sudo cpupower frequency-set -g powersave
```
#### 3. 檢查當前頻率與模式是否生效：
```sh
cpupower frequency-info
```
### 方法三：使用圖形化工具(適合不想用指令的使用者)
#### 1. 安裝 Cpufreq 擴充套件(GNOME 桌面環境)：
(1) 在 Ubuntu 軟體中心或終端機安裝：
```sh
sudo apt install gnome-shell-extension-cpufreq
```
(2) 啟用後，畫面上方的狀態列會出現 CPU 圖示，點擊即可直接滑動調整最大頻率百分比，或一鍵切換成「Powersave」模式。
#### 2. 安裝 Slimbook Battery：
這是一款針對筆記型電腦設計的電源管理軟體，提供「節能(Energy Saving)」模式，會自動幫您的 Ryzen 4800H 進行降速與節電優化。
### 
如果需要更進階的功耗牆(TDP)限制(例如將 45W 功耗壓到 25W)，可以參考 GitHub 上的開源工具 [RyzenAdj](https://github.com/flygoat/ryzenadj)。
##### 參考資料：
[1] [Managing CPU frequency for AMD on Ubuntu 22.04](https://smalldatum.blogspot.com/2024/10/managing-cpu-frequency-for-amd-on.html)
[2] [關掉 AMD Ryzen 7 4800H 的 CPU 增強功能](https://www.reddit.com/r/Ubuntu/comments/13elvor/is_it_possible_to_disable_cpu_boost_for_amd_ryzen/?tl=zh-hant)
[3] [Turning off processor boost](https://bbs.archlinux.org/viewtopic.php?id=291561)
[4] [Is there a way to set amd_pstate = passive permanently?](https://www.reddit.com/r/NobaraProject/comments/1b0fgvm/is_there_a_way_to_set_amd_pstate_passive/)
[5] [CPU frequency scaling](https://wiki.archlinux.org/title/CPU_frequency_scaling)
[6] [使用cpufrequtils查看调整cpu频率及模式](https://blog.csdn.net/qq_33921750/article/details/134131598)
[7] [How to Configure CPU Governor and Power Management on Ubuntu](https://oneuptime.com/blog/post/2026-01-15-configure-cpu-governor-power-management-ubuntu/view)
[8] [Ubuntu下利用RyzenAdj优化AMD Ryzen移动处理器性能与散热（以R9000k 2021 5900hx 3080为例）](https://blog.csdn.net/weixin_26899659/article/details/160166719)
[9] [Adjust power management settings for Ryzen Mobile Processors.](https://github.com/flygoat/ryzenadj)