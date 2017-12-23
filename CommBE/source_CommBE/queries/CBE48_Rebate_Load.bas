Operation =1
Option =0
Begin InputTables
    Name ="comm_customer_rebate_YTD"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_customer_rebate_YTD.fiscal_yearmo_num"
    Expression ="comm_customer_rebate_YTD.cust_account"
    Expression ="comm_customer_rebate_YTD.salesperson_cd"
    Expression ="comm_customer_rebate_YTD.rebate_YTD"
End
Begin Joins
    LeftTable ="comm_customer_rebate_YTD"
    RightTable ="comm_configure"
    Expression ="comm_customer_rebate_YTD.fiscal_yearmo_num = comm_configure.current_fiscal_yearm"
        "o_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbMemo "OrderBy" ="[CBE48_Rebate_Load].[fiscal_yearmo_num] DESC"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.cust_account"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.rebate_YTD"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.[salesperson_cd]"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1164
    Bottom =916
    Left =-1
    Top =-1
    Right =1141
    Bottom =219
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =244
        Bottom =128
        Top =0
        Name ="comm_customer_rebate_YTD"
        Name =""
    End
    Begin
        Left =315
        Top =33
        Right =543
        Bottom =177
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
