Operation =1
Option =0
Begin InputTables
    Name ="qsubCommTransactionHsiStage"
End
Begin OutputColumns
    Expression ="qsubCommTransactionHsiStage.hsi_shipto_div_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(qsubCommTransactionHsiStage.transaction_amt)"
    Alias ="CountOfkey_id"
    Expression ="Count(qsubCommTransactionHsiStage.key_id)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(qsubCommTransactionHsiStage.gp_ext_amt)"
End
Begin Groups
    Expression ="qsubCommTransactionHsiStage.hsi_shipto_div_cd"
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
dbMemo "OrderBy" ="[CBE01_StageSales_Audit].[hsi_shipto_div_cd] DESC"
Begin
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbInteger "ColumnWidth" ="2175"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfkey_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-208
    Top =35
    Right =1327
    Bottom =1004
    Left =-1
    Top =-1
    Right =1503
    Bottom =349
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =495
        Bottom =278
        Top =0
        Name ="qsubCommTransactionHsiStage"
        Name =""
    End
End
