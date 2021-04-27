Operation =1
Option =0
Where ="(((flex_customer_xref.status_code)<>0))"
Begin InputTables
    Name ="zzzShipto"
    Name ="flex_customer_xref"
End
Begin OutputColumns
    Expression ="flex_customer_xref.Supplier"
    Expression ="flex_customer_xref.ACCOUNT"
    Expression ="flex_customer_xref.ShipTo_Suggest"
    Expression ="flex_customer_xref.ShipTo"
    Expression ="flex_customer_xref.status_code"
    Expression ="flex_customer_xref.COMPANY"
    Expression ="flex_customer_xref.FIRSTLAST"
    Expression ="flex_customer_xref.ADDRESS1"
    Expression ="flex_customer_xref.ADDRESS2"
    Expression ="flex_customer_xref.ADDRESS3"
    Expression ="flex_customer_xref.ST"
    Expression ="flex_customer_xref.CITY"
    Expression ="flex_customer_xref.POSTALCODE"
    Expression ="flex_customer_xref.PHONE"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="flex_customer_xref"
    Expression ="zzzShipto.ST = flex_customer_xref.ACCOUNT"
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
Begin
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo_Suggest"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.Supplier"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.COMPANY"
        dbInteger "ColumnWidth" ="5685"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.PHONE"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1474
    Bottom =918
    Left =-1
    Top =-1
    Right =1458
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =90
        Top =53
        Right =234
        Bottom =197
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =361
        Top =71
        Right =677
        Bottom =445
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
End
