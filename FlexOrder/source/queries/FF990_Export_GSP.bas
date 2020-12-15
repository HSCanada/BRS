Operation =1
Option =0
Where ="(((flex_order_file.flex_code)=\"PG_GSP\"))"
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_order_detail"
    Name ="flex_order_file"
    Name ="flex_batch_template"
End
Begin OutputColumns
    Alias ="A_Ship_To"
    Expression ="flex_order_header.ShipTo"
    Alias ="B_Customer_PO"
    Expression ="[flex_po_prefix] & [flex_order_header]![ORDERNO]"
    Alias ="C_Item_number"
    Expression ="flex_order_detail.Item"
    Alias ="D_Qty"
    Expression ="flex_order_detail.QTY"
    Alias ="E_Mark_for_line_1"
    Expression ="\"\""
    Alias ="F_Header_Promo_1"
    Expression ="\"\""
    Alias ="G_Line_price_Override"
    Expression ="flex_order_detail.PRICE"
    Alias ="G_Order_Pend"
    Expression ="\"\""
    Alias ="H_Order_Route"
    Expression ="\"\""
    Alias ="I_Primary_Warehouse"
    Expression ="\"\""
    Alias ="J_Ship_Warehouse"
    Expression ="\"\""
    Alias ="K_Refer_order"
    Expression ="flex_order_header.ORDERNO"
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
End
Begin OrderBy
    Expression ="flex_order_header.ShipTo"
    Flag =0
    Expression ="[flex_po_prefix] & [flex_order_header]![ORDERNO]"
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
        dbText "Name" ="D_Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="A_Ship_To"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="B_Customer_PO"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="C_Item_number"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="E_Mark_for_line_1"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="F_Header_Promo_1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="G_Order_Pend"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="H_Order_Route"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="I_Primary_warehouse"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="K_Refer_order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="J_Ship_Warehouse"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="G_Line_price_Override"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1616
    Bottom =917
    Left =-1
    Top =-1
    Right =1600
    Bottom =305
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =324
        Top =109
        Right =523
        Bottom =364
        Top =0
        Name ="flex_order_header"
        Name =""
    End
    Begin
        Left =853
        Top =2
        Right =1273
        Bottom =369
        Top =0
        Name ="flex_order_detail"
        Name =""
    End
    Begin
        Left =102
        Top =13
        Right =246
        Bottom =157
        Top =0
        Name ="flex_order_file"
        Name =""
    End
    Begin
        Left =548
        Top =11
        Right =887
        Bottom =218
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
End
