Attribute VB_Name = "FixCostAndPriceDecimal"
Sub FixDecimalPlace()
Attribute FixDecimalPlace.VB_ProcData.VB_Invoke_Func = " \n14"
'
' FixDecimalPlace Macro
'

'
    Columns("AP:AP").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Range("AP2").Select
    ActiveCell.FormulaR1C1 = "=FIXED(RC[-41])"
    Range("AP2").Select
    ActiveCell.FormulaR1C1 = "=FIXED(RC[-41],2)"
    Range("AP2").Select
    ActiveCell.FormulaR1C1 = "=FIXED(RC[-1],2)"
    Selection.AutoFill Destination:=Range("AP2:AP120000")
    Range("AP2:AP120000").Select
    Selection.Copy
    Range("AO2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("AP2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=FIXED(RC[2],2)"
    Selection.AutoFill Destination:=Range("AP2:AP120000")
    Range("AP2:AP120000").Select
    ActiveWindow.SmallScroll Down:=78
    ActiveWindow.ScrollRow = 1
    ActiveWindow.ScrollRow = 233
    ActiveWindow.ScrollRow = 465
    ActiveWindow.ScrollRow = 1625
    ActiveWindow.ScrollRow = 3018
    ActiveWindow.ScrollRow = 6731
    ActiveWindow.ScrollRow = 9283
    ActiveWindow.ScrollRow = 11604
    ActiveWindow.ScrollRow = 15316
    ActiveWindow.ScrollRow = 18333
    ActiveWindow.ScrollRow = 22742
    ActiveWindow.ScrollRow = 24831
    ActiveWindow.ScrollRow = 27847
    ActiveWindow.ScrollRow = 29472
    ActiveWindow.ScrollRow = 31560
    ActiveWindow.ScrollRow = 33184
    ActiveWindow.ScrollRow = 34113
    ActiveWindow.ScrollRow = 34577
    ActiveWindow.ScrollRow = 34809
    ActiveWindow.ScrollRow = 35041
    ActiveWindow.ScrollRow = 35273
    ActiveWindow.ScrollRow = 35505
    ActiveWindow.ScrollRow = 35737
    ActiveWindow.ScrollRow = 35969
    ActiveWindow.ScrollRow = 36897
    ActiveWindow.ScrollRow = 37825
    ActiveWindow.ScrollRow = 38754
    ActiveWindow.ScrollRow = 39218
    ActiveWindow.ScrollRow = 39682
    ActiveWindow.ScrollRow = 40378
    ActiveWindow.ScrollRow = 41074
    ActiveWindow.ScrollRow = 42002
    ActiveWindow.ScrollRow = 42931
    ActiveWindow.ScrollRow = 43627
    ActiveWindow.ScrollRow = 44323
    ActiveWindow.ScrollRow = 45483
    ActiveWindow.ScrollRow = 46643
    ActiveWindow.ScrollRow = 47572
    ActiveWindow.ScrollRow = 48036
    ActiveWindow.ScrollRow = 48732
    ActiveWindow.ScrollRow = 49428
    ActiveWindow.ScrollRow = 50588
    ActiveWindow.ScrollRow = 51749
    ActiveWindow.ScrollRow = 53373
    ActiveWindow.ScrollRow = 54997
    ActiveWindow.ScrollRow = 56622
    ActiveWindow.ScrollRow = 58478
    ActiveWindow.ScrollRow = 60335
    ActiveWindow.ScrollRow = 62191
    ActiveWindow.ScrollRow = 63815
    ActiveWindow.ScrollRow = 65440
    ActiveWindow.ScrollRow = 66832
    ActiveWindow.ScrollRow = 67296
    ActiveWindow.ScrollRow = 67528
    ActiveWindow.ScrollRow = 67760
    ActiveWindow.ScrollRow = 67992
    ActiveWindow.ScrollRow = 68456
    ActiveWindow.ScrollRow = 68920
    ActiveWindow.ScrollRow = 70777
    ActiveWindow.ScrollRow = 73097
    ActiveWindow.ScrollRow = 75650
    ActiveWindow.ScrollRow = 77970
    ActiveWindow.ScrollRow = 80523
    ActiveWindow.ScrollRow = 82147
    ActiveWindow.ScrollRow = 83308
    ActiveWindow.ScrollRow = 84004
    ActiveWindow.ScrollRow = 84236
    ActiveWindow.ScrollRow = 84700
    ActiveWindow.ScrollRow = 86092
    ActiveWindow.ScrollRow = 87485
    ActiveWindow.ScrollRow = 88645
    ActiveWindow.ScrollRow = 88877
    ActiveWindow.ScrollRow = 89109
    ActiveWindow.ScrollRow = 90269
    ActiveWindow.ScrollRow = 92822
    ActiveWindow.ScrollRow = 94678
    ActiveWindow.ScrollRow = 97463
    ActiveWindow.ScrollRow = 99087
    ActiveWindow.ScrollRow = 100944
    ActiveWindow.ScrollRow = 102104
    ActiveWindow.ScrollRow = 103264
    ActiveWindow.ScrollRow = 104656
    ActiveWindow.ScrollRow = 106049
    ActiveWindow.ScrollRow = 107905
    ActiveWindow.ScrollRow = 109530
    ActiveWindow.ScrollRow = 110922
    ActiveWindow.ScrollRow = 111850
    ActiveWindow.ScrollRow = 113010
    ActiveWindow.ScrollRow = 113706
    ActiveWindow.ScrollRow = 114403
    ActiveWindow.ScrollRow = 114867
    ActiveWindow.ScrollRow = 115563
    ActiveWindow.ScrollRow = 116027
    ActiveWindow.ScrollRow = 114867
    ActiveWindow.ScrollRow = 109065
    ActiveWindow.ScrollRow = 99551
    ActiveWindow.ScrollRow = 88645
    ActiveWindow.ScrollRow = 78667
    ActiveWindow.ScrollRow = 71705
    ActiveWindow.ScrollRow = 61727
    ActiveWindow.ScrollRow = 53605
    ActiveWindow.ScrollRow = 48500
    ActiveWindow.ScrollRow = 41306
    ActiveWindow.ScrollRow = 35041
    ActiveWindow.ScrollRow = 29240
    ActiveWindow.ScrollRow = 26455
    ActiveWindow.ScrollRow = 23206
    ActiveWindow.ScrollRow = 21582
    ActiveWindow.ScrollRow = 20190
    ActiveWindow.ScrollRow = 19029
    ActiveWindow.ScrollRow = 18333
    ActiveWindow.ScrollRow = 16709
    ActiveWindow.ScrollRow = 15548
    ActiveWindow.ScrollRow = 13924
    ActiveWindow.ScrollRow = 12300
    ActiveWindow.ScrollRow = 10907
    ActiveWindow.ScrollRow = 8355
    ActiveWindow.ScrollRow = 6266
    ActiveWindow.ScrollRow = 3250
    ActiveWindow.ScrollRow = 1625
    ActiveWindow.ScrollRow = 1
    ActiveCell.FormulaR1C1 = "=FIXED(RC[6],2)"
    Selection.AutoFill Destination:=Range("AP2:AP120000")
    Range("AP2:AP120000").Select
    Selection.Copy
    Range("AV2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("AP2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=FIXED(RC[8],2)"
    Selection.AutoFill Destination:=Range("AP2:AP120000")
    Range("AP2:AP120000").Select
    Selection.Copy
    Range("AX2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Range("AP2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=FIXED(RC[10],2)"
    Selection.AutoFill Destination:=Range("AP2:AP120000")
    Range("AP2:AP120000").Select
    Selection.Copy
    Range("AZ2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Columns("AP:AP").Select
    Application.CutCopyMode = False
    Selection.Delete Shift:=xlToLeft
    ActiveWorkbook.Save
End Sub
