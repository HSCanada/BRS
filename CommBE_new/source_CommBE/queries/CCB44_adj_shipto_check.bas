Operation =1
Option =0
Where ="(((BRS_Customer.ShipTo) Is Null))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
    Expression ="Integration_comm_adjustment_Staging.WSVR02_reference_2"
    Expression ="Integration_comm_adjustment_Staging.WSSHAN_shipto"
    Expression ="BRS_Customer.ShipTo"
End
Begin Joins
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_comm_adjustment_Staging.WSSHAN_shipto = BRS_Customer.ShipTo"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDOC__document_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSVR02_reference_2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1407
    Bottom =937
    Left =-1
    Top =-1
    Right =1383
    Bottom =481
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =542
        Top =105
        Right =865
        Bottom =444
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
    Begin
        Left =1016
        Top =135
        Right =1160
        Bottom =279
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
