Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"fsc*\") AND ((BRS_FSC_Rollup.Bra"
    "nch)=\"OTTWA\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.flag_ind"
    Expression ="BRS_FSC_Rollup.Branch"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
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
dbMemo "OrderBy" ="[CCA19_detail_flag_set_manual].[comm_plan_id]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.flag_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1516
    Bottom =918
    Left =-1
    Top =-1
    Right =1230
    Bottom =367
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =16
        Top =8
        Right =354
        Bottom =361
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =459
        Top =39
        Right =603
        Bottom =183
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
