Operation =1
Option =0
Where ="(((qsubCommTransactionHsiStage.hsi_shipto_div_cd)<>\"AZA\"))"
Having ="(((qsubCommTransactionHsiStage.order_source_cd)=\"A\" Or (qsubCommTransactionHsi"
    "Stage.order_source_cd)=\"L\"))"
Begin InputTables
    Name ="qsubCommTransactionHsiStage"
End
Begin OutputColumns
    Expression ="qsubCommTransactionHsiStage.order_source_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(qsubCommTransactionHsiStage.transaction_amt)"
    Alias ="CountOfkey_id"
    Expression ="Count(qsubCommTransactionHsiStage.key_id)"
End
Begin OrderBy
    Expression ="qsubCommTransactionHsiStage.order_source_cd"
    Flag =0
End
Begin Groups
    Expression ="qsubCommTransactionHsiStage.order_source_cd"
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
        dbText "Name" ="qsubCommTransactionHsiStage.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1443
    Bottom =1009
    Left =-1
    Top =-1
    Right =1420
    Bottom =399
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
