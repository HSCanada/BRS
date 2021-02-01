Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.group_type) In (\"AAES\",\"AAFS\",\"DEPS\")))"
Begin InputTables
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.group_type"
    Expression ="BRS_FSC_Rollup.order_taken_by"
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
dbMemo "OrderBy" ="[CCA43_territory_review].[comm_salesperson_key_id]"
Begin
    Begin
        dbText "Name" ="BRS_FSC_Rollup.comm_salesperson_key_id"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
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
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.group_type"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1561
    Bottom =938
    Left =-1
    Top =-1
    Right =1537
    Bottom =119
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =99
        Top =57
        Right =357
        Bottom =242
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
