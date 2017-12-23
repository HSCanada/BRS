Operation =1
Option =0
Begin InputTables
    Name ="qsubGP_Part"
    Name ="qsubGP_EQ"
End
Begin OutputColumns
    Expression ="qsubGP_Part.fiscal_yearmo_num"
    Expression ="qsubGP_Part.DocPart"
    Expression ="qsubGP_Part.SumOftransaction_amt"
    Expression ="qsubGP_EQ.SumOftransaction_amt"
End
Begin Joins
    LeftTable ="qsubGP_Part"
    RightTable ="qsubGP_EQ"
    Expression ="qsubGP_Part.DocPart = qsubGP_EQ.NonPartDoc"
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
        dbText "Name" ="qsubGP_EQ.SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubGP_Part.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubGP_Part.DocPart"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubGP_Part.SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1519
    Bottom =997
    Left =-1
    Top =-1
    Right =1487
    Bottom =674
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="qsubGP_Part"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="qsubGP_EQ"
        Name =""
    End
End
