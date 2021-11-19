Operation =1
Option =0
Where ="(((fg_transaction_F5554240.[WK$SPC_supplier_code]) Like \"den*\") AND ((fg_trans"
    "action_F5554240.CalMonthRedeem)=202109) AND ((fg_transaction_F5554240.WKDOCO_sal"
    "esorder_number)=14491510))"
Begin InputTables
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    Expression ="fg_transaction_F5554240.WKFRGD_from_grade"
    Expression ="fg_transaction_F5554240.WKTHGD_thru_grade"
    Expression ="fg_transaction_F5554240.WKPMID_promo_code"
    Alias ="FirstOfWKDL01_promo_description"
    Expression ="First(fg_transaction_F5554240.WKDL01_promo_description)"
End
Begin Groups
    Expression ="fg_transaction_F5554240.WKDOCO_salesorder_number"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKFRGD_from_grade"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKTHGD_thru_grade"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.WKPMID_promo_code"
    GroupLevel =0
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
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKTHGD_thru_grade"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKPMID_promo_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKFRGD_from_grade"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FirstOfWKDL01_promo_description"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1649
    Bottom =918
    Left =-1
    Top =-1
    Right =1363
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =90
        Top =81
        Right =814
        Bottom =656
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
