Operation =4
Option =0
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_finalize_Staging"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Name ="fg_transaction_F5554240.ExtFileCostCadAmt"
    Expression ="[Integration_F5554240_fg_redeem_finalize_Staging]![WKECST_extended_cost]"
End
Begin Joins
    LeftTable ="Integration_F5554240_fg_redeem_finalize_Staging"
    RightTable ="fg_transaction_F5554240"
    Expression ="Integration_F5554240_fg_redeem_finalize_Staging.ID = fg_transaction_F5554240.ID"
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
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.fg_redeem_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.fg_offer_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.OriginalSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.WKCRCD_currency_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_redeem_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ExtFileCostCadAmt"
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
    Right =1473
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =78
        Top =108
        Right =454
        Bottom =428
        Top =0
        Name ="Integration_F5554240_fg_redeem_finalize_Staging"
        Name =""
    End
    Begin
        Left =537
        Top =68
        Right =851
        Bottom =584
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
