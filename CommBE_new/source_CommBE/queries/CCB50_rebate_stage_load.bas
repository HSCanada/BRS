Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_customer_rebate_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_customer_rebate_Staging.FiscalMonth"
    Expression ="Integration_comm_customer_rebate_Staging.original_line_number"
    Expression ="Integration_comm_customer_rebate_Staging.ShipTo"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_code"
    Expression ="Integration_comm_customer_rebate_Staging.rebate_amt"
    Expression ="Integration_comm_customer_rebate_Staging.PracticeName"
    Expression ="Integration_comm_customer_rebate_Staging.SourceCode"
    Expression ="Integration_comm_customer_rebate_Staging.comm_note_txt"
    Expression ="Integration_comm_customer_rebate_Staging.status_code"
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
        dbText "Name" ="Integration_comm_customer_rebate_Staging.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.PracticeName"
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
        dbText "Name" ="Integration_comm_customer_rebate_Staging.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.rebate_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =64
    Top =50
    Right =1476
    Bottom =827
    Left =-1
    Top =-1
    Right =1388
    Bottom =271
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =320
        Top =36
        Right =570
        Bottom =253
        Top =0
        Name ="Integration_comm_customer_rebate_Staging"
        Name =""
    End
End
