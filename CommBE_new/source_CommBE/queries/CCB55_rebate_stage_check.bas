Operation =1
Option =0
Where ="(((BRS_Customer.ShipTo) Is Null)) OR (((BRS_FSC_Rollup.TerritoryCd) Is Null))"
Begin InputTables
    Name ="BRS_Customer"
    Name ="Integration_comm_customer_rebate_Staging"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="Integration_comm_customer_rebate_Staging.FiscalMonth"
    Expression ="Integration_comm_customer_rebate_Staging.original_line_number"
    Expression ="Integration_comm_customer_rebate_Staging.ShipTo"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_code"
    Expression ="BRS_Customer.ShipTo"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
End
Begin Joins
    LeftTable ="Integration_comm_customer_rebate_Staging"
    RightTable ="BRS_Customer"
    Expression ="Integration_comm_customer_rebate_Staging.ShipTo = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="Integration_comm_customer_rebate_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_code = BRS_FSC_Rollup.TerritoryCd"
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
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.original_line_number"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =6
    Top =40
    Right =1418
    Bottom =937
    Left =-1
    Top =-1
    Right =1388
    Bottom =320
    Left =0
    Top =0
    ColumnsShown =539
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
        Left =53
        Top =4
        Right =234
        Bottom =208
        Top =0
        Name ="Integration_comm_customer_rebate_Staging"
        Name =""
    End
    Begin
        Left =336
        Top =138
        Right =480
        Bottom =282
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
