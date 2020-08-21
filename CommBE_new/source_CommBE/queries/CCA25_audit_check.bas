Operation =1
Option =0
Begin InputTables
    Name ="qsub_audit_check"
    Name ="comm_transaction_F555115_audit"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115_audit.FiscalMonth"
    Expression ="comm_transaction_F555115_audit.source_cd"
    Expression ="comm_transaction_F555115_audit.AdjOwner"
    Expression ="comm_transaction_F555115_audit.SalesDivision"
    Expression ="comm_transaction_F555115_audit.summarized_transaction_amt"
    Expression ="qsub_audit_check.stage_sales_amt"
    Alias ="diff"
    Expression ="[stage_sales_amt]-[summarized_transaction_amt]"
End
Begin Joins
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="qsub_audit_check"
    Expression ="comm_transaction_F555115_audit.FiscalMonth = qsub_audit_check.FiscalMonth"
    Flag =1
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="qsub_audit_check"
    Expression ="comm_transaction_F555115_audit.SalesDivision = qsub_audit_check.SalesDivision"
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
        dbText "Format" ="$#,##0.00;($#,##0.00)"
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
        dbText "Format" ="$#,##0.00;($#,##0.00)"
    End
    Begin
        dbText "Name" ="diff"
        dbText "Format" ="Fixed"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="new_stage_last_date"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1000"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.AdjOwner"
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
    Bottom =179
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =428
        Top =13
        Right =572
        Bottom =157
        Top =0
        Name ="qsub_audit_check"
        Name =""
    End
    Begin
        Left =112
        Top =12
        Right =256
        Bottom =156
        Top =0
        Name ="comm_transaction_F555115_audit"
        Name =""
    End
End
