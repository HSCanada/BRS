﻿Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth) Between 202001 And 202101) AND ((comm_t"
    "ransaction_F555115.ess_comm_plan_id) Like \"ess*\") AND ((comm_transaction_F5551"
    "15.ess_comm_group_cd) Not In (\"ITMEQ0\",\"DIGIMP\")) AND ((comm_transaction_F55"
    "5115.source_cd)=\"JDE\") AND ((BRS_Item.SubMajorProdClass)=\"800-52\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Alias ="ess_salesperson_key_id_"
    Expression ="Trim([ess_salesperson_key_id])"
    Alias ="ess_comm_group_cd"
    Expression ="\"3DDIMG\""
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
    Expression ="Trim([ess_salesperson_key_id])"
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
        dbText "Name" ="gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_salesperson_key_id_"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1492
    Bottom =756
    Left =-1
    Top =-1
    Right =1500
    Bottom =350
    Left =0
    Top =288
    ColumnsShown =543
    Begin
        Left =121
        Top =-216
        Right =534
        Bottom =181
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =636
        Top =-169
        Right =974
        Bottom =157
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
