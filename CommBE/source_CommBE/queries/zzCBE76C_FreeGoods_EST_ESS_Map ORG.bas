Operation =4
Option =0
Where ="(((comm_customer_free_goods_YTD.Source)=\"EST\") AND ((comm_customer_free_goods_"
    "YTD.fiscal_yearmo_num)=[enter fiscal]))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_salesorder_ESS_map"
End
Begin OutputColumns
    Name ="comm_customer_free_goods_YTD.salesperson_ess_cd"
    Expression ="[ess_salesperson_cd]"
End
Begin Joins
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_salesorder_ESS_map"
    Expression ="comm_customer_free_goods_YTD.doc_id = comm_salesorder_ESS_map.doc_id"
    Flag =1
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubESS_Salesorder.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesorder_ESS_map.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesorder_ESS_map.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-207
    Top =46
    Right =1319
    Bottom =1010
    Left =-1
    Top =-1
    Right =1502
    Bottom =499
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =243
        Top =34
        Right =606
        Bottom =329
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
    Begin
        Left =745
        Top =104
        Right =1103
        Bottom =398
        Top =0
        Name ="comm_salesorder_ESS_map"
        Name =""
    End
End
