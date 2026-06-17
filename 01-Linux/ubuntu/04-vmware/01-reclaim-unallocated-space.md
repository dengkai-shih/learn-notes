#### 縮小 Ubuntu VMware 虛擬機器占用的實體硬碟空間
#### 1. 清理 Ubuntu 系統中的更新文件資料
```sh
sudo apt autoremove
sudo apt clean
```
#### 2. 檔案系統重組 (線上重組即可，無須卸載任何設備)
```sh
sudo e4defrag /
```
#### 3. 未使用空間填入空白資料, 好讓 VMware 知道那些空間是可以被回收的
```sh
# 在終端機中執行以下命令，將剩餘空間填入零。
sudo dd if=/dev/zero of=blankfreespace bs=1M; sudo sync;
```
```sh
# 命令完成後（可能會顯示“設備上沒有剩餘空間”，這是正常現象），請刪除臨時檔案以釋放空間。
sudo rm blankfreespace
```
#### 4. 執行釋放實體硬碟空間的操作
```sh
sudo vmware-toolbox-cmd disk shrinkonly
```
#### + reference +
<ol>
<li><a href="https://www.google.com/search?q=vm+workstation+clean+disk+ubuntu&rlz=1C1CHBF_zh-TWTW1056TW1056&oq=vm+workstation+clean+disk+ub&gs_lcrp=EgZjaHJvbWUqCQgBECEYChigATIGCAAQRRg5MgkIARAhGAoYoAHSAQkxNDg0M2owajeoAgCwAgA&sourceid=chrome&ie=UTF-8" target="_blank">google search</a></li>
<li><a href="https://wordpress.cine.idv.tw/index.php/2018/09/16/vmware-workstation-ubuntu-virtual-machine-shrink-disk/" target="_blank">縮小 Ubuntu VMware 虛擬機器占用的實體硬碟空間</a></li>
<li><a href="https://www.reddit.com/r/vmware/comments/xa13zx/reclaim_unallocated_space_from_guest_os_vmware/" target="_blank">Reclaim unallocated space from Guest OS - vmware workstation 14.0</a></li>
<li><a href="https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space" target="_blank">How do I free up disk space?</a></li>
<li><a href="https://www.omgubuntu.co.uk/2016/08/5-ways-free-up-space-on-ubuntu" target="_blank">Essential Guide: 5 Simple Ways To Free Up Space on Ubuntu</a></li>
<li><a href="https://superuser.com/questions/890710/vmware-player-disk-clean-up" target="_blank">VMware player disk clean up</a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>
