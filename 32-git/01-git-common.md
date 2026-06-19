#### Git 常用指令表
本篇為常用的 Git 指令資訊。
##### 1. Git 設定資訊
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git config --list``` | **列出所有 Git 在目前位置的設定值**（包含使用者名稱、信箱、編輯器偏好、遠端 URL 縮寫等）。 | (1) **System(系統層級)**：作用於整台電腦的所有使用者 (```--system```)。<br>(2) **Global(全域層級)**：作用於該使用者帳號的所有專案 (```--global```)。<br>(3) **Local(專案層級)**：作用於當前所在的專案目錄 (```--local```)。 |
| ```git config --global user.name "(userName)"``` | Git 中用來**查詢或設定「全域(Global)」使用者名稱**的指令。 | (2) **Global(全域層級)** |
| ```git config --global user.email "(e-mail)"``` |  Git 中用來**查詢或設定「全域(Global)」使用者 E-mail** 的指令。 | (2) **Global(全域層級)** |
| ```git config --local user.name "(userName)"``` | Git 中用來**查詢或設定「特定專案(本地儲存庫)」使用者名稱**的指令。 | (3) **Local(專案層級)** |
| ```git config --local user.email "(e-mail)"``` |  Git 中用來**查詢或設定「特定專案(本地儲存庫)」使用者 E-mail** 的指令。 | (3) **Local(專案層級)** |

##### 2. init / clone / remove
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git clone <遠端儲存庫網址>``` | ```git clone``` **是用來將遠端的 Git 儲存庫(Repository)完整下載到本地電腦的指令**。 它不只下載檔案，還會同步所有的歷史提交紀錄、分支與標籤。 |  |
| ```git init``` | ```git init``` 是一個**用於當前目錄初始化一個全新 Git 本地儲存庫(Repository)的指令**。 |  |
| ```rm -rf .git``` | 執行 ```rm -rf .git``` 指令會**立即且永久刪除當前目錄下的 .git 隱藏資料夾，導致該專案完全脫離 Git 版本控制**。 |  |

##### 3. remote
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git remote -v``` | ```git remote -v``` 是 Git 用來**列出目前專案中所有已設定的遠端倉庫(Remote Repositories)名稱及其對應 URL 網址**的指令。其中 -v 代表 --verbose（詳細資訊）。 | **欄位**<br>```origin```：遠端倉庫在本地端的縮寫代稱(預設通常為 origin)。<br>```https://...```：該遠端倉庫的實際儲存庫網址。<br>```(fetch)```：當你執行 ```git fetch``` 或 ```git pull``` 時，Git 會從這個網址下載資料。<br>```(push)```：當你執行 ```git push``` 時，Git 會把你的代碼推送到這個網址。 |
| ```git remote add <遠端倉庫別名> <遠端倉庫的 SSH 網址>``` | 這個指令 ```git remote add origin git@~.git``` 的主要作用是**將本地的 Git 專案連結到遠端的程式碼託管平台(如 GitHub、GitLab 或 Bitbucket)**。 | **欄位**<br>```git remote add```：告訴 Git 你要新增一個遠端伺服器(Remote)的連線紀錄。<br>```origin```：這是遠端倉庫的**別名(Shorthand)**。Git 預設習慣命名為 origin，這樣以後推送程式碼時，就不需要每次都打一長串的網址，直接用 origin 代替即可。<br>```git@~.git```：這是遠端倉庫的 **SSH 連線網址**(實際操作時請替換成您在 GitHub 等平台上複製的真實網址，例如 git@github.com:username/repo.git)。 |
| ```git remote set-url <遠端倉庫別名> <遠端倉庫的 SSH 網址>``` | 這個指令用於**修改現有 Git 遠端倉庫的連線網址(URL)**。當你的專案儲存庫更換了伺服器、變更了帳號、或者想從 HTTPS 轉換為 SSH 連線時，就會使用到它。 |  |
| ```git remote remove <遠端倉庫別名>``` | 要移除 Git 的遠端倉庫連結(通常名為 ```origin```)，請使用指令：```git remote remove origin```。 |  |
| ```git push -u (origin) (main)``` | 指令 ```git push -u origin main``` 的主要作用是**將本地的 ```main``` 分支推送到名為 origin 的遠端數據庫，並同時建立兩者之間的追蹤(Upstream)關係**。 | **拆解指令含義**<br>```git push```：將本地的提交(Commits)上傳並合併到遠端數據庫。<br>**```-u``` (或 --set-upstream)**：最關鍵的參數。它負責建立本地分支與遠端分支的「追蹤連結」。設定成功後，未來你在這個分支下只需要輸入 ```git push``` 或 ```git pull```，Git 就會自動知道要與遠端的哪個分支進行同步，不需要再重複輸入遠端與分支名稱。<br>```origin```：遠端數據庫的預設代稱(例如存在 GitHub、GitLab 或 Bitbucket 上的專案位置)。<br>```main```：你要推送的本地分支名稱。 |

##### 4. 基本版更 ( pull / push / add / commit / status )
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| ```git status``` |  是 ```Git``` 中最核心的指令之一。它主要用來查看目前 ```Git``` 倉庫的狀態，幫助你了解目前目錄中哪些檔案被修改了、哪些檔案已經加入暫存區```(Staged)```、以及哪些檔案尚未被 ```Git``` 追蹤。 |  |
| ```git add [files]``` | ```git add``` 指令的作用是將工作目錄中被修改或新建立的檔案，提交到「暫存區```(Staging Area)```/ 索引區```(Index)```」。這是 ```Git``` 版控流程中不可或缺的步驟，代表您已經確認過這些程式碼或檔案的變更，並「準備好」要在下一次執行 ```git commit``` 時，將它們正式打包成一個歷史版本快照。 | (1) **新增單一檔案**<br>```git add index.html```<br>(2) **新增多個檔案**：在 ```git add``` 後方以空白分隔多個檔案名稱，即可一次加入。<br>```git add file1.txt file2.css file3.js```<br>(3) **新增整個資料夾**：指定目錄名稱，將該目錄下所有的檔案與子目錄變更全部加入。<br>```git add .``` |
| ```git add .```  | **新增「所有」變更**：```.``` 代表目前路徑。此指令會將當前目錄及所有子目錄下，所有新增、修改、刪除的檔案一次全部抓進暫存區。 |  |
| ```git commit -m [message]``` | ```Git``` 版本控制系統中用來將暫存區(Staging Area)的檔案更動正式提交到本地儲存庫(Repository)，並同時附加一段簡短說明的指令。 |  |
| ```git pull [origin] [main / branch]``` | ```git pull``` 指令用於從遠端儲儲庫下載最新的程式碼，並立即與你本地的當前分支進行合併。<br>核心為：```git pull = git fetch (下載變更) + git merge (合併分支)```。 | (1) **拉取預設遠端分支**：直接將目前分支所追蹤的遠端分支內容拉取並合併進來。<br>```git pull```<br>(2) **指定遠端主機與分支**：明確指定要從哪一個遠端主機(如 origin)的哪一個分支(如 main)拉取資料。<br>```git pull origin main```<br>(3) **使用 Rebase 機制合併**：預設的 ```git pull``` 會使用 ```merge``` 產生一個合併的 Commit 節點。使用 ```--rebase``` 參數可以讓本地未上傳的 ```Commit``` 「重基」在遠端最新的 Commit 之上，維持一條乾淨、線性的歷史紀錄。<br>```git pull --rebase origin main``` |
| ```git pull --rebase [remote] [main / branch]``` | **使用 Rebase 機制合併**：預設的 ```git pull``` 會使用 ```merge``` 產生一個合併的 Commit 節點。使用 ```--rebase``` 參數可以讓本地未上傳的 ```Commit``` 「重基」在遠端最新的 Commit 之上，維持一條乾淨、線性的歷史紀錄。<br>```git pull --rebase origin main``` |  |
| ```git push [remote] [main / branch]``` | 用來將本地端的 Git 提交(Commits)推送到遠端伺服器(如 GitHub、GitLab)的指令。<br>**基本結構如下：**<br>```git push <遠端數據庫名稱> <本地分支名稱>``` | (1) **首次推送新分支**<br>當你在本地建立了新分支，遠端還沒有這個分支時，需要建立追蹤關係：<br>```git push -u origin main```<br>(2) **後續常規推送**<br>已經設定過追蹤關係後，直接輸入：<br>```git push```<br>(3) **推送所有分支**<br>如果你想一次將本地所有分支都推送到遠端：<br>```git push --all origin```<br>(4) **強制推送（危險操作）**<br>當你修改了歷史 Commit（例如使用 ```git rebase``` 或 ```git commit --amend```）導致本地與遠端衝突，但你確定要以本地為主時：<br>```git push -f origin main``` |
| ```git push -u [remote] [main / branch]``` | **首次推送新分支**<br>當你在本地建立了新分支，遠端還沒有這個分支時，需要建立追蹤關係：<br>```git push -u origin main``` |  |
| ```git restore --staged [file]``` | 這個指令的核心作用是將檔案移出暫存區(Staging Area)，也就是取消剛才的 ```git add``` 操作，但會完整保留你在檔案中寫好的修改內容。 | (1) **取消暫存單一檔案**<br>```git restore --staged <檔案名稱>```<br>(2) **取消暫存所有檔案**<br>```git restore --staged .``` |
| `````` |  |  |

#### + reference +
<ol>
<li><a href="https://git-scm.com/book/zh-tw/v2/%e9%96%8b%e5%a7%8b-%e9%97%9c%e6%96%bc%e7%89%88%e6%9c%ac%e6%8e%a7%e5%88%b6" target="_blank">Git &rarr; Learn &rarr; Book (指令手冊)</a></li>
<li><a href="https://ithelp.ithome.com.tw/m/articles/10241407" target="_blank">Git 常用指令表</a></li>
<li><a href="" target="_blank"></a></li>
</ol>