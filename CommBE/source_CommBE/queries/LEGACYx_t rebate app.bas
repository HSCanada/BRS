dbMemo "SQL" ="INSERT INTO comm_rebate_by_shipto_F55479C ( FiscalMonth, QMSHAN_shipto, [QM$TER_"
    "territory_code], QMRBAM_rebate_amount )\015\012SELECT Int([fiscal_yearmo_num]) A"
    "S fiscal, Int([cust_account]) AS st, Nz([salesperson_cd],\"\") AS Expr1, comm_cu"
    "stomer_rebate_YTD.rebate_YTD AS Expr2\015\012FROM comm_customer_rebate_YTD\015\012"
    "WHERE (((Int([fiscal_yearmo_num]))=201712));\015\012"
dbMemo "Connect" =""
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
Begin
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.rebate_YTD"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fiscal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="st"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.cust_account"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
