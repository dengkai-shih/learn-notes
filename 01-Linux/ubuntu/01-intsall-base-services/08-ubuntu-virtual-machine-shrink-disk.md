<h3 style="color: #930000;">縮小 Ubuntu VMware 虛擬機器占用的實體硬碟空間</h3>

<p style="font-size: 90%">1. 檔案系統重組 (線上重組即可，無須卸載任何設備)</p>

```sh
# Clean Junk Files Inside Ubuntu
sudo apt autoremove
sudo apt clean

# 檔案系統重組
sudo e4defrag /
```

<p style="font-size: 90%">2. 未使用空間填入空白資料, 好讓 VMware 知道那些空間是可以被回收的</p>

```sh
dd if=/dev/zero of=blankfreespace bs=1M; sync; rm blankfreespace;
```

<p style="font-size: 90%">3. 執行釋放實體硬碟空間的操作</p>

```sh
sudo vmware-toolbox-cmd disk shrinkonly
```

#### + reference +
<ol>
<li><a href="https://wordpress.cine.idv.tw/index.php/2018/09/16/vmware-workstation-ubuntu-virtual-machine-shrink-disk/" target="_blank">縮小 Ubuntu VMware 虛擬機器占用的實體硬碟空間</a></li>
<li><a href="" target="_blank"></a></li>
</ol>