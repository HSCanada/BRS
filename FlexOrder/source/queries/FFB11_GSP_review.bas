Operation =1
Option =0
Where ="(((flex_order_file.status_code)=0) AND ((flex_order_file.batch_id) Is Null) AND "
    "((flex_order_file.flex_code)=\"PG_GSP\"))"
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_order_detail"
    Name ="flex_order_file"
    Name ="flex_batch_template"
    Name ="BRS_Customer"
    Name ="BRS_CustomerVPA"
End
Begin OutputColumns
    Alias ="A_Ship_To"
    Expression ="flex_order_header.ShipTo"
    Alias ="B_Item_number"
    Expression ="flex_order_detail.Item"
    Alias ="C_Qty"
    Expression ="flex_order_detail.QTY"
    Alias ="D_Unit_Price"
    Expression ="IIf([PRICE]=0 Or [flex_jde_pricing_ind]=0,CLng([PRICE]*10000),\"\")"
    Alias ="E_Line_price_Override"
    Expression ="IIf([PRICE]=0 Or [flex_jde_pricing_ind]=0,1,\"\")"
    Alias ="F_Customer_PO"
    Expression ="[flex_po_prefix] & [flex_order_header]![ORDERNO] & \"_\" & [flex_order_header]!["
        "ACCOUNT]"
    Alias ="G_Refer_order"
    Expression ="flex_order_header.ORDERNO"
    Alias ="H_Order_Taken_By"
    Expression ="flex_batch_template.OrderTakenBy"
    Alias ="I_Ordered_By"
    Expression ="flex_batch_template.OrderTakenBy"
    Alias ="J_Refer_Order"
    Expression ="flex_batch_template.refer_order"
    Alias ="K_Order_Pend"
    Expression ="flex_batch_template.order_pend"
End
Begin Joins
    LeftTable ="flex_order_header"
    RightTable ="flex_order_detail"
    Expression ="flex_order_header.Supplier = flex_order_detail.Supplier"
    Flag =1
    LeftTable ="flex_order_header"
    RightTable ="flex_order_detail"
    Expression ="flex_order_header.ORDERNO = flex_order_detail.ORDERNO"
    Flag =1
    LeftTable ="flex_order_file"
    RightTable ="flex_order_header"
    Expression ="flex_order_file.order_file_key = flex_order_header.order_file_key"
    Flag =1
    LeftTable ="flex_order_file"
    RightTable ="flex_batch_template"
    Expression ="flex_order_file.flex_code = flex_batch_template.flex_code"
    Flag =1
    LeftTable ="flex_order_header"
    RightTable ="BRS_Customer"
    Expression ="flex_order_header.ShipTo = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="flex_order_header"
    RightTable ="BRS_Customer"
    Expression ="flex_order_header.ShipTo = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_CustomerVPA"
    Expression ="BRS_Customer.VPA = BRS_CustomerVPA.VPA"
    Flag =1
End
Begin OrderBy
    Expression ="flex_order_header.ShipTo"
    Flag =0
    Expression ="[flex_po_prefix] & [flex_order_header]![ORDERNO] & \"_\" & [flex_order_header]!["
        "ACCOUNT]"
    Flag =0
    Expression ="flex_order_header.ORDERNO"
    Flag =0
    Expression ="flex_order_detail.line_id"
    Flag =0
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
        dbText "Name" ="A_Ship_To"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1395"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="J_Refer_order"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1755"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="K_Order_Pend"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1770"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="F_Customer_PO"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="B_Item_number"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="I_Ordered_By"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="C_Qty"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="975"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="D_Unit_Price"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1620"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="E_Line_price_Override"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="G_Refer_order"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="H_Order_Taken_By"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2190"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =2798
    Bottom =1712
    Left =-1
    Top =-1
    Right =2773
    Bottom =908
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =460
        Top =170
        Right =659
        Bottom =425
        Top =0
        Name ="flex_order_header"
        Name =""
    End
    Begin
        Left =1213
        Top =87
        Right =1633
        Bottom =454
        Top =0
        Name ="flex_order_detail"
        Name =""
    End
    Begin
        Left =102
        Top =13
        Right =285
        Bottom =311
        Top =0
        Name ="flex_order_file"
        Name =""
    End
    Begin
        Left =671
        Top =-22
        Right =1008
        Bottom =185
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
    Begin
        Left =940
        Top =312
        Right =1084
        Bottom =456
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =1346
        Top =508
        Right =1562
        Bottom =724
        Top =0
        Name ="BRS_CustomerVPA"
        Name =""
    End
End
