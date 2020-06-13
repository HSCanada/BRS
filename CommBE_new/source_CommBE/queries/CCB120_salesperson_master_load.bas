Operation =1
Option =0
Begin InputTables
    Name ="Integration_salesperson_master_Staging"
End
Begin OutputColumns
    Expression ="Integration_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_salesperson_master_Staging.employee_num"
    Expression ="Integration_salesperson_master_Staging.master_salesperson_cd"
    Expression ="Integration_salesperson_master_Staging.CostCenter"
    Expression ="Integration_salesperson_master_Staging.salesperson_nm"
    Expression ="Integration_salesperson_master_Staging.territory_start_dt"
    Expression ="Integration_salesperson_master_Staging.comm_plan_id"
    Expression ="Integration_salesperson_master_Staging.salary_draw_amt"
    Expression ="Integration_salesperson_master_Staging.deficit_amt"
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
        dbText "Name" ="Integration_salesperson_master_Staging.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1935"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.salary_draw_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.CostCenter"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.deficit_amt"
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
    Bottom =481
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =494
        Bottom =265
        Top =0
        Name ="Integration_salesperson_master_Staging"
        Name =""
    End
End
