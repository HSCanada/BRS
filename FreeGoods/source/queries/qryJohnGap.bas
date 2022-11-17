Operation =1
Option =0
Having ="(((fg_transaction_F5554240.CalMonthRedeem)=202110))"
Begin InputTables
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Expression ="fg_transaction_F5554240.fg_redeem_ind"
    Alias ="SumOfWKECST_extended_cost"
    Expression ="Sum(fg_transaction_F5554240.WKECST_extended_cost)"
End
Begin Groups
    Expression ="fg_transaction_F5554240.CalMonthRedeem"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    GroupLevel =0
    Expression ="fg_transaction_F5554240.fg_redeem_ind"
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
        dbText "Name" ="comm_freegoods.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfFiscalMonth"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthOrder"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWKECST_extended_cost"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_redeem_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1564
    Bottom =918
    Left =-1
    Top =-1
    Right =949
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =598
        Top =103
        Right =908
        Bottom =481
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
