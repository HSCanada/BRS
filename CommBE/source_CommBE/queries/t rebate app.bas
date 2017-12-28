Operation =3
Name ="comm_rebate_by_shipto_F55479C"
Option =0
Where ="(((Int([fiscal_yearmo_num]))=201712))"
Begin InputTables
    Name ="comm_customer_rebate_YTD"
End
Begin OutputColumns
    Alias ="fiscal"
    Name ="FiscalMonth"
    Expression ="Int([fiscal_yearmo_num])"
    Alias ="st"
    Name ="QMSHAN_shipto"
    Expression ="Int([cust_account])"
    Alias ="Expr1"
    Name ="QM$TER_territory_code"
    Expression ="Nz([salesperson_cd],\"\")"
    Name ="QMRBAM_rebate_amount"
    Expression ="comm_customer_rebate_YTD.rebate_YTD"
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
Begin
    State =0
    Left =0
    Top =40
    Right =1397
    Bottom =976
    Left =-1
    Top =-1
    Right =1379
    Bottom =660
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =75
        Top =37
        Right =219
        Bottom =181
        Top =0
        Name ="comm_customer_rebate_YTD"
        Name =""
    End
End
