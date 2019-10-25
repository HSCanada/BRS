Operation =1
Option =0
Begin InputTables
    Name ="STAGE_ReturnsMTD"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Alias ="salesperson_nm"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Alias ="blank_column"
    Expression ="\"\""
    Alias ="current_sales"
    Expression ="Sum(STAGE_ReturnsMTD.[Fiscal MTD Gross Sales])"
    Alias ="cumulative_sales"
    Expression ="Sum(STAGE_ReturnsMTD.[Fiscal YTD Gross Sales])"
    Alias ="current_returns"
    Expression ="Sum(STAGE_ReturnsMTD.[Fiscal MTD Credits])"
    Alias ="cumulative_returns"
    Expression ="Sum(STAGE_ReturnsMTD.[Fiscal YTD Credits])"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_master.salesperson_key_id = comm_salesperson_code_map.salespers"
        "on_key_id"
    Flag =3
    LeftTable ="STAGE_ReturnsMTD"
    RightTable ="comm_salesperson_code_map"
    Expression ="STAGE_ReturnsMTD.[Territory (AAFS)] = comm_salesperson_code_map.salesperson_cd"
    Flag =2
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbByte "RecordsetType" ="0"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="blank_column"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="current_sales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cumulative_sales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="current_returns"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cumulative_returns"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1458
    Bottom =865
    Left =-1
    Top =-1
    Right =1434
    Bottom =651
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="STAGE_ReturnsMTD"
        Name =""
    End
    Begin
        Left =823
        Top =70
        Right =967
        Bottom =214
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =440
        Top =102
        Right =695
        Bottom =332
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
