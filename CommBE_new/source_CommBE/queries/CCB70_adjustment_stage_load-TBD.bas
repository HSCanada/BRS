Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.owner_cd"
    Expression ="Integration_comm_adjustment_Staging.line_number_org"
    Expression ="Integration_comm_adjustment_Staging.fsc_code"
    Expression ="Integration_comm_adjustment_Staging.ess_code"
    Expression ="Integration_comm_adjustment_Staging.shipto"
    Expression ="Integration_comm_adjustment_Staging.customer_name"
    Expression ="Integration_comm_adjustment_Staging.salesorder_number"
    Expression ="Integration_comm_adjustment_Staging.item_number"
    Expression ="Integration_comm_adjustment_Staging.comm_note_txt"
    Expression ="Integration_comm_adjustment_Staging.adjustment_type"
    Expression ="Integration_comm_adjustment_Staging.adj_cost_amt"
    Expression ="Integration_comm_adjustment_Staging.adj_sales_amt"
    Expression ="Integration_comm_adjustment_Staging.internal_note_txt"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_amt"
    Expression ="Integration_comm_adjustment_Staging.eps_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.eps_comm_amt"
    Expression ="Integration_comm_adjustment_Staging.ess_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.ess_comm_amt"
    Expression ="Integration_comm_adjustment_Staging.cps_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.cps_comm_amt"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.customer_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.cps_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.owner_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.line_number_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.adjustment_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.adj_cost_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.adj_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.internal_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.eps_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.cps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1061
    Bottom =216
    Left =-1
    Top =-1
    Right =1037
    Bottom =16
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =29
        Right =182
        Bottom =173
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
End
