Operation =1
Option =0
Where ="(((Integration_comm_adjustment_Staging.fsc_code)<>\".\") AND ((Integration_comm_"
    "adjustment_Staging.ess_code)<>\".\"))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.fsc_code"
    Expression ="Integration_comm_adjustment_Staging.fsc_salesperson_key_id"
    Expression ="Integration_comm_adjustment_Staging.ess_code"
    Expression ="Integration_comm_adjustment_Staging.ess_salesperson_key_id"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.ess_comm_group_cd"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDOC__document_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1523
    Bottom =937
    Left =-1
    Top =-1
    Right =1499
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =73
        Top =57
        Right =591
        Bottom =538
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
End
