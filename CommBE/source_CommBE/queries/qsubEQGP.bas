Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.comm_plan_id) Lik"
    "e \"FSC*\") AND ((comm_transaction.order_source_cd) In (\"A\",\"L\")) AND ((comm"
    "_transaction.item_comm_group_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\",\"ITMF"
    "RT\")))"
Having ="(((comm_transaction.fiscal_yearmo_num)=\"201101\") AND ((Sum(comm_transaction.gp"
    "_ext_amt))>=1000 Or (Sum(comm_transaction.gp_ext_amt))<=-1000) AND ((IIf(Sum([tr"
    "ansaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0))<0.29 Or (IIf(Sum"
    "([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0))>1))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.salesperson_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="GP%"
    Expression ="IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_id"
    GroupLevel =0
    Expression ="comm_transaction.salesperson_key_id"
    GroupLevel =0
    Expression ="comm_transaction.salesperson_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qsubEQGP].[GP%] DESC"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnOrder" ="1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnOrder" ="3"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GP%"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Percent"
        dbByte "DecimalPlaces" ="1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbInteger "ColumnOrder" ="2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2715"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1540
    Bottom =1008
    Left =-1
    Top =-1
    Right =1521
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =669
        Bottom =483
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
