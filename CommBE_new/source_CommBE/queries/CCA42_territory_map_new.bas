Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.group_type)=\"AAFS\") AND ((BRS_FSC_Rollup.comm_salesperson_ke"
    "y_id) Is Null Or (BRS_FSC_Rollup.comm_salesperson_key_id)=\"\")) OR (((BRS_FSC_R"
    "ollup.TerritoryCd) Like \"ESS*\") AND ((BRS_FSC_Rollup.comm_salesperson_key_id) "
    "Is Null Or (BRS_FSC_Rollup.comm_salesperson_key_id)=\"\")) OR (((BRS_FSC_Rollup."
    "TerritoryCd) Like \"CCS*\") AND ((BRS_FSC_Rollup.comm_salesperson_key_id) Is Nul"
    "l Or (BRS_FSC_Rollup.comm_salesperson_key_id)=\"\")) OR (((BRS_FSC_Rollup.Territ"
    "oryCd)<>\"\") AND ((BRS_FSC_Rollup.group_type)=\"\")) OR (((BRS_FSC_Rollup.group"
    "_type)=\"DEPS\")) OR (((BRS_FSC_Rollup.group_type)=\"AAES\")) OR (((BRS_FSC_Roll"
    "up.group_type)=\"DDTS\"))"
Begin InputTables
    Name ="BRS_FSC_Rollup"
    Name ="Integration_comm_salesperson_master_Staging"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.order_taken_by"
    Expression ="BRS_FSC_Rollup.AddedDt"
    Expression ="BRS_FSC_Rollup.group_type"
    Expression ="BRS_FSC_Rollup.comm_salesperson_key_id"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
End
Begin Joins
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Roll"
        "up.TerritoryCd"
    Flag =3
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
dbMemo "OrderBy" ="[CCA42_territory_map_new].[comm_salesperson_key_id]"
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
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =946
    Left =-1
    Top =-1
    Right =1537
    Bottom =136
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
    Begin
        Left =553
        Top =34
        Right =897
        Bottom =240
        Top =0
        Name ="Integration_comm_salesperson_master_Staging"
        Name =""
    End
End
