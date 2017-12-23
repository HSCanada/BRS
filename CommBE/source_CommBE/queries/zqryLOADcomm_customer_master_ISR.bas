Operation =1
Option =0
Begin InputTables
    Name ="comm_customer_master_ISR"
End
Begin OutputColumns
    Expression ="comm_customer_master_ISR.fiscal_yearmo_num"
    Expression ="comm_customer_master_ISR.hsi_shipto_id"
    Expression ="comm_customer_master_ISR.practice_nm"
    Expression ="comm_customer_master_ISR.isr_salesperson_cd"
    Expression ="comm_customer_master_ISR.isr_fscpartner_cd"
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
        dbText "Name" ="comm_customer_master_ISR.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_ISR.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_ISR.practice_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_ISR.isr_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_ISR.isr_fscpartner_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1511
    Bottom =991
    Left =-1
    Top =-1
    Right =1479
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =109
        Top =133
        Right =475
        Bottom =439
        Top =0
        Name ="comm_customer_master_ISR"
        Name =""
    End
End
