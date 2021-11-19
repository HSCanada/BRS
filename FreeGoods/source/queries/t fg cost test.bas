Operation =1
Option =0
Where ="(((fg_transaction_F5554240.fg_exempt_cd)=\"\") AND ((fg_transaction_F5554240.WKC"
    "RCD_currency_code)=[Currency]) AND ((Abs([WKUNCS_unit_cost]-[SupplierCost]))>=0."
    "01))"
Begin InputTables
    Name ="zzzCosts"
    Name ="fg_transaction_F5554240"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    Expression ="fg_transaction_F5554240.WKLNNO_line_number"
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    Expression ="zzzCosts.Supplier"
    Expression ="fg_transaction_F5554240.WKUNCS_unit_cost"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.WKCRCD_currency_code"
    Expression ="zzzCosts.Currency"
    Expression ="zzzCosts.SupplierCost"
    Alias ="Expr1"
    Expression ="Abs([WKUNCS_unit_cost]-[SupplierCost])"
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="zzzCosts"
    Expression ="fg_transaction_F5554240.WKLITM_item_number = zzzCosts.Item"
    Flag =1
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_Item"
    Expression ="fg_transaction_F5554240.WKLITM_item_number = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[t fg cost test].[Est12MoSales] DESC"
Begin
    Begin
        dbText "Name" ="zzzCosts.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKUNCS_unit_cost"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCosts.Supplier"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCosts.SupplierCost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3210"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1573
    Bottom =918
    Left =-1
    Top =-1
    Right =1287
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =629
        Top =249
        Right =773
        Bottom =393
        Top =0
        Name ="zzzCosts"
        Name =""
    End
    Begin
        Left =214
        Top =177
        Right =594
        Bottom =599
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =756
        Top =100
        Right =1086
        Bottom =412
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
