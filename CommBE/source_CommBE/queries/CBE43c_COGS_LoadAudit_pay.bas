Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"import\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_transaction.record_id"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction.line_id"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE43c_COGS_LoadAudit].[line_id], [CBE43c_COGS_LoadAudit].[transaction_amt], [C"
    "BE43c_COGS_LoadAudit].[ess_salesperson_cd]"
dbMemo "Filter" ="([CBE43c_COGS_LoadAudit].[ess_salesperson_cd]=\"ESS67     \")"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1462
    Bottom =976
    Left =-1
    Top =-1
    Right =1444
    Bottom =532
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =465
        Bottom =468
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =576
        Top =25
        Right =931
        Bottom =341
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
