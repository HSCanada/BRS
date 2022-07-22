Operation =1
Option =0
Where ="(((IsNumeric([Quantity]))=True))"
Begin InputTables
    Name ="lnkEQProj"
End
Begin OutputColumns
    Expression ="lnkEQProj.Center"
    Expression ="lnkEQProj.OrdNum"
    Expression ="lnkEQProj.OrderDate"
    Expression ="lnkEQProj.ST"
    Alias ="Part_"
    Expression ="Nz([Part],\"\")"
    Alias ="Qty"
    Expression ="CInt([Quantity])"
    Alias ="Ext_Price"
    Expression ="[Quantity]*[Price]"
    Alias ="Ext_Cost"
    Expression ="[Quantity]*[Cost]"
    Alias ="Supplier"
    Expression ="Trim(Nz([Vendor],\"\"))"
    Alias ="Proj_Date"
    Expression ="CDate(Nz(Left([ProjectedDate],12),[OrderDate]))"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="lnkEQProj.OrdNum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Center"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.OrderDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Ext_Price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Ext_Cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Proj_Date"
        dbText "Format" ="Medium Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Part_"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =-8
    Right =1554
    Bottom =933
    Left =-1
    Top =-1
    Right =1522
    Bottom =298
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =43
        Top =20
        Right =226
        Bottom =275
        Top =0
        Name ="lnkEQProj"
        Name =""
    End
End
