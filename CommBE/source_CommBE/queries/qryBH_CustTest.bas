Operation =1
Option =0
Begin InputTables
    Name ="zzzCustList"
    Name ="comm_customer_master"
    Name ="BRS_CustomerBT"
End
Begin OutputColumns
    Expression ="zzzCustList.hsi_customer_id"
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="BRS_CustomerBT.ShipToPrimary"
End
Begin Joins
    LeftTable ="zzzCustList"
    RightTable ="comm_customer_master"
    Expression ="zzzCustList.hsi_customer_id = comm_customer_master.hsi_shipto_id"
    Flag =2
    LeftTable ="zzzCustList"
    RightTable ="BRS_CustomerBT"
    Expression ="zzzCustList.hsi_customer_id = BRS_CustomerBT.BillTo"
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
        dbText "Name" ="zzzCustList.hsi_customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerBT.ShipToPrimary"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1514
    Bottom =991
    Left =-1
    Top =-1
    Right =1482
    Bottom =651
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =71
        Top =29
        Right =361
        Bottom =262
        Top =0
        Name ="zzzCustList"
        Name =""
    End
    Begin
        Left =445
        Top =85
        Right =924
        Bottom =394
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =1002
        Top =89
        Right =1146
        Bottom =233
        Top =0
        Name ="BRS_CustomerBT"
        Name =""
    End
End
