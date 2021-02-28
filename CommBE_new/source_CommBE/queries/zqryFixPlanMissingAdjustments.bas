Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=202101) AND ((comm_transaction_F555115."
    "source_cd)<>\"JDE\") AND ((comm_transaction_F555115.fsc_salesperson_key_id)<>\"\""
    ") AND ((comm_transaction_F555115.fsc_comm_plan_id) Is Null))"
Begin InputTables
    Name ="comm_transaction_F555115"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_comm_plan_id"
    Expression ="comm_salesperson_master.comm_plan_id"
End
Begin Joins
    LeftTable ="comm_transaction_F555115"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id = comm_salesperson_master.salesp"
        "erson_key_id"
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
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1524
    Bottom =938
    Left =-1
    Top =-1
    Right =1500
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =17
        Top =27
        Right =395
        Bottom =334
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
    Begin
        Left =506
        Top =42
        Right =728
        Bottom =335
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
