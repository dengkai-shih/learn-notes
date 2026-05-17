# 1. 在 PowerShell 中抓取檔案日期
## 1-1. 抓取單一檔案日期
### (1) 取得特定檔案的「最後修改時間」
```powershell
(Get-Item "C:\path\to\file.txt").LastWriteTime
```
### (2) 取得特定檔案的「建立時間」
```powershell
(Get-Item "C:\path\to\file.txt").CreationTime
```
## 1-2. 抓取資料夾內檔案日期
### 列出資料夾中所有檔案的名稱與最後修改時間：
```powershell
Get-ChildItem "C:\path\to\folder" | Select-Object PSPath, Name, LastWriteTime
```
## 1-3. 格式化日期輸出
### 若需要特定格式（例如 YYYY-MM-DD），可結合 Get-Date：
```powershell
(Get-Item "C:\file.txt").LastWriteTime | Get-Date -Format "yyyy-MM-dd"
```
## 1-4. 屬性說明
```powershell
CreationTime # 檔案建立時間。
LastWriteTime # 檔案最後修改時間。
LastAccessTime # 檔案最後存取時間。
```
## 2-1. 顯示所有屬性（列表格式）
### 這是查看單個檔案或資料夾所有詳細屬性最常用的方法：
```powershell
Get-ChildItem | Select-Object -Property *
# 或者以列表形式呈現
Get-ChildItem | Format-List -Property *
```
## 2-2. 檢視物件有哪些屬性可用
### 如果您想知道 Get-ChildItem 傳回的物件到底包含哪些屬性名稱，可以使用 Get-Member：
```powershell
Get-ChildItem | Get-Member
```
## 2-3. 取得「隱藏」或「系統」檔案的屬性
### 預設的 Get-ChildItem 不會顯示隱藏檔案。若要包含隱藏檔案及完整屬性，請加上 -Force 參數：
```powershell
Get-ChildItem -Force | Select-Object -Property *
```
## 2-4. 篩選特定屬性
### 如果您只需要特定屬性（例如：名稱、建立時間、大小、完整路徑），可以指定屬性名稱：
```powershell
Get-ChildItem | Select-Object -Property Name, CreationTime, Length, FullName
```
## 2-5. 常用屬性說明
```powershell
Name # 檔案名稱
Length # 檔案大小 (Bytes)
CreationTime # 建立時間
LastWriteTime # 上次修改時間
```
# 3. PowerShell : for loop 
在 PowerShell 中，遍歷陣列（Array）主要有三種方式：傳統的 for 迴圈（使用索引）、更簡潔的 foreach 語句，以及管線 ForEach-Object。對於陣列操作，推薦使用 foreach 語句，因為它代碼更簡潔、易讀。
## 3-1. 傳統 for 迴圈 (索引方式)
### 適用於需要使用索引（Index）來操作陣列，例如同時操作多個陣列或跳躍式讀取。
```powershell
$myArray = @('A', 'B', 'C', 'D')
# 使用 $i -lt $myArray.Count，避免差一錯誤 (off-by-one)
for ($i = 0; $i -lt $myArray.Count; $i++) {
    Write-Host "索引 $i 的值是: $($myArray[$i])"
}
```
## 3-2. foreach 語句 (推薦)
### 最常用且效能良好的方式，直接遍歷陣列中的每個元素。
```powershell
$myArray = @('A', 'B', 'C', 'D')
foreach ($item in $myArray) {
    Write-Host "元素值: $item"
}
```
## 3-3. ForEach-Object (管線方式)
### 適用於一行式的快速處理或需要結合管線（Pipe）操作。
```powershell
$myArray = @('A', 'B', 'C', 'D')
$myArray | ForEach-Object {
    Write-Host "目前處理的元素: $_"
}
```
## 3-4. 關鍵注意事項
### (1) 陣列索引： PowerShell 的陣列索引從 0 開始。
### (2) 總數檢查： 使用 $array.Count 或 $array.Length 獲取元素總數。
### (3) 空陣列/單一元素： 若需處理可能為單一元素而非陣列的情況，建議強制轉型為陣列 @($result) 確保 foreach 能正確運作。
## 3-5. 進階範例：使用索引處理特定範圍
```powershell
$data = 1..10 # 產生 1 到 10 的陣列
for ($i = 0; $i -lt $data.Count; $i += 2) {
    Write-Host "跳號處理: $($data[$i])"
}
```
# 4. Check folder / file path 
在 PowerShell 中，檢查資料夾是否存在的最快方法是使用 Test-Path 命令。該命令若路徑存在會傳回 $true，否則傳回 $false。
## 4-1. 基本檢查語法
### 使用 if 判斷式來執行動作：
```powershell
$folderPath = "C:\Your\Folder\Path"
if (Test-Path -Path $folderPath) {
    Write-Host "資料夾已存在。"
} else {
    Write-Host "資料夾不存在。"
}
```
## 4-2. 檢查並自動建立資料夾
### 若不存在則建立，使用 New-Item：
```powershell
$folderPath = "C:\Your\Folder\Path"
if (!(Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
    Write-Host "資料夾已建立。"
}
```
## 4-3. 簡寫方式
```powershell
if (-not (Test-Path $path)) { ... } # 檢查不存在
if (Test-Path $path) { ... }       # 檢查存在
```
# 5. Move file
在 PowerShell 中移動檔案或資料夾，主要使用 Move-Item 這個 Cmdlet。它可以將檔案從一個位置移至另一個位置，同時保留其屬性、內容和子專案。
## 基本移動檔案語法
```powershell
Move-Item -Path "來源檔案路徑" -Destination "目標資料夾路徑"
```
## 5-1. 移動單一檔案
### 將 C:\test\report.txt 移動到 D:\backup\ 資料夾：
```powershell
Move-Item -Path "C:\test\report.txt" -Destination "D:\backup\"
```
## 5-2. 移動所有特定類型的檔案 (使用萬用字元)
### 將 C:\test\ 下所有 .log 檔案移動到 D:\logs\：
```powershell
Move-Item -Path "C:\test\*.log" -Destination "D:\logs\"
```
## 5-3. 移動資料夾及其所有內容
### 將 C:\SourceFolder 移動到 D:\DestinationFolder\：
```powershell
Move-Item -Path "C:\SourceFolder" -Destination "D:\DestinationFolder\"
```
## 5-4. 移動檔案並重新命名
### 將檔案移動並在目的地改名：
```powershell
Move-Item -Path "C:\test\old_name.txt" -Destination "C:\new_folder\new_name.txt"
```
## 5-5. 強制覆蓋目的地同名檔案
### 如果目標位置已有同名檔案，加上 -Force 參數可直接覆蓋：
```powershell
Move-Item -Path "C:\test\file.txt" -Destination "D:\backup\" -Force
```
## 5-6. 重要提示
### (1) 相同路徑不能移動：```Move-Item``` 無法將專案移至具有相同名稱且已存在的位置。
### (2) 跨磁碟機：```Move-Item``` 支援在不同的磁碟機之間移動檔案。
### (3) 別名：可以使用 ```move``` 或 ```mv``` 作為 ```Move-Item``` 的簡寫。