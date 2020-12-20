Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.TerritoryCd) Is Null))"
Begin InputTables
    Name ="Integration_comm_salesperson_master_Staging"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="Integration_comm_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_comm_salesperson_master_Staging.employee_num"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_nm"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
End
Begin Joins
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Roll"
        "up.TerritoryCd"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
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
    Right =1388
    Bottom =337
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =56
        Top =40
        Right =382
        Bottom =238
        Top =0
        Name ="Integration_comm_salesperson_master_Staging"
        Name =""
    End
    Begin
        Left =545
        Top =48
        Right =689
        Bottom =192
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
