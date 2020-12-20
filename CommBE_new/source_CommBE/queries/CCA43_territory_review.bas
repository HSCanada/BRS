Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.group_type) In (\"AAES\",\"AAFS\")))"
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
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "Filter" ="([CCA43_TerritoryReview].[Branch]=\"CORP \")"
dbMemo "OrderBy" ="[CCA43_TerritoryReview].[Branch], [CCA43_TerritoryReview].[comm_salesperson_key_"
    "id], [CCA43_TerritoryReview].[order_taken_by]"
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
    Left =-282
    Top =4
    Right =1251
    Bottom =901
    Left =-1
    Top =-1
    Right =1509
    Bottom =306
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
