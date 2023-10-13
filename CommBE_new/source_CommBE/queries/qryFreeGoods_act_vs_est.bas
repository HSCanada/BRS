Operation =1
Option =0
Having ="(((comm_freegoods.FiscalMonth)>=202301))"
Begin InputTables
    Name ="comm_freegoods"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SourceCode"
    Alias ="SumOfExtFileCostCadAmt"
    Expression ="Sum(comm_freegoods.ExtFileCostCadAmt)"
    Alias ="CountOfFiscalMonth"
    Expression ="Count(comm_freegoods.FiscalMonth)"
End
Begin Groups
    Expression ="comm_freegoods.FiscalMonth"
    GroupLevel =0
    Expression ="comm_freegoods.SourceCode"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query2].[FiscalMonth]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1000"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfFiscalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1327
    Bottom =850
    Left =-1
    Top =-1
    Right =1033
    Bottom =522
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =104
        Top =72
        Right =507
        Bottom =511
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
End
