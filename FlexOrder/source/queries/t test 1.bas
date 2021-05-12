Operation =1
Option =0
Where ="(((flex_order_header.ORDERNO)=\"3000123628\"))"
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_order_detail"
    Name ="flex_order_file"
End
Begin OutputColumns
    Expression ="flex_order_file.order_file_name"
    Expression ="flex_order_detail.*"
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
        dbText "Name" ="flex_order_header.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.order_file_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.batch_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.FREEGDS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.DUEDATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.batch_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.REF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.order_file_name"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ITEMDESC"
        dbInteger "ColumnWidth" ="3345"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.UPC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ITEMNO"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.PRICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.QTY"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =868
    Bottom =842
    Left =-1
    Top =-1
    Right =1322
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =404
        Top =114
        Right =548
        Bottom =556
        Top =0
        Name ="flex_order_header"
        Name =""
    End
    Begin
        Left =671
        Top =131
        Right =815
        Bottom =275
        Top =0
        Name ="flex_order_detail"
        Name =""
    End
    Begin
        Left =52
        Top =115
        Right =196
        Bottom =259
        Top =0
        Name ="flex_order_file"
        Name =""
    End
End
