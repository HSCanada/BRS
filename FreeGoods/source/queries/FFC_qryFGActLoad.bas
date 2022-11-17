Operation =3
Name ="Integration_F5554240_fg_redeem_finalize_Staging"
Option =0
Where ="(((comm_freegoods.FiscalMonth) Between 202108 And 202110) AND ((comm_freegoods.S"
    "ourceCode)=\"ACT\"))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Name ="ID"
    Expression ="fg_transaction_F5554240.ID"
    Name ="CalMonthRedeem"
    Expression ="comm_freegoods.FiscalMonth"
    Name ="WK$SPC_supplier_code"
    Expression ="comm_freegoods.Supplier"
    Name ="WKDOCO_salesorder_number"
    Expression ="comm_freegoods.SalesOrderNumber"
    Name ="WKSHAN_shipto"
    Expression ="comm_freegoods.ShipTo"
    Name ="WKLITM_item_number"
    Expression ="comm_freegoods.Item"
    Alias ="fg_redeem_ind"
    Name ="fg_redeem_ind"
    Expression ="\"Y\""
    Alias ="fg_offer_id"
    Name ="fg_offer_id"
    Expression ="0"
    Alias ="fg_exempt_cd"
    Name ="fg_exempt_cd"
    Expression ="\"FGMANU\""
    Alias ="fg_note"
    Name ="fg_offer_note"
    Expression ="\"COM20211123\""
    Alias ="org_salesorder"
    Name ="OriginalSalesOrderNumber"
    Expression ="0"
    Name ="WKECST_extended_cost"
    Expression ="comm_freegoods.ExtFileCostCadAmt"
    Alias ="currcode"
    Name ="WKCRCD_currency_code"
    Expression ="\"CAD\""
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="fg_transaction_F5554240"
    Expression ="comm_freegoods.ID_source_ref = fg_transaction_F5554240.ID_source_ref"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="comm_freegoods.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exampt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="org_salesorder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="currcode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1363
    Bottom =918
    Left =-1
    Top =-1
    Right =1347
    Bottom =405
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =30
        Top =5
        Right =355
        Bottom =359
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =453
        Top =26
        Right =911
        Bottom =503
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
