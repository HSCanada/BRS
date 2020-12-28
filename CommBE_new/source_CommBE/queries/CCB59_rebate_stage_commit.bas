Operation =3
Name ="comm_customer_rebate"
Option =0
Begin InputTables
    Name ="Integration_comm_customer_rebate_Staging"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="Integration_comm_customer_rebate_Staging.FiscalMonth"
    Name ="ShipTo"
    Expression ="Integration_comm_customer_rebate_Staging.ShipTo"
    Name ="original_line_number"
    Expression ="Integration_comm_customer_rebate_Staging.original_line_number"
    Name ="SourceCode"
    Expression ="Integration_comm_customer_rebate_Staging.SourceCode"
    Name ="PracticeName"
    Expression ="Integration_comm_customer_rebate_Staging.PracticeName"
    Name ="rebate_amt"
    Expression ="Integration_comm_customer_rebate_Staging.rebate_amt"
    Name ="comm_note_txt"
    Expression ="Integration_comm_customer_rebate_Staging.comm_note_txt"
    Name ="fsc_salesperson_key_id"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_salesperson_key_id"
    Name ="fsc_comm_group_cd"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_comm_group_cd"
    Name ="fsc_code"
    Expression ="Integration_comm_customer_rebate_Staging.fsc_code"
    Name ="isr_salesperson_key_id"
    Expression ="Integration_comm_customer_rebate_Staging.isr_salesperson_key_id"
    Name ="isr_comm_group_cd"
    Expression ="Integration_comm_customer_rebate_Staging.isr_comm_group_cd"
    Name ="isr_code"
    Expression ="Integration_comm_customer_rebate_Staging.isr_code"
    Name ="status_code"
    Expression ="Integration_comm_customer_rebate_Staging.status_code"
    Name ="teeth_share_rt"
    Expression ="Integration_comm_customer_rebate_Staging.teeth_share_rt"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.teeth_share_rt"
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
        dbText "Name" ="Integration_comm_customer_rebate_Staging.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.rebate_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3000"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-591
    Top =126
    Right =1265
    Bottom =633
    Left =-1
    Top =-1
    Right =1097
    Bottom =186
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =46
        Top =25
        Right =287
        Bottom =221
        Top =0
        Name ="Integration_comm_customer_rebate_Staging"
        Name =""
    End
End
