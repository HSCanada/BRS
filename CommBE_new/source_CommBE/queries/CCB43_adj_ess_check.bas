Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.TerritoryCd) Is Null))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
    Expression ="Integration_comm_adjustment_Staging.ess_code"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
End
Begin Joins
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_adjustment_Staging.ess_code = BRS_FSC_Rollup.TerritoryCd"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
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
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
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
    Bottom =515
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
        Left =972
        Top =107
        Right =1261
        Bottom =433
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
