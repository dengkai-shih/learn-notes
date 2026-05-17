# 1. String Comparison
PowerShell 使用 if 語句搭配比較運算子進行字串比對。常用不區分大小寫的 -eq (等於)、-like (萬用字元比對)、-match (正規表示式) 或區分大小寫的 -ceq、-clike。左側為變數，右側為比對字串，如 if ($a -eq "test")。
## 1-1. 常用字串比對運算子 (不區分大小寫)
### (1) 完全相等 (-eq)：
```powershell
$str = "Hello World"
if ($str -eq "hello world") {                # 真
    Write-Host "相等"
}
```
### (2) 萬用字元比對 (-like)：使用 * 匹配任意字元，? 匹配單個字元。
```powershell
if ($str -like "Hello*") {                # 真，檢查是否以 Hello 開頭
    Write-Host "匹配成功"
}
```
### (3) 正規表示式匹配 (-match)：功能最強大，用於進階搜尋。
```powershell
if ($str -match "World$") {               # 真，檢查是否以 World 結尾
    Write-Host "匹配成功"
}
```
## 1-2. 區分大小寫的字串比對
### 在運算子前面加上 c (Case-sensitive) 可強制區分大小寫：
### (1) ```-ceq``` (等於)
### (2) ```-clike``` (萬用字元)
### (3) ```-cmatch``` (正規表示式)
```powershell
if ($str -ceq "Hello World") { ... }          # 必須大小寫完全一致
```
## 1-3. 常見錯誤與提示
### (1) ```-contains``` 是用來搜尋陣列中的元素，不是字串內容比較。
### (2) 字串比較預設使用 ```InvariantCulture```。
### (3) 當字串包含萬用字元（如 ```[``` 或 ```*```）而需要字面比對時，可以使用 ```-like``` 並跳脫字元。