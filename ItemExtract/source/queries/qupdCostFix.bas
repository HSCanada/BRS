Operation =4
Option =0
Where ="(((Nz([Item Master Export]!Currency,\"CAD\"))<>STAGE_BRS_ItemBaseHistory!Currenc"
    "y) And ((STAGE_BRS_ItemBaseHistory.CalMonth)=0)) Or (((Nz([Item Master Export]!["
    "Cost Prc Brk1],0))<>[SupplierCost]) And ((STAGE_BRS_ItemBaseHistory.CalMonth)=0)"
    ")"
Begin InputTables
    Name ="Item Master Export"
    Name ="STAGE_BRS_ItemBaseHistory"
End
Begin OutputColumns
    Name ="Item Master Export.Currency"
    Expression ="[STAGE_BRS_ItemBaseHistory]![Currency]"
    Name ="Item Master Export.Cost Prc Brk1"
    Expression ="[SupplierCost]"
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
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
dbText "Description" ="tc"
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
    Begin
        dbText "Name" ="[Item Master Export].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Nz([Item Master Export]![Currency],\"CAD\")"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CalMonth"
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
    Bottom =567
    Left =0
    Top =0
    ColumnsShown =579
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
