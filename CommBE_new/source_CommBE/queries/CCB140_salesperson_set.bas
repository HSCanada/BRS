Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.group_type) In (\"AAFS\",\"AAES\",\"DEPS\")) AND ((BRS_FSC_Rol"
    "lup.comm_salesperson_key_id) Is Null))"
Begin InputTables
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.AddedDt"
    Expression ="BRS_FSC_Rollup.group_type"
    Expression ="BRS_FSC_Rollup.order_taken_by"
    Expression ="BRS_FSC_Rollup.comm_salesperson_key_id"
End
Begin OrderBy
    Expression ="BRS_FSC_Rollup.AddedDt"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="New or missing FSC data?"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.comm_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.group_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.order_taken_by"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.AddedDt"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =254
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =56
        Top =18
        Right =322
        Bottom =251
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
