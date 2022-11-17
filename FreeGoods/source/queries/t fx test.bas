Operation =1
Option =0
Where ="(((fg_transaction_F5554240.[WK$SPC_supplier_code]) Like \"HUF*\") AND ((fg_trans"
    "action_F5554240.WKCRCD_currency_code)=\"USD\"))"
Begin InputTables
    Name ="fg_transaction_F5554240"
    Name ="BRS_TransactionDW"
    Name ="BRS_Item"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    Expression ="fg_transaction_F5554240.WKLNNO_line_number"
    Expression ="fg_transaction_F5554240.WKLITM_item_number"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="fg_transaction_F5554240.WKUORG_quantity"
    Expression ="fg_transaction_F5554240.WKECST_extended_cost"
    Expression ="fg_transaction_F5554240.WKUNCS_unit_cost"
    Expression ="fg_transaction_F5554240.WKCRCD_currency_code"
    Expression ="BRS_TransactionDW.OrderSourceCode"
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Expression ="BRS_TransactionDW.LineNumber"
    Expression ="BRS_TransactionDW.Shipto"
    Expression ="BRS_TransactionDW.NetSalesAmt"
    Expression ="BRS_TransactionDW.GPAmt"
    Expression ="BRS_TransactionDW.GPAtFileCostAmt"
    Expression ="BRS_TransactionDW.GPAtCommCostAmt"
    Expression ="BRS_TransactionDW.ExtChargebackAmt"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.StockingType"
    Expression ="BRS_Item.FreightAdjPct"
    Expression ="BRS_Item.CorporateMarketAdjustmentPct"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.VPA"
End
Begin Joins
    LeftTable ="fg_transaction_F5554240"
    RightTable ="BRS_TransactionDW"
    Expression ="fg_transaction_F5554240.ID_source_ref = BRS_TransactionDW.ID"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Item"
    Expression ="BRS_TransactionDW.Item = BRS_Item.Item"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Customer"
    Expression ="BRS_TransactionDW.Shipto = BRS_Customer.ShipTo"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[t fx test].[VPA], [t fx test].[PracticeName]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKUNCS_unit_cost"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKUORG_quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.LineNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.GPAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.GPAtFileCostAmt"
        dbInteger "ColumnWidth" ="2025"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.GPAtCommCostAmt"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ExtChargebackAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.OrderSourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbInteger "ColumnWidth" ="3915"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.StockingType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FreightAdjPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.CorporateMarketAdjustmentPct"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1541
    Bottom =918
    Left =-1
    Top =-1
    Right =1255
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =71
        Top =73
        Right =513
        Bottom =430
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =585
        Top =101
        Right =950
        Bottom =574
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =1019
        Top =98
        Right =1242
        Bottom =415
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =1019
        Top =3
        Right =1163
        Bottom =147
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
