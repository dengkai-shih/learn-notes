# 1. 建立 ASP .NET CORE MVC 專案
使用命令列（CLI）建立 ASP.NET Core MVC 專案，只需透過 .NET CLI 執行以下幾個簡單步驟： [1](https://ithelp.ithome.com.tw/articles/10353582)

## 1-1. 建立與執行步驟
 - 1. 開啟終端機（Terminal、PowerShell 或命令提示字元）
 - 2. 建立 ASP.NET Core MVC 專案：
```bash
dotnet new mvc -o Mvc7_FirstMVC
# 請謹慎使用程式碼。
```
(註：-o 代表輸出資料夾名稱，Mvc7_FirstMVC 可替換為你自定的專案名稱) [1](https://ithelp.ithome.com.tw/articles/10233621), [2](https://ithelp.ithome.com.tw/articles/10353582)
 - 3. 進入專案資料夾： [1](https://ithelp.ithome.com.tw/articles/10353582)
```bash
cd Mvc7_FirstMVC
# 請謹慎使用程式碼。
```
 - 4. 執行專案： [1] (https://ithelp.ithome.com.tw/articles/10353582)
```bash
dotnet run
# 請謹慎使用程式碼。
```
 - 5. 開啟瀏覽器測試
	• 專案啟動後，終端機會顯示運行的網址（例如 https://localhost:xxxx 或 http://localhost:xxxx）。
	• 將網址貼入瀏覽器中，即可看到預設的 ASP.NET Core MVC 首頁。
	• 按下 Ctrl + C 即可停止伺服器運行。 [1](https://ithelp.ithome.com.tw/articles/10206429), [2](https://ithelp.ithome.com.tw/articles/10233621), [3](https://ithelp.ithome.com.tw/articles/10353582)

## 1-2. 常見輔助指令
 - • 查看所有可用的專案範本：
```bash
dotnet new list
# 請謹慎使用程式碼。
```
 - • 加入 Entity Framework Core 套件（若需要連接資料庫）：
```bash
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
# 請謹慎使用程式碼。
```
---

# 2. VSCode 使用 dotnet 建立 controller
在 VS Code 中，使用 `dotnet` 指令建立 Controller 的核心邏輯與命令列相同，但因為 VS Code 是輕量化編輯器，首次執行「程式碼產生器」時需要確保**套件版本與你的 .NET SDK 版本完全相容。**

以下是針對** VS Code 環境**調整的最佳化操作指南：

## 2-1. 開啟 VS Code 終端機並安裝必備套件
請在 VS Code 內使用快速鍵 ```Ctrl + ` ```（Mac 為 ```Cmd + ` ```）開啟內建終端機，確認位於專案根目錄後，依序貼上並執行：
```bash
# 1. 安裝或更新全域程式碼產生工具
dotnet tool update --global dotnet-aspnet-codegenerator

# 2. 安裝核心設計套件（自動符合你目前的 .NET 版本）
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design

```

## 2-2. 在 VS Code 中快速產生 Controller
在 VS Code 終端機中，直接複製以下你所需要的 Controller 範本：

### 📝 範本一：建立一般 MVC Controller（包含基礎 Action 動作）
```bash
dotnet aspnet-codegenerator controller -name ProductsController -actions -outDir Controllers
```
 - 效果：會在 `Controllers/` 資料夾下生成 `ProductsController.cs`，裡面已包含 `Index()`、`Details()`、`Create()` 等方法。

### 🌐 範本二：建立 Web API Controller（純資料交換，不帶網頁視圖）
```bash
dotnet aspnet-codegenerator controller -name ApiUserController -api -actions -outDir Controllers
```
 - 效果：生成帶有 `[ApiController]` 與 `[Route("api/[controller]")]` 屬性的 `API` 控制器。

## 🛠️ VS Code 獨家技巧：將指令自動化（免打字）
如果你不想每次都背這麼長的指令，可以在 VS Code 中設定一個 **Task（工作）**，以後按快捷鍵就能直接建立。

 - 1. 在專案中點擊 `左下角設定齒輪` -> `命令轉盤` (或按 `Ctrl+Shift+P` / `Cmd+Shift+P`)。
 - 2. 輸入並選擇 **Tasks: Configure Task**（配置工作），再選擇 **Create tasks.json file from template** -> **Others**。
 - 3. 將產生的 `.vscode/tasks.json` 內容替換為以下設定：
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "建立全新 Controller",
            "type": "shell",
            "command": "dotnet aspnet-codegenerator controller -name ${input:controllerName} -actions -outDir Controllers",
            "problemMatcher": []
        }
    ],
    "inputs": [
        {
            "id": "controllerName",
            "type": "promptString",
            "description": "請輸入 Controller 名稱 (例如: MemberController)",
            "default": "SampleController"
        }
    ]
}

```
 - 使用方式：此後在 VS Code 按下 `Ctrl+Shift+P`，輸入 **Run Task**，選擇 **建立全新 Controller**，視窗上方就會彈出輸入框讓你直接打名字，一秒就建好！
