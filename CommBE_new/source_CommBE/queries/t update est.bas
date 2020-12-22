Operation =1
Option =0
Where ="(((BRS_Item.MajorProductClass)=\"805\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.comm_group_est_cd"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[t update est].[Est12MoSales] DESC"
Begin
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_est_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =961
    Bottom =547
    Left =-1
    Top =-1
    Right =937
    Bottom =327
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =23
        Top =29
        Right =340
        Bottom =272
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
