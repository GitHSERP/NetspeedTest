# NetspeedTest
VFP 網路磁碟機寫入檔案測試程式

# 🧪 FoxPro 網路磁碟機寫入測試工具

這是一個使用 Visual FoxPro 撰寫的工具，用來測試 **網路磁碟機（如 Z:\）在大量資料寫入時的效能與穩定性**，同時支援：

- ✅ 可參數設置寫入DBF檔案 索引 數量
- ✅ 多檔案分批寫入 `.DBF`
- ✅ 多欄位動態產生並建立索引




## 🚀 執行方法

### 1️⃣ 開啟 Visual FoxPro

### 2️⃣ 執行主程式（建議打包為 `.PRG` 或 `.APP`）

```foxpro
DO WriteDbfWithUI WITH ;
   "Z:\FoxProTestWrapped\", ;  && 寫入路徑
   10000, ;                  && 資料總筆數
   2000, ;                   && 每檔筆數
   50, ;                     && 欄位數
   3                        && 索引欄位數




🧑‍💻 需求環境
Visual FoxPro 9.0 或相容版本

Windows 7/10/11

已掛載的網路磁碟機（如 Z:\）

📝 授權
本程式以 MIT 授權發佈，歡迎自由使用與修改。
