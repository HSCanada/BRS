Operation =1
Option =0
Where ="(((fg_transaction_F5554240.fg_exempt_cd) Not Like \"xx*\") AND ((fg_transaction_"
    "F5554240.CalMonthRedeem)=202110) AND ((STAGE_fg_transaction_F5554240.Note)<>\"\""
    "))"
Begin InputTables
    Name ="STAGE_fg_transaction_F5554240"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.fg_offer_note"
    Expression ="STAGE_fg_transaction_F5554240.Note"
End
Begin Joins
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKDOCO_salesorder_number = fg_transaction_F5554240"
        ".WKDOCO_salesorder_number"
    Flag =1
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKDCTO_order_type = fg_transaction_F5554240.WKDCTO"
        "_order_type"
    Flag =1
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKPSN__invoice_number = fg_transaction_F5554240.WK"
        "PSN__invoice_number"
    Flag =1
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKSHAN_shipto = fg_transaction_F5554240.WKSHAN_shi"
        "pto"
    Flag =1
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKLITM_item_number = fg_transaction_F5554240.WKLIT"
        "M_item_number"
    Flag =1
    LeftTable ="STAGE_fg_transaction_F5554240"
    RightTable ="fg_transaction_F5554240"
    Expression ="STAGE_fg_transaction_F5554240.WKUORG_quantity = fg_transaction_F5554240.WKUORG_q"
        "uantity"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_fg_transaction_F5554240.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_fg_transaction_F5554240.Comments"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_note"
        dbInteger "ColumnWidth" ="2040"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1559
    Bottom =918
    Left =-1
    Top =-1
    Right =1273
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =58
        Top =84
        Right =321
        Bottom =331
        Top =0
        Name ="STAGE_fg_transaction_F5554240"
        Name =""
    End
    Begin
        Left =457
        Top =86
        Right =864
        Bottom =371
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
