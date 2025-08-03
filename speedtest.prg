
Function myRunProc
Lparameters lnTotalRecords,lnPerFile,lnFieldCount , lnIndexCount, lcPath
*lnTotalRecords = 100000         && 資料總筆數
*lnPerFile = 2000               && 每個 DBF 的筆數
*lnFieldCount = 50              && 欄位數量
*lnIndexCount = 3               && 要建立索引的欄位數（從 col1 開始）
*lcPath = "c:\test\" && 存檔路徑

* === 參數設定 ===
Local lnStart, lnEnd
Local lnFileCount, lnFileNo, i, j, lcDbfName, lcFieldDef, lcInsert
Local lnStartIndex, lnEndIndex, lcIndexCmd



lnFileCount = Ceiling(lnTotalRecords / lnPerFile)

* 建立資料夾
If !Directory(lcPath)
   Md (lcPath)
Endif

* 開始計時
lnStart = Seconds()

* === 建立多個 DBF 檔案 ===
For lnFileNo = 1 To lnFileCount
   lcDbfName = lcPath + "TestData_" + Transform(lnFileNo) + ".dbf"

   * 刪除舊檔
   If File(lcDbfName)
      Delete File (lcDbfName)
   Endif

   * 組合欄位定義
   lcFieldDef = ""
   For j = 1 To lnFieldCount
      lcFieldDef = lcFieldDef + "col" + Transform(j) + " C(20),"
   Endfor
   lcFieldDef = Left(lcFieldDef, Len(lcFieldDef) - 1)
   *_cliptext =  lcFieldDef
   *MESSAGEBOX(lcFieldDef)
   * 建立資料表
   Create Table (lcDbfName) (  &lcFieldDef. )
   Use (lcDbfName) Exclusive

   * 寫入資料
   lnStartIndex = (lnFileNo - 1) * lnPerFile + 1
   lnEndIndex = Min(lnFileNo * lnPerFile, lnTotalRecords)

   For i = lnStartIndex To lnEndIndex
      lcInsert = "INSERT INTO " + lcDbfName + " VALUES ("
      For j = 1 To lnFieldCount
         lcInsert = lcInsert + "'F" + Transform(j) + "_" + Transform(i) + "',"
      Endfor
      lcInsert = Left(lcInsert, Len(lcInsert) - 1) + ")"
      &lcInsert
   Endfor

   * 建立多個索引（前 lnIndexCount 個欄位）
   For j = 1 To Min(lnIndexCount, lnFieldCount)
      lcIndexCmd = "INDEX ON col" + Transform(j) + " TAG col" + Transform(j)
      &lcIndexCmd
   Endfor

   USE
   
   * 刪除舊檔
   *If File(lcDbfName)
   *   Delete File (FORCEEXT(lcDbfName,".*"))
   *Endif

   Wait "完成檔案:"+  lcDbfName Window Nowait
Endfor

* 結束計時
lnEnd = Seconds()
Messagebox( "總處理時間：" + Transform(lnEnd - lnStart) + " 秒")







