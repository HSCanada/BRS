Operation =1
Option =0
Where ="(((Integration_F5554240_fg_redeem_finalize_Staging.fg_offer_note)<>\".\") AND (("
    "fg_transaction_F5554240.fg_offer_note)=\"\"))"
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_finalize_Staging"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="Integration_F5554240_fg_redeem_finalize_Staging.fg_offer_note"
    Expression ="fg_transaction_F5554240.fg_offer_note"
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
        dbText "Name" ="Integration_F5554240_fg_redeem_finalize_Staging.fg_offer_note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="6585"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_offer_note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5205"
        dbBoolean "ColumnHidden" ="0"
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
    Bottom =588
    Left =0
    Top =0
    ColumnsShown =539
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
        Right =827
        Bottom =584
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
