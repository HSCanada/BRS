Operation =1
Option =0
Where ="(((comm_transaction_F555115_audit.FiscalMonth)=(select [PriorFiscalMonth] from ["
    "BRS_Config])) AND ((comm_transaction_F555115_audit.source_cd)=\"JDE\") AND ((com"
    "m_transaction_F555115_audit.AdjOwner)='380'))"
Begin InputTables
    Name ="comm_transaction_F555115_audit"
    Name ="BRS_SalesDivision"
    Name ="qsub_audit_check"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115_audit.FiscalMonth"
    Expression ="comm_transaction_F555115_audit.source_cd"
    Expression ="comm_transaction_F555115_audit.AdjOwner"
    Expression ="comm_transaction_F555115_audit.SalesDivision"
    Expression ="BRS_SalesDivision.SalesDivisionDesc"
    Alias ="sales_380"
    Expression ="comm_transaction_F555115_audit.summarized_transaction_amt"
    Expression ="qsub_audit_check.stage_sales_amt"
    Alias ="diff"
    Expression ="[stage_sales_amt]-[summarized_transaction_amt]"
End
Begin Joins
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="BRS_SalesDivision"
    Expression ="comm_transaction_F555115_audit.SalesDivision = BRS_SalesDivision.SalesDivision"
    Flag =1
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="qsub_audit_check"
    Expression ="comm_transaction_F555115_audit.FiscalMonth = qsub_audit_check.FiscalMonth"
    Flag =2
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="qsub_audit_check"
    Expression ="comm_transaction_F555115_audit.SalesDivision = qsub_audit_check.WSAC10_division_"
        "code"
    Flag =2
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
        dbText "Name" ="comm_transaction_F555115_audit.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_SalesDivision.SalesDivisionDesc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.AdjOwner"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_audit_check.stage_sales_amt"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbByte "DecimalPlaces" ="2"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="sales_380"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbByte "DecimalPlaces" ="2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="diff"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbByte "DecimalPlaces" ="2"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =44
    Top =93
    Right =1174
    Bottom =693
    Left =-1
    Top =-1
    Right =901
    Bottom =164
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =313
        Bottom =156
        Top =0
        Name ="comm_transaction_F555115_audit"
        Name =""
    End
    Begin
        Left =368
        Top =14
        Right =512
        Bottom =158
        Top =0
        Name ="BRS_SalesDivision"
        Name =""
    End
    Begin
        Left =574
        Top =27
        Right =839
        Bottom =177
        Top =0
        Name ="qsub_audit_check"
        Name =""
    End
End
