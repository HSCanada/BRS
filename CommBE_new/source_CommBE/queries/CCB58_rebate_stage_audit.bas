Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_customer_rebate_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_customer_rebate_Staging.FiscalMonth"
    Alias ="CountOforiginal_line_number"
    Expression ="Count(Integration_comm_customer_rebate_Staging.original_line_number)"
    Alias ="MaxOforiginal_line_number"
    Expression ="Max(Integration_comm_customer_rebate_Staging.original_line_number)"
    Alias ="SumOfrebate_amt"
    Expression ="Sum(Integration_comm_customer_rebate_Staging.rebate_amt)"
End
Begin Groups
    Expression ="Integration_comm_customer_rebate_Staging.FiscalMonth"
    GroupLevel =0
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
        dbText "Name" ="CountOforiginal_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOforiginal_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_customer_rebate_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfrebate_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1121
    Bottom =547
    Left =-1
    Top =-1
    Right =1097
    Bottom =220
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =408
        Top =32
        Right =686
        Bottom =219
        Top =0
        Name ="Integration_comm_customer_rebate_Staging"
        Name =""
    End
End
