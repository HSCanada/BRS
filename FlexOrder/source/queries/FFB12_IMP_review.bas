Operation =1
Option =0
Where ="(((flex_order_file.status_code)=0) AND ((flex_order_file.batch_id) Is Null) AND "
    "((flex_order_file.flex_code)=\"PG_IMP\"))"
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_order_detail"
    Name ="flex_order_file"
    Name ="flex_batch_template"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Alias ="A_Ship_To"
    Expression ="flex_order_header.ShipTo"
    Alias ="B_Document_Type"
    Expression ="flex_batch_template.DocType"
    Alias ="C_Item_number"
    Expression ="flex_order_detail.Item"
    Alias ="D_Line_Type"
    Expression ="flex_batch_template.LineTypeOrder"
    Alias ="E_Qty"
    Expression ="flex_order_detail.QTY"
    Alias ="F_Unit_Price"
    Expression ="IIf([PRICE]=0 Or [VPA] Not In (\"123DNST\",\"DENCORP\"),CLng([PRICE]*10000),\"\""
        ")"
    Alias ="G_Line_price_Override"
    Expression ="IIf([PRICE]=0 Or [VPA] Not In (\"123DNST\",\"DENCORP\"),1,\"\")"
    Alias ="H_Customer_PO"
    Expression ="[flex_po_prefix] & [flex_order_header]![ORDERNO] & \"_\" & [flex_order_header]!["
        "ACCOUNT]"
    Alias ="I_Refer_order"
    Expression ="flex_order_header.ORDERNO"
    Alias ="J_Order_Taken_By"
    Expression ="flex_batch_template.OrderTakenBy"
    Alias ="K_Ordered_By"
    Expression ="flex_batch_template.OrderTakenBy"
    Alias ="L_Refer_Order"
    Expression ="flex_batch_template.refer_order"
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
        dbText "Name" ="B_Document_Type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="H_Customer_PO"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="E_Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="J_Order_Taken_By"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="G_Line_price_Override"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="C_Item_number"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="L_Refer_Order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="D_Line_Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="F_Unit_Price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="I_Refer_order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="K_Ordered_By"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1312
    Bottom =918
    Left =-1
    Top =-1
    Right =1296
    Bottom =441
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
        Left =660
        Top =0
        Right =999
        Bottom =207
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
    Begin
        Left =599
        Top =190
        Right =743
        Bottom =334
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
