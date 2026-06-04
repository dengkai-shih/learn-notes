<h3>安裝 OpenClaw 服務 <span style="font-size: 70%;"><a href="https://openclaw.com.tw/" target="_blank">[1]</a></span></h3>

#### 環境需求
<ol>
<li>Node.js 24 或 22.19 以上<br><span style="font-size: 80%;">安裝腳本會自動偵測並安裝對應版本。</sapn></li>
<li>AI 模型 API Key<br><span style="font-size: 80%;">OpenAI、Claude、Gemini API Key / Ollama 本地模型。</sapn></li>
<li>通訊平台帳號<br><span style="font-size: 80%;">準備一個 Telegram / WhatsApp / Line 帳號用於串接。</sapn></li>
</ol>

<p style="font-size: 80%;"><b>在 Ubuntu 上安裝 Homebrew 工具 <span style="font-size: 70%;"><a href="https://linuxcapable.com/how-to-install-homebrew-on-ubuntu-linux/" target="_blank">[2]</a></b></p>
<p style="font-size: 80%;"><b>1. 更新 Ubuntu 與前置作業</b></li></p>

```sh
# 更新 Ubuntu
sudo apt update

# 安裝必備軟體
sudo apt install -y build-essential procps curl file git
```

<p style="font-size: 80%;"><b>2. 執行 Homebrew 安裝程式</b></li></p>

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

<p style="font-size: 80%;"><b>3. 將 Homebrew 加入系統的 PATH 環境變數。</b></li></p>

```sh
BREW_SHELLENV='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"'
grep -qxF "$BREW_SHELLENV" ~/.bashrc || printf '%s\n' "$BREW_SHELLENV" >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
```

<p style="font-size: 80%;"><b>4. 驗證 Homebrew 安裝。</b></li></p>

```sh
brew --version
brew doctor
```

#### 安裝 OpenClaw
<p><b>方法一：一鍵安裝腳本</b><br>
<span style="font-size: 80%;">安裝腳本會自動偵測系統、安裝所需的 Node.js、安裝 OpenClaw，並啟動設定精靈。</sapn></p>

```sh
# 開啟終端機，執行（WSL2 亦適用）：
curl -fsSL https://openclaw.ai/install.sh | bash
```
<p><b>方法二：使用 npm 安裝</b><br>
<span style="font-size: 80%;">若你想自行管理 Node.js 版本，可改用 npm。請先安裝 Node.js，再安裝 OpenClaw。</sapn></p>
<p><span style="font-size: 80%;"><b>步驟 1：安裝 Node.js</b><br>
依你的發行版安裝 Node.js 24：</sapn></p>

```sh
# Ubuntu / Debian
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt-get install -y nodejs

# Fedora / RHEL
sudo dnf install nodejs
```

<p><span style="font-size: 80%;"><b>步驟 2：安裝 OpenClaw</b></sapn></p>

```sh
# 全域安裝 OpenClaw
npm install -g openclaw@latest

# 啟動設定精靈並安裝背景服務
openclaw onboard --install-daemon
```

#### 確認 OpenClaw 是否正常運作
<p><span style="font-size: 80%;">安裝完成後，執行以下指令確認 OpenClaw 正常運作：</span></p>

```sh
# 確認 CLI 是否可用
openclaw --version

# 檢查設定是否有問題
openclaw doctor

# 確認 Gateway 背景服務運作中
openclaw gateway status
```

#### 首次設定
<p><span style="font-size: 80%;">一鍵安裝腳本會在安裝完成後自動啟動設定精靈。若你改用 npm 安裝，或想重新設定，可手動執行：</span></p>

```sh
# 啟動設定精靈並安裝背景服務
openclaw onboard --install-daemon

# 設定精靈會引導你完成：
# 1. 選擇 AI 模型提供者
# 2. 輸入 API Key
# 3. 設定通訊平台串接
# 4. 安裝並啟動 Gateway 背景服務
```

#### + reference +
<ol>
<li><a href="https://openclaw.com.tw/" target="_blank">openclaw-TW</a></li>
<li><a href="https://linuxcapable.com/how-to-install-homebrew-on-ubuntu-linux/" target="_blank">How to Install Homebrew on Ubuntu 26.04, 24.04 and 22.04</a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>
