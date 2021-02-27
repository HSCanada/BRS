Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth) Between 202001 And 202012) AND ((comm_t"
    "ransaction_F555115.source_cd)=\"JDE\") AND ((comm_transaction_F555115.fsc_comm_p"
    "lan_id) Like \"fsc*\") AND ((comm_transaction_F555115.fsc_comm_group_cd)=\"itmse"
    "r\") AND ((BRS_Customer.AccountType)<>\"D\"))"
Having ="(((Sum(comm_transaction_F555115.gp_ext_amt))>500))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction_F555115.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction_F555115.WSSHAN_shipto"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[qryFSCModel2021-service_select].[SumOfgp_ext_amt] DESC"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_plan_id"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.DateAccountOpened"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AccountType"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =946
    Left =-1
    Top =-1
    Right =1526
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =37
        Right =748
        Bottom =493
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =820
        Top =64
        Right =1153
        Bottom =484
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
