Operation =1
Option =0
Begin InputTables
    Name ="Integration_F555115_commission_sales_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.FiscalMonth"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSVR01_reference"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSLNID_line_number"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_code"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_code"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.eps_code"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.cps_code"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSSHAN_shipto"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.[WS$NM1__name_1]"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSDOCO_salesorder_number"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSLITM_item_number"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSDSC1_description"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSDGL__gl_date"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.WSSRP6_manufacturer"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.transaction_amt"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.gp_ext_amt"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.fsc_comm_group_cd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.ess_comm_group_cd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.eps_comm_group_cd"
    Expression ="Integration_F555115_commission_sales_adjustment_Staging.cps_comm_group_cd"
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
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.eps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSVR01_reference"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.cps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSLNID_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSDSC1_description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSSHAN_shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSDGL__gl_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.[WS$NM1__name_1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSSRP6_manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.WSLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F555115_commission_sales_adjustment_Staging.cps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =221
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =162
        Top =39
        Right =406
        Bottom =183
        Top =0
        Name ="Integration_F555115_commission_sales_adjustment_Staging"
        Name =""
    End
End
