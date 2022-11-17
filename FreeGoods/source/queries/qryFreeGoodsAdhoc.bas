Operation =1
Option =0
Where ="(((fg_transaction_F5554240.WKDOCO_salesorder_number)=15446534))"
Begin InputTables
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.WKDCTO_order_type"
    Expression ="fg_transaction_F5554240.WKLNNO_line_number"
    Expression ="fg_transaction_F5554240.WKSHAN_shipto"
    Expression ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
    Expression ="fg_transaction_F5554240.MajorProductClass"
    Expression ="fg_transaction_F5554240.WKLITM_item_number"
    Expression ="fg_transaction_F5554240.WKDSC1_description"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.fg_offer_id"
    Expression ="fg_transaction_F5554240.fg_redeem_ind"
    Expression ="fg_transaction_F5554240.fg_offer_note"
    Expression ="fg_transaction_F5554240.WKECST_extended_cost"
    Expression ="fg_transaction_F5554240.Label"
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
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbInteger "ColumnWidth" ="1005"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_note"
        dbInteger "ColumnWidth" ="1710"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.[WK$SPC_supplier_code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDSC1_description"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.Label"
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
    Right =1450
    Bottom =918
    Left =-1
    Top =-1
    Right =1164
    Bottom =217
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =69
        Top =67
        Right =579
        Bottom =421
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
