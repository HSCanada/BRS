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
    Alias ="Expr2"
    Name ="QMRBAM_rebate_amount"
    Expression ="comm_customer_rebate_YTD.rebate_YTD"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="fiscal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="st"
    End
    Begin
        dbText "Name" ="Expr1"
    End
    Begin
        dbText "Name" ="Expr2"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =973
    Bottom =687
    Left =-1
    Top =-1
    Right =955
    Bottom =354
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =306
        Bottom =156
        Top =0
        Name ="comm_customer_rebate_YTD"
        Name =""
    End
End
