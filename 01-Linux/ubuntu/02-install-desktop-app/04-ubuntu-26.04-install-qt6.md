## [Google AI Search - "ubuntu 26.04 install qt6"](https://www.google.com/search?q=ubuntu+26.04+install+qt6&sca_esv=1015d95145c943a4&sxsrf=APpeQnuihiVlSw3y9luNLL-IcXN9qTdJOA%3A1784817323119&udm=50&fbs=ABfTbFUhNGvvPEUFOvrsPMHwBXgOKQbaUEtApl9j-7vdAXA5Kb0HTTjhjpnGD4ELhmN7TaR14-bzLmC-ncmxsEja4CjqDH4szK6Li8SYvn588mzh2J2BegxzNeDbbF9nGEtvlbsSpL1rutgEwhykSoI9cK4LP1yksUz4UX9wRatqzWHNFsc_pZz5h6MQJJRQYqVu8DUuLxa1&aep=1&ntc=1&cs=1&sa=X&ved=2ahUKEwjx86HUgumVAxULk68BHVJfINMQ2J8OegQIERAD&biw=1920&bih=856&dpr=1&mstk=AUtExfC_kmHVLPFRbhcfa6Q1eaPjSlcwi1VeHJb7zfRIKhToYz2DZ3wyxVkjh8ZKFksMSGxn_9J3haLz4WsK0HUlbhI8GpAHDpEdmqDA1O4EVn3CwhCyA_NtGZV6ZFfw3HIYNgDQvnnmzVr-mbFrdPN1BBKf5SIV7GwCzJs&csuir=1&mtid=1Slias3iMJ-0vr0P0djq-AE&sei=7yliavUfmZu-vQ_AisigDw)
在 Ubuntu 26.04 LTS 中，Qt 5 已被官方全面移除，系统的默认核心与软件仓库已全面转向 Qt 6。在 Ubuntu 26.04 上安装 Qt 6 非常直接。 [1] 
以下是两种最常用的安装方式：
## 方法一：通过 Ubuntu 软件仓库安装（推荐，最快捷）
如果你只需要常规的 Qt 6 开发库、编译工具或者运行依赖，直接使用系统的 apt 包管理器安装即可。系统的官方仓库会提供一个非常稳定的 Qt 6 基础版本。 [2, 3] 
1. 更新系统软件包列表
```bash
sudo apt update
```
2. 安装基础编译环境（GCC/G++/Make 等）
```bash
sudo apt install build-essential libgl1-mesa-dev
```
3. 安装 Qt 6 开发基础包及工具
```bash
sudo apt install qt6-base-dev qt6-base-dev-tools
```
4. 选装：安装 Qt Creator 集成开发环境
```bash
sudo apt install qtcreator
```
------------------------------
## 方法二：使用 Qt 官方在线安装器（适合需要特定最新版本或跨平台组件）
如果你需要安装特定的 Qt 6 商业/开源最新子版本（例如 Qt 6.8+ 或最新的 LTS 版本），或者需要 Android/WASM 等交叉编译组件，建议使用官方的在线安装器。 [3, 4] 
1. 安装基础依赖
为了确保安装器和编译环境正常运行，先安装图形与基础开发依赖： [3, 5] 
```bash
sudo apt update
sudo apt install build-essential libgl1-mesa-dev libxcb-xinerama0 libxkbcommon-dev
```
2. 下载在线安装器
前往 [Qt 官网下载页面](https://www.qt.io/download-open-source) 下载 Linux 版本的在线安装器 qt-unified-linux-x64-online.run。你也可以通过国内镜像源（如清华大学开源软件镜像站）快速下载： [4, 6, 7] 
```bash
wget https://mirrors.tuna.tsinghua.edu.cn/qt/official_releases/online_installers/qt-unified-linux-x64-online.run
```
3. 赋予执行权限并运行
```bash
chmod +x qt-unified-linux-x64-online.run
```
如果你在中国大陆，可以通过指定镜像源参数来大幅加速组件的下载： [4] 
```bash
./qt-unified-linux-x64-online.run --mirror https://mirrors.tuna.tsinghua.edu.cn/qt
```
4. 图形界面安装步骤

* 登录你的 Qt 账号。
* 选择安装路径。
* 在组件选择页面，勾选你需要的 Qt 6.x 具体版本（例如：Qt 6.8 下的 Desktop gcc 64-bit）。
* 点击安装并等待完成。 [4, 8] 

------------------------------
## 验证安装
安装完成后，你可以通过终端命令验证 qmake 的版本是否已经是 Qt 6： [8] 
```bash
qmake6 --version
```
或者（如果配置了环境变量）：
```bash
qmake --version
```
请问你是打算用 C++ 还是 Python (PySide6) 进行开发？如果有需要，我可以为你提供一个简单的 CMake 项目配置模板来帮助你快速构建第一个 Qt 6 程序。

[1] [https://www.linuxmi.com](https://www.linuxmi.com/ubuntu-26-04-qt-6.html)
[2] [https://forum.qt.io](https://forum.qt.io/topic/148418/how-to-install-qt6-latest-for-ubuntu-22-jammy-fish)
[3] [https://blog.csdn.net](https://blog.csdn.net/yiyi135/article/details/151763111)
[4] [https://blog.csdn.net](https://blog.csdn.net/qq_45461410/article/details/132107831)
[5] [https://cloud.tencent.com](https://cloud.tencent.com/developer/article/2450232)
[6] [https://blog.csdn.net](https://blog.csdn.net/free555/article/details/128131875)
[7] [https://zhuanlan.zhihu.com](https://zhuanlan.zhihu.com/p/597695401)
[8] [https://www.cnblogs.com](https://www.cnblogs.com/ljbguanli/p/19143980)
