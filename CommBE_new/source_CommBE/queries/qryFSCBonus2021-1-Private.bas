Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth) Between 202001 And 202101) AND ((comm_t"
    "ransaction_F555115.fsc_comm_plan_id) In (\"FSCGP02\",\"FSCGP03\",\"FSCGPM\")) AN"
    "D ((comm_transaction_F555115.fsc_comm_group_cd) In (\"ITMPVT\",\"ITMSND\")) AND "
    "((comm_transaction_F555115.source_cd)=\"JDE\") AND ((BRS_Item.SalesCategory)=\"M"
    "ERCH\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Alias ="fsc_salesperson_key_id_"
    Expression ="Trim([fsc_salesperson_key_id])"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Alias ="gp_ext_amt"
    Expression ="Sum(comm_transaction_F555115.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Item"
    Expression ="comm_transaction_F555115.WSLITM_item_number = BRS_Item.Item"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction_F555115.FiscalMonth"
    GroupLevel =0
    Expression ="Trim([fsc_salesperson_key_id])"
    GroupLevel =0
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    GroupLevel =0
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
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fsc_salesperson_key_id_"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-142
    Top =34
    Right =1382
    Bottom =932
    Left =-1
    Top =-1
    Right =1500
    Bottom =601
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =121
        Top =72
        Right =534
        Bottom =469
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =636
        Top =119
        Right =974
        Bottom =445
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
