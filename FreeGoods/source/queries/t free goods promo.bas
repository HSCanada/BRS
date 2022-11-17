Operation =1
Option =0
Begin InputTables
    Name ="zzzSalesorderItem"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    Expression ="fg_transaction_F5554240.WKDL01_promo_description"
    Alias ="SumOfvalue"
    Expression ="Sum(zzzSalesorderItem.value)"
    Alias ="SumOfWKECST_extended_cost"
    Expression ="Sum(fg_transaction_F5554240.WKECST_extended_cost)"
End
Begin Joins
    LeftTable ="zzzSalesorderItem"
    RightTable ="fg_transaction_F5554240"
    Expression ="zzzSalesorderItem.SalesOrderNumberKEY = fg_transaction_F5554240.WKDOCO_salesorde"
        "r_number"
    Flag =1
    LeftTable ="zzzSalesorderItem"
    RightTable ="fg_transaction_F5554240"
    Expression ="zzzSalesorderItem.Item = fg_transaction_F5554240.WKLITM_item_number"
    Flag =1
End
Begin Groups
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKDL01_promo_description"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[SumOfWKECST_extended_cost] DESC"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzFG.ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzFG.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzFG.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzSalesorderItem.value"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzSalesorderItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDL01_promo_description"
        dbInteger "ColumnWidth" ="3480"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzSalesorderItem.SalesOrderNumberKEY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbInteger "ColumnWidth" ="2100"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfvalue"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_redeem_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1564
    Bottom =918
    Left =-1
    Top =-1
    Right =1278
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =30
        Top =71
        Right =174
        Bottom =215
        Top =0
        Name ="zzzSalesorderItem"
        Name =""
    End
    Begin
        Left =316
        Top =40
        Right =647
        Bottom =485
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
