Operation =1
Option =0
Where ="(((comm_transaction_F555115_audit.source_cd)=\"JDE\") AND ((comm_transaction_F55"
    "5115_audit.AdjOwner)='380'))"
Begin InputTables
    Name ="comm_transaction_F555115_audit"
    Name ="comm_config"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115_audit.FiscalMonth"
    Expression ="comm_transaction_F555115_audit.source_cd"
    Expression ="comm_transaction_F555115_audit.AdjOwner"
    Expression ="comm_transaction_F555115_audit.SalesDivision"
    Expression ="comm_transaction_F555115_audit.summarized_transaction_amt"
End
Begin Joins
    LeftTable ="comm_transaction_F555115_audit"
    RightTable ="comm_config"
    Expression ="comm_transaction_F555115_audit.FiscalMonth = comm_config.PriorFiscalMonth"
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
        dbText "Name" ="comm_transaction_F555115_audit.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.AdjOwner"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =271
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =25
        Top =27
        Right =360
        Bottom =232
        Top =0
        Name ="comm_transaction_F555115_audit"
        Name =""
    End
    Begin
        Left =476
        Top =59
        Right =729
        Bottom =257
        Top =0
        Name ="comm_config"
        Name =""
    End
End
