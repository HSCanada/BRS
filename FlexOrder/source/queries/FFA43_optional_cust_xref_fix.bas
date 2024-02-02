Operation =1
Option =0
Where ="(((flex_customer_xref.status_code)=0) AND (([ACCOUNT] & [ShipTo] & [ShipTo_Sugge"
    "st] & [Company]) Like \"*\" & [cust  lookup] & \"*\"))"
Begin InputTables
    Name ="flex_customer_xref"
End
Begin OutputColumns
    Expression ="flex_customer_xref.Supplier"
    Expression ="flex_customer_xref.ACCOUNT"
    Expression ="flex_customer_xref.COMPANY"
    Expression ="flex_customer_xref.FIRSTLAST"
    Alias ="ShipToNEW"
    Expression ="flex_customer_xref.ShipTo"
    Expression ="flex_customer_xref.ShipTo_Suggest"
    Expression ="flex_customer_xref.status_code"
    Alias ="noteNEW"
    Expression ="flex_customer_xref.note"
    Expression ="flex_customer_xref.create_date"
    Expression ="flex_customer_xref.PHONE"
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
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.create_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.COMPANY"
        dbInteger "ColumnWidth" ="4005"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ShipToNEW"
        dbInteger "ColumnWidth" ="1500"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="noteNEW"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1582
    Bottom =851
    Left =-1
    Top =-1
    Right =1296
    Bottom =253
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =353
        Top =72
        Right =497
        Bottom =216
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
End
