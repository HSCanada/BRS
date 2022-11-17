Operation =1
Option =0
Begin InputTables
    Name ="fg_redeem_working_notes"
    Name ="qsubWorkingCount"
    Name ="fg_redeem_working"
    Name ="BRS_TransactionDW_Ext"
End
Begin OutputColumns
    Alias ="Order"
    Expression ="fg_redeem_working_notes.SalesOrderNumber"
    Expression ="fg_redeem_working_notes.DocType"
    Expression ="fg_redeem_working_notes.OrderDate"
    Expression ="BRS_TransactionDW_Ext.fg_exempt_cd"
    Expression ="BRS_TransactionDW_Ext.fg_exempt_note"
    Expression ="fg_redeem_working_notes.order_header"
    Expression ="fg_redeem_working_notes.CalMonthRedeem"
    Expression ="fg_redeem_working.Shipto"
    Expression ="qsubWorkingCount.buy_cnt"
    Expression ="qsubWorkingCount.get_cnt"
    Expression ="qsubWorkingCount.redeem_cnt"
    Expression ="fg_redeem_working.CreditMinorReasonCode"
    Expression ="fg_redeem_working.CreditTypeCode"
End
Begin Joins
    LeftTable ="fg_redeem_working_notes"
    RightTable ="qsubWorkingCount"
    Expression ="fg_redeem_working_notes.SalesOrderNumber = qsubWorkingCount.SalesOrderNumber"
    Flag =2
    LeftTable ="fg_redeem_working_notes"
    RightTable ="qsubWorkingCount"
    Expression ="fg_redeem_working_notes.DocType = qsubWorkingCount.DocType"
    Flag =2
    LeftTable ="qsubWorkingCount"
    RightTable ="fg_redeem_working"
    Expression ="qsubWorkingCount.MinOfID_source_ref = fg_redeem_working.ID_source_ref"
    Flag =2
    LeftTable ="qsubWorkingCount"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="qsubWorkingCount.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber"
    Flag =2
    LeftTable ="qsubWorkingCount"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="qsubWorkingCount.DocType = BRS_TransactionDW_Ext.DocType"
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
dbMemo "OrderBy" ="[FFB51_working_notes_export].[fg_exempt_cd] DESC, [FFB51_working_notes_export].["
    "OrderDate] DESC, [FFB51_working_notes_export].[Order]"
Begin
    Begin
        dbText "Name" ="fg_redeem_working_notes.OrderDate"
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
        dbInteger "ColumnWidth" ="12390"
        dbBoolean "ColumnHidden" ="0"
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
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.fg_exempt_note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5115"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditMinorReasonCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.CreditTypeCode"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_redeem_working.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Order"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1526
    Bottom =918
    Left =-1
    Top =-1
    Right =1510
    Bottom =132
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =81
        Top =55
        Right =393
        Bottom =237
        Top =0
        Name ="fg_redeem_working_notes"
        Name =""
    End
    Begin
        Left =562
        Top =48
        Right =793
        Bottom =289
        Top =0
        Name ="qsubWorkingCount"
        Name =""
    End
    Begin
        Left =1000
        Top =89
        Right =1238
        Bottom =374
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
    Begin
        Left =884
        Top =1
        Right =1045
        Bottom =223
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
End
