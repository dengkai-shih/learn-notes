# Git 常用指令表
本篇為常用的 Git 指令資訊。
## 1. Git 設定資訊
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git config --list``` | **列出所有 Git 在目前位置的設定值**（包含使用者名稱、信箱、編輯器偏好、遠端 URL 縮寫等）。 | (1) **System(系統層級)**：作用於整台電腦的所有使用者 (```--system```)。<br>(2) **Global(全域層級)**：作用於該使用者帳號的所有專案 (```--global```)。<br>(3) **Local(專案層級)**：作用於當前所在的專案目錄 (```--local```)。 |
| ```git config --global user.name "(userName)"``` | Git 中用來**查詢或設定「全域(Global)」使用者名稱**的指令。 | (2) **Global(全域層級)** |
| ```git config --global user.email "(e-mail)"``` |  Git 中用來**查詢或設定「全域(Global)」使用者 E-mail** 的指令。 | (2) **Global(全域層級)** |
| ```git config --local user.name "(userName)"``` | Git 中用來**查詢或設定「特定專案(本地儲存庫)」使用者名稱**的指令。 | (3) **Local(專案層級)** |
| ```git config --local user.email "(e-mail)"``` |  Git 中用來**查詢或設定「特定專案(本地儲存庫)」使用者 E-mail** 的指令。 | (3) **Local(專案層級)** |

## 2. init / clone / remove
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git clone <遠端儲存庫網址>``` | ```git clone``` **是用來將遠端的 Git 儲存庫(Repository)完整下載到本地電腦的指令**。 它不只下載檔案，還會同步所有的歷史提交紀錄、分支與標籤。 |  |
| ```git init``` | ```git init``` 是一個**用於當前目錄初始化一個全新 Git 本地儲存庫(Repository)的指令**。 |  |
| ```rm -rf .git``` | 執行 ```rm -rf .git``` 指令會**立即且永久刪除當前目錄下的 .git 隱藏資料夾，導致該專案完全脫離 Git 版本控制**。 |  |

## 3. remote
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git remote -v``` | ```git remote -v``` 是 Git 用來**列出目前專案中所有已設定的遠端倉庫(Remote Repositories)名稱及其對應 URL 網址**的指令。其中 -v 代表 --verbose（詳細資訊）。 | **欄位**<br>```origin```：遠端倉庫在本地端的縮寫代稱(預設通常為 origin)。<br>```https://...```：該遠端倉庫的實際儲存庫網址。<br>```(fetch)```：當你執行 ```git fetch``` 或 ```git pull``` 時，Git 會從這個網址下載資料。<br>```(push)```：當你執行 ```git push``` 時，Git 會把你的代碼推送到這個網址。 |
| ```git remote add <遠端倉庫別名> <遠端倉庫的 SSH 網址>``` | 這個指令 ```git remote add origin git@~.git``` 的主要作用是**將本地的 Git 專案連結到遠端的程式碼託管平台(如 GitHub、GitLab 或 Bitbucket)**。 | ```git remote add```：告訴 Git 你要新增一個遠端伺服器(Remote)的連線紀錄。<br>```origin```：這是遠端倉庫的**別名(Shorthand)**。Git 預設習慣命名為 origin，這樣以後推送程式碼時，就不需要每次都打一長串的網址，直接用 origin 代替即可。<br>```git@~.git```：這是遠端倉庫的 **SSH 連線網址**(實際操作時請替換成您在 GitHub 等平台上複製的真實網址，例如 git@github.com:username/repo.git)。 |
| `````` |  |  |
| `````` |  |  |
| `````` |  |  |
| `````` |  |  |

## + 參考資料 +
#### 1. ["Git &rarr; Learn &rarr; Book (指令手冊)"](https://git-scm.com/book/zh-tw/v2/%e9%96%8b%e5%a7%8b-%e9%97%9c%e6%96%bc%e7%89%88%e6%9c%ac%e6%8e%a7%e5%88%b6)
#### 2. [Git 常用指令表 : https://ithelp.ithome.com.tw/m/articles/10241407](https://ithelp.ithome.com.tw/m/articles/10241407)