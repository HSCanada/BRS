Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth) Between 202001 And 202101) AND ((comm_t"
    "ransaction_F555115.fsc_comm_plan_id) In (\"FSCGP02\",\"FSCGP03\")) AND ((comm_tr"
    "ansaction_F555115.fsc_comm_group_cd)=\"ITMSER\") AND ((comm_transaction_F555115."
    "source_cd)=\"JDE\") AND ((BRS_Item.MajorProductClass)=\"820\") AND ((BRS_Custome"
    "r.comm_fsc_bonus_2_ind)=True))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Item"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Alias ="gp_ext_amt"
    Expression ="Sum(comm_transaction_F555115.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Item"
    Expression ="comm_transaction_F555115.WSLITM_item_number = BRS_Item.Item"
    Flag =1
    LeftTable ="comm_transaction_F555115"
    RightTable ="BRS_Customer"
    Expression ="comm_transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction_F555115.FiscalMonth"
    GroupLevel =0
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
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
        dbText "Name" ="comm_transaction_F555115.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
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
End
Begin
    State =0
    Left =-140
    Top =23
    Right =1384
    Bottom =921
    Left =-1
    Top =-1
    Right =1500
    Bottom =567
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =222
        Top =55
        Right =635
        Bottom =452
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =714
        Top =284
        Right =1052
        Bottom =610
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =676
        Top =30
        Right =937
        Bottom =230
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
