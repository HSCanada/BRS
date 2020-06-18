Operation =1
Option =0
Where ="(((comm_transaction_F555115_audit.source_cd)=\"JDE\") AND ((comm_transaction_F55"
    "5115_audit.AdjOwner)=\"380\"))"
Begin InputTables
    Name ="qsub_audit_check"
    Name ="comm_transaction_F555115_audit"
    Name ="comm_config"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115_audit.FiscalMonth"
    Alias ="new_stage_last_date"
    Expression ="qsub_audit_check.MaxOfWSDGL__gl_date"
    Expression ="comm_transaction_F555115_audit.SalesDivision"
    Expression ="comm_transaction_F555115_audit.summarized_transaction_amt"
    Expression ="qsub_audit_check.stage_sales_amt"
    Alias ="diff"
    Expression ="[stage_sales_amt]-[summarized_transaction_amt]"
End
Begin Joins
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="qsub_audit_check"
    Expression ="comm_transaction_F555115_audit.SalesDivision = qsub_audit_check.WSAC10_division_"
        "code"
    Flag =1
    LeftTable ="comm_config"
    RightTable ="comm_transaction_F555115_audit"
    Expression ="comm_config.PriorFiscalMonth = comm_transaction_F555115_audit.FiscalMonth"
    Flag =1
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
        dbText "Name" ="comm_transaction_F555115_audit.summarized_transaction_amt"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.stage_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="diff"
        dbText "Format" ="Fixed"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.MaxOfWSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="new_stage_last_date"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =817
    Left =-1
    Top =-1
    Right =1388
    Bottom =213
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =505
        Top =51
        Right =843
        Bottom =241
        Top =0
        Name ="qsub_audit_check"
        Name =""
    End
    Begin
        Left =227
        Top =46
        Right =451
        Bottom =190
        Top =0
        Name ="comm_transaction_F555115_audit"
        Name =""
    End
    Begin
        Left =46
        Top =26
        Right =190
        Bottom =170
        Top =0
        Name ="comm_config"
        Name =""
    End
End
