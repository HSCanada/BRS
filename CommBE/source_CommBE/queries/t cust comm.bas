Operation =1
Option =0
Where ="(((comm_customer_master.sales_plan_cd) In (\"CENLAPTL\",\"CENLAPT\")))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="comm_customer_master.salesperson_cd"
    Expression ="comm_salesperson_code_map.branch_cd"
    Expression ="comm_customer_master.sales_plan_cd"
    Expression ="comm_salesperson_code_map.salesperson_nm"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_customer_master.SPM_EQOptOut"
    Expression ="comm_customer_master.SPM_ReasonTxt"
End
Begin Joins
    LeftTable ="comm_customer_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_master.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
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
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_ReasonTxt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.sales_plan_cd"
        dbInteger "ColumnWidth" ="1710"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-177
    Top =22
    Right =1386
    Bottom =973
    Left =-1
    Top =-1
    Right =1531
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =267
        Bottom =396
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =346
        Top =24
        Right =805
        Bottom =373
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
