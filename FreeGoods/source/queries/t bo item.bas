Operation =1
Option =0
Begin InputTables
    Name ="zzzItem"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="zzzItem.Item"
    Expression ="BRS_Item.FamilySetLeader"
    Alias ="Expr1"
    Expression ="Trim([BRS_Item]![Item]) & \" | \" & [BRS_Item]![ItemDescription]"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
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
        dbText "Name" ="zzzItem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="4185"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FamilySetLeader"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1541
    Bottom =918
    Left =-1
    Top =-1
    Right =1255
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =84
        Top =60
        Right =494
        Bottom =405
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =549
        Top =78
        Right =693
        Bottom =222
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
