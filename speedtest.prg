
Function myRunProc
Lparameters lnTotalRecords,lnPerFile,lnFieldCount , lnIndexCount, lcPath
*lnTotalRecords = 1000000         && ����`����
*lnPerFile = 2000               && �C�� DBF ������
*lnFieldCount = 50              && ���ƶq
*lnIndexCount = 3               && �n�إ߯��ު����ơ]�q col1 �}�l�^
*lcPath = "c:\test\" && �s�ɸ��|

* === �ѼƳ]�w ===
Local lnStart, lnEnd
Local lnFileCount, lnFileNo, i, j, lcDbfName, lcFieldDef, lcInsert
Local lnStartIndex, lnEndIndex, lcIndexCmd



lnFileCount = Ceiling(lnTotalRecords / lnPerFile)

* �إ߸�Ƨ�
If !Directory(lcPath)
   Md (lcPath)
Endif

* �}�l�p��
lnStart = Seconds()

* === �إߦh�� DBF �ɮ� ===
For lnFileNo = 1 To lnFileCount
   lcDbfName = lcPath + "TestData_" + Transform(lnFileNo) + ".dbf"

   * �R������
   If File(lcDbfName)
      Delete File (lcDbfName)
   Endif

   * �զX���w�q
   lcFieldDef = ""
   For j = 1 To lnFieldCount
      lcFieldDef = lcFieldDef + "col" + Transform(j) + " C(20),"
   Endfor
   lcFieldDef = Left(lcFieldDef, Len(lcFieldDef) - 1)
   *_cliptext =  lcFieldDef
   *MESSAGEBOX(lcFieldDef)
   * �إ߸�ƪ�
   Create Table (lcDbfName) (  &lcFieldDef. )
   Use (lcDbfName) Exclusive

   * �g�J���
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

   * �إߦh�ӯ��ޡ]�e lnIndexCount �����^
   For j = 1 To Min(lnIndexCount, lnFieldCount)
      lcIndexCmd = "INDEX ON col" + Transform(j) + " TAG col" + Transform(j)
      &lcIndexCmd
   Endfor

   USE
   
   * �R������
   *If File(lcDbfName)
   *   Delete File (FORCEEXT(lcDbfName,".*"))
   *Endif

   Wait "�����ɮ�:"+  lcDbfName Window Nowait
Endfor

* �����p��
lnEnd = Seconds()
Messagebox( "�`�B�z�ɶ��G" + Transform(lnEnd - lnStart) + " ��")






