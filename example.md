#### + reference +
<ol>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>

#### + table +
| Git 指令 | 指令說明 | 註記 |
| :--- | :--- | :--- |
| `````` |  |  |

#### + mermaid +
##### 流程圖 (Flowchart)
```mermaid
flowchart TB
    Start([開始]) --> Input[/輸入資料/]
    Input --> Validate{資料驗證}
    Validate -->|通過| Process[處理資料]
    Validate -->|失敗| Error[顯示錯誤]
    Process --> Save[(儲存到資料庫)]
    Save --> Success[/成功訊息/]
    Success --> End([結束])
    Error --> End
    
    style Start fill:#c8e6c9
    style End fill:#ffcdd2
    style Error fill:#ffebee
```

##### 時序圖 (Sequence Diagram)
```mermaid
sequenceDiagram
    participant A as 客戶端
    participant B as 伺服器
    participant C as 資料庫
    
    A->>B: 發送請求
    B->>C: 查詢資料
    C-->>B: 回傳結果
    B-->>A: 回應資料
```