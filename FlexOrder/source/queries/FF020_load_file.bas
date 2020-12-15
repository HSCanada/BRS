Operation =3
Name ="flex_order_file"
Option =0
Begin InputTables
    Name ="Integration_flex_order_lines_Staging"
    Name ="flex_batch_template"
End
Begin OutputColumns
    Name ="order_file_name"
    Expression ="Integration_flex_order_lines_Staging.order_file_name"
    Name ="flex_code"
    Expression ="Integration_flex_order_lines_Staging.flex_code"
    Name ="Supplier"
    Expression ="flex_batch_template.Supplier"
End
Begin Joins
    LeftTable ="Integration_flex_order_lines_Staging"
    RightTable ="flex_batch_template"
    Expression ="Integration_flex_order_lines_Staging.flex_code = flex_batch_template.flex_code"
    Flag =1
End
Begin Groups
    Expression ="Integration_flex_order_lines_Staging.order_file_name"
    GroupLevel =0
    Expression ="Integration_flex_order_lines_Staging.flex_code"
    GroupLevel =0
    Expression ="flex_batch_template.Supplier"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="flex_batch_template.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.order_file_name"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOforder_file_name"
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
    ColumnsShown =655
    Begin
        Left =91
        Top =116
        Right =417
        Bottom =355
        Top =0
        Name ="Integration_flex_order_lines_Staging"
        Name =""
    End
    Begin
        Left =519
        Top =146
        Right =663
        Bottom =290
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
End
