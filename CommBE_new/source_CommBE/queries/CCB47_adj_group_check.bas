Operation =1
Option =0
Where ="(((Integration_comm_adjustment_Staging.fsc_comm_group_cd) Is Null))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
    Expression ="comm_group.comm_group_cd"
End
Begin Joins
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="comm_group"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd = comm_group.comm_group_cd"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
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
    Bottom =413
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =466
        Top =48
        Right =789
        Bottom =387
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
    Begin
        Left =982
        Top =157
        Right =1126
        Bottom =301
        Top =0
        Name ="comm_group"
        Name =""
    End
End
