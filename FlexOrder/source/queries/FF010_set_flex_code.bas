Operation =4
Option =0
Where ="(((Integration_flex_order_lines_Staging.order_file_name) Like [flex_import_prefi"
    "x] & \"*\"))"
Begin InputTables
    Name ="Integration_flex_order_lines_Staging"
    Name ="flex_batch_template"
End
Begin OutputColumns
    Name ="Integration_flex_order_lines_Staging.flex_code"
    Expression ="[flex_batch_template]![flex_code]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.QTY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ITEMNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ITEMDESC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.UPC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.PRICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.FREEGDS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.DUEDATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.REF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_batch_template.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GSP_Integration_flex_order_lines_Staging.PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.order_file_name"
        dbInteger "ColumnWidth" ="2820"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_batch_template.flex_import_prefix"
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
    Bottom =672
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =157
        Top =157
        Right =301
        Bottom =301
        Top =0
        Name ="Integration_flex_order_lines_Staging"
        Name =""
    End
    Begin
        Left =391
        Top =157
        Right =792
        Bottom =492
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
End
