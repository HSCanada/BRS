Operation =1
Option =0
Having ="(((comm_transaction.fiscal_yearmo_num)>=\"201901\") AND ((comm_transaction.ess_c"
    "omm_group_cd) In (\"SPMFGS\",\"SPMFGE\",\"FRESND\",\"FRESEQ\")))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="CountOfrecord_id"
    Expression ="Count(comm_transaction.record_id)"
    Expression ="comm_transaction.ess_comm_group_cd"
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.ess_comm_group_cd"
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfrecord_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =853
    Left =-1
    Top =-1
    Right =1421
    Bottom =449
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =40
        Top =51
        Right =634
        Bottom =518
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
