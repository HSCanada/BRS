Operation =1
Option =0
Where ="(((Nz([Item Master Export]![Currency],\"CAD\"))<>[STAGE_BRS_ItemBaseHistory]![Cu"
    "rrency])) OR (((Nz([Item Master Export]![Cost Prc Brk1],0))<>[SupplierCost]))"
Begin InputTables
    Name ="Item Master Export"
    Name ="STAGE_BRS_ItemBaseHistory"
End
Begin OutputColumns
    Expression ="[Item Master Export].[HSI Item#]"
    Alias ="curr_"
    Expression ="Nz([Item Master Export]![Currency],\"CAD\")"
    Alias ="cost__"
    Expression ="Nz([Item Master Export]![Cost Prc Brk1],0)"
End
Begin Joins
    LeftTable ="Item Master Export"
    RightTable ="STAGE_BRS_ItemBaseHistory"
    Expression ="[Item Master Export].[HSI Item#] = STAGE_BRS_ItemBaseHistory.Item"
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
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="curr_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost__"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1096
    Bottom =938
    Left =-1
    Top =-1
    Right =1072
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =74
        Top =36
        Right =326
        Bottom =358
        Top =0
        Name ="Item Master Export"
        Name =""
    End
    Begin
        Left =480
        Top =59
        Right =809
        Bottom =383
        Top =0
        Name ="STAGE_BRS_ItemBaseHistory"
        Name =""
    End
End
