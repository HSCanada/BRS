Operation =1
Option =0
Where ="(((comm_transaction_F555115.source_cd)=\"JDE\"))"
Having ="(((comm_transaction_F555115.FiscalMonth)=202309))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="comm_transfer_rule_DCC2023"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSDCTO_order_type"
    Alias ="fsc_code_ORG"
    Expression ="First(Trim([fsc_code]))"
    Alias ="ess_code_ORG"
    Expression ="First(Trim([ess_code]))"
    Alias ="transfercode"
    Expression ="\"T\""
    Alias ="NewFSC"
    Expression ="First(Trim([FSC]))"
    Alias ="NewESS"
    Expression ="\" \""
    Alias ="FirstOfWSDGL__gl_date"
    Expression ="First(comm_transaction_F555115.WSDGL__gl_date)"
    Alias ="FirstOfWSSHAN_shipto"
    Expression ="First(comm_transaction_F555115.WSSHAN_shipto)"
    Alias ="trans_branch"
    Expression ="0"
    Alias ="comment"
    Expression ="First(Trim([EQOrder]))"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction_F555115.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction_F555115.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="comm_transfer_rule_DCC2023"
    Expression ="comm_transaction_F555115.WSORD__equipment_order = comm_transfer_rule_DCC2023.EQO"
        "rder"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction_F555115.FiscalMonth"
    GroupLevel =0
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    GroupLevel =0
    Expression ="comm_transaction_F555115.WSDCTO_order_type"
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
        dbText "Name" ="NewFSC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfWSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfWSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="trans_branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NewESS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transfercode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comment"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_code_ORG"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fsc_code_ORG"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1470
    Bottom =938
    Left =-1
    Top =-1
    Right =1446
    Bottom =238
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =152
        Top =18
        Right =472
        Bottom =307
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =776
        Top =232
        Right =920
        Bottom =376
        Top =0
        Name ="comm_transfer_rule_DCC2023"
        Name =""
    End
End
