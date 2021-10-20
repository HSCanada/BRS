Operation =1
Option =0
Where ="(((comm_salesperson_master.master_salesperson_cd)<>\"\") AND ((comm_plan.active_"
    "ind)=True))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_plan"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Alias ="lookup"
    Expression ="\"\""
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="BRS_FSC_Rollup.Branch"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2220"
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
    Begin
        dbText "Name" ="lookup"
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
    Right =1500
    Bottom =247
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =88
        Top =67
        Right =426
        Bottom =420
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =544
        Top =38
        Right =861
        Bottom =298
        Top =0
        Name ="comm_plan"
        Name =""
    End
    Begin
        Left =492
        Top =6
        Right =636
        Bottom =150
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
