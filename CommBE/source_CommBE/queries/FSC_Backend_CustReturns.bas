dbMemo "SQL" ="SELECT comm_salesperson_master.employee_num, First(comm_salesperson_master.sales"
    "person_nm) AS salesperson_nm, \"\" AS blank_column, Sum(STAGE_ReturnsMTD.[Fiscal"
    " MTD Gross Sales]) AS current_sales, Sum(STAGE_ReturnsMTD.[Fiscal YTD Gross Sale"
    "s]) AS cumulative_sales, Sum(STAGE_ReturnsMTD.[Fiscal MTD Credits]) AS current_r"
    "eturns, Sum(STAGE_ReturnsMTD.[Fiscal YTD Credits]) AS cumulative_returns\015\012"
    "FROM STAGE_ReturnsMTD LEFT JOIN (comm_salesperson_master RIGHT JOIN comm_salespe"
    "rson_code_map ON comm_salesperson_master.salesperson_key_id = comm_salesperson_c"
    "ode_map.salesperson_key_id) ON STAGE_ReturnsMTD.[Territory (AAFS)] = comm_salesp"
    "erson_code_map.salesperson_cd\015\012GROUP BY comm_salesperson_master.employee_n"
    "um;\015\012"
dbMemo "Connect" =""
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
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
