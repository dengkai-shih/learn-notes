# How to Install Google Chrome on Ubuntu 26.04 : [reference](https://linuxconfig.org/how-to-install-google-chrome-on-ubuntu-26-04)
## 1. Update system packages
```sh
sudo apt update
```
## 2. Download the Google Chrome .deb package
```sh
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
## 3. Install the downloaded package
```sh
sudo apt install ./google-chrome-stable_current_amd64.deb
```
## 4. Verify the installation
```sh
google-chrome --version
Google Chrome 146.x.xxxx.xx
```
# Updating Google Chrome on Ubuntu 26.04
## 1. Update system packages
```sh
sudo apt update
sudo apt upgrade
```
## 2. Update Chrome specifically
```sh
sudo apt install --only-upgrade google-chrome-stable
```
# Uninstalling Google Chrome from Ubuntu 26.04
## 1. Remove the Google Chrome package
```sh
sudo apt purge google-chrome-stable
```
## 2. Remove the Google repository
```sh
sudo rm /etc/apt/sources.list.d/google-chrome.list
```
## 3. Remove the Google signing key
```sh
sudo rm /etc/apt/trusted.gpg.d/google-chrome.gpg
```
## 4. Clean up user data 
```sh
sudo rm -rf ~/.config/google-chrome
sudo rm -rf ~/.cache/google-chrome
```