Operation =1
Option =0
Begin InputTables
    Name ="flex_customer_xref"
End
Begin OutputColumns
    Expression ="flex_customer_xref.Supplier"
    Expression ="flex_customer_xref.ACCOUNT"
    Expression ="flex_customer_xref.FIRSTLAST"
    Expression ="flex_customer_xref.ADDRESS1"
    Expression ="flex_customer_xref.CITY"
    Expression ="flex_customer_xref.ST"
    Expression ="flex_customer_xref.POSTALCODE"
    Expression ="flex_customer_xref.PHONE"
    Expression ="flex_customer_xref.ShipTo_Suggest"
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
        dbText "Name" ="flex_customer_xref.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo_Suggest"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1616
    Bottom =918
    Left =-1
    Top =-1
    Right =1600
    Bottom =292
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =57
        Top =65
        Right =299
        Bottom =265
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
End
