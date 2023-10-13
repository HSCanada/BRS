Operation =1
Option =0
Where ="(((BRS_Customer.ShipTo) Is Null))"
Begin InputTables
    Name ="Integration_comm_customer_Staging"
    Name ="BRS_Customer"
    Name ="BRS_CustomerBT"
End
Begin OutputColumns
    Expression ="Integration_comm_customer_Staging.ShipTo"
    Expression ="Integration_comm_customer_Staging.merch_comm_cd"
    Expression ="Integration_comm_customer_Staging.equip_comm_cd"
    Expression ="Integration_comm_customer_Staging.comm_note_txt"
    Expression ="BRS_CustomerBT.ShipToPrimary"
End
Begin Joins
    LeftTable ="Integration_comm_customer_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_comm_customer_Staging.ShipTo = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="Integration_comm_customer_Staging"
    RightTable ="BRS_CustomerBT"
    Expression ="Integration_comm_customer_Staging.ShipTo = BRS_CustomerBT.BillTo"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_customer_Staging.comm_note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_Staging.equip_comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_Staging.merch_comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_Staging.ShipTo"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_CustomerBT.ShipToPrimary"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1770"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =88
    Top =146
    Right =1568
    Bottom =938
    Left =-1
    Top =-1
    Right =1456
    Bottom =320
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =78
        Top =43
        Right =376
        Bottom =291
        Top =0
        Name ="Integration_comm_customer_Staging"
        Name =""
    End
    Begin
        Left =524
        Top =48
        Right =668
        Bottom =192
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =443
        Top =206
        Right =587
        Bottom =350
        Top =0
        Name ="BRS_CustomerBT"
        Name =""
    End
End
