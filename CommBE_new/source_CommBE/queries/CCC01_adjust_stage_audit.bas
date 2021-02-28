Operation =1
Option =0
Begin InputTables
    Name ="comm_adjustment_import"
End
Begin OutputColumns
    Expression ="comm_adjustment_import.FiscalMonth"
    Expression ="comm_adjustment_import.owner_code"
    Expression ="comm_adjustment_import.adj_type_code"
    Alias ="adj_type_code2"
    Expression ="IIf([fsc_comm_group_cd] Like \"reb*\",\"REB\",\"\")"
    Alias ="CountOforiginal_line_number"
    Expression ="Count(comm_adjustment_import.original_line_number)"
    Alias ="MaxOforiginal_line_number"
    Expression ="Max(comm_adjustment_import.original_line_number)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_adjustment_import.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_adjustment_import.gp_ext_amt)"
End
Begin Groups
    Expression ="comm_adjustment_import.FiscalMonth"
    GroupLevel =0
    Expression ="comm_adjustment_import.owner_code"
    GroupLevel =0
    Expression ="comm_adjustment_import.adj_type_code"
    GroupLevel =0
    Expression ="IIf([fsc_comm_group_cd] Like \"reb*\",\"REB\",\"\")"
    GroupLevel =0
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
Begin
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_import.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_import.owner_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOforiginal_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOforiginal_line_number"
        dbInteger "ColumnWidth" ="4035"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_import.adj_type_code"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="adj_type_code2"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1465
    Bottom =938
    Left =-1
    Top =-1
    Right =1441
    Bottom =394
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =287
        Top =69
        Right =576
        Bottom =291
        Top =0
        Name ="comm_adjustment_import"
        Name =""
    End
End
