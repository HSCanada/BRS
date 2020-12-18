Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.TerritoryCd)<>\"\") AND ((BRS_FSC_Rollup.group_type)<>\"AAFS\""
    "))"
Begin InputTables
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.group_type"
End
Begin Joins
    LeftTable ="BRS_FSC_Rollup"
    RightTable ="BRS_Customer"
    Expression ="BRS_FSC_Rollup.TerritoryCd = BRS_Customer.TerritoryCd"
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
        dbText "Name" ="BRS_FSC_Rollup.group_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1160
    Bottom =945
    Left =-1
    Top =-1
    Right =1136
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =80
        Top =93
        Right =383
        Bottom =484
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =505
        Top =106
        Right =908
        Bottom =381
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
