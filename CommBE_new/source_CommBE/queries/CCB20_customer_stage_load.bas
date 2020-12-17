Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_customer_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_customer_Staging.ShipTo"
    Expression ="Integration_comm_customer_Staging.merch_comm_cd"
    Expression ="Integration_comm_customer_Staging.equip_comm_cd"
    Expression ="Integration_comm_customer_Staging.comm_note_txt"
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
        dbInteger "ColumnWidth" ="1890"
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
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =817
    Left =-1
    Top =-1
    Right =1388
    Bottom =203
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =111
        Top =21
        Right =255
        Bottom =165
        Top =0
        Name ="Integration_comm_customer_Staging"
        Name =""
    End
End
