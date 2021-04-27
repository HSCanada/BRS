Operation =1
Option =0
Where ="(((flex_customer_xref.status_code)<>0))"
Begin InputTables
    Name ="zzzShipto"
    Name ="flex_customer_xref"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Alias ="src"
    Expression ="\"HSC\""
    Expression ="flex_customer_xref.ACCOUNT"
    Expression ="flex_customer_xref.ShipTo_Suggest"
    Expression ="flex_customer_xref.ShipTo"
    Expression ="flex_customer_xref.status_code"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.MailingName"
    Expression ="BRS_Customer.AddressLine3"
    Expression ="BRS_Customer.AddressLine4"
    Expression ="BRS_Customer.PhoneNo"
    Expression ="BRS_Customer.Province"
    Expression ="BRS_Customer.City"
    Expression ="BRS_Customer.PostalCode"
    Expression ="BRS_Customer.PhoneNo"
    Expression ="BRS_Customer.AccountType"
    Expression ="BRS_Customer.Est12MoMerch"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="flex_customer_xref"
    Expression ="zzzShipto.ST = flex_customer_xref.ACCOUNT"
    Flag =1
    LeftTable ="flex_customer_xref"
    RightTable ="BRS_Customer"
    Expression ="flex_customer_xref.ShipTo = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="flex_customer_xref"
    RightTable ="BRS_Customer"
    Expression ="flex_customer_xref.ShipTo = BRS_Customer.ShipTo"
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
    Begin
        dbText "Name" ="Expr1009"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MailingName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AddressLine3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AccountType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AddressLine4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PhoneNo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Province"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.City"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PostalCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="src"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
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
    Begin
        Left =846
        Top =107
        Right =1112
        Bottom =372
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
