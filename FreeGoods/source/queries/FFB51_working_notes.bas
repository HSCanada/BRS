Operation =1
Option =0
Begin InputTables
    Name ="fg_redeem_working_notes"
    Name ="qsubWorkingCount"
End
Begin OutputColumns
    Expression ="fg_redeem_working_notes.SalesOrderNumber"
    Expression ="fg_redeem_working_notes.DocType"
    Expression ="fg_redeem_working_notes.CalMonthRedeem"
    Expression ="fg_redeem_working_notes.OrderDate"
    Expression ="qsubWorkingCount.buy_cnt"
    Expression ="qsubWorkingCount.get_cnt"
    Expression ="qsubWorkingCount.redeem_cnt"
    Expression ="fg_redeem_working_notes.order_header"
End
Begin Joins
    LeftTable ="fg_redeem_working_notes"
    RightTable ="qsubWorkingCount"
    Expression ="fg_redeem_working_notes.SalesOrderNumber = qsubWorkingCount.SalesOrderNumber"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[FFB51_working_notes].[SalesOrderNumber], [FFB51_working_notes].[buy_cnt], [FFB5"
    "1_working_notes].[redeem_cnt] DESC, [FFB51_working_notes].[get_cnt] DESC"
Begin
    Begin
        dbText "Name" ="fg_redeem_working_notes.OrderDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working_notes.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working_notes.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working_notes.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working_notes.order_header"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubWorkingCount.get_cnt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubWorkingCount.buy_cnt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubWorkingCount.redeem_cnt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1489
    Bottom =918
    Left =-1
    Top =-1
    Right =1203
    Bottom =323
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =531
        Top =23
        Right =675
        Bottom =167
        Top =0
        Name ="fg_redeem_working_notes"
        Name =""
    End
    Begin
        Left =896
        Top =59
        Right =1040
        Bottom =203
        Top =0
        Name ="qsubWorkingCount"
        Name =""
    End
End
