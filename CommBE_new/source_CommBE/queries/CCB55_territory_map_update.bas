Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.group_type)=\"AAFS\") AND ((BRS_FSC_Rollup.comm_salesperson_ke"
    "y_id) Is Null)) OR (((BRS_FSC_Rollup.TerritoryCd) Like \"ESS*\") AND ((BRS_FSC_R"
    "ollup.comm_salesperson_key_id) Is Null)) OR (((BRS_FSC_Rollup.TerritoryCd) Like "
    "\"CCS*\") AND ((BRS_FSC_Rollup.comm_salesperson_key_id) Is Null))"
Begin InputTables
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.order_taken_by"
    Expression ="BRS_FSC_Rollup.AddedDt"
    Expression ="BRS_FSC_Rollup.group_type"
    Expression ="BRS_FSC_Rollup.comm_salesperson_key_id"
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
        dbText "Name" ="BRS_FSC_Rollup.comm_salesperson_key_id"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
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
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbInteger "ColumnWidth" ="3315"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.AddedDt"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Medium Date"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =937
    Left =-1
    Top =-1
    Right =1063
    Bottom =300
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =78
        Top =25
        Right =457
        Bottom =294
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
