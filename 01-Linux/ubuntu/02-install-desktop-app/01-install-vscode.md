# Install VSCcode : [Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux)
## 1. To manually install the apt repository : Run the following script
```sh
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
```
## 2. Then update the package cache and install the package using :
```sh
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```