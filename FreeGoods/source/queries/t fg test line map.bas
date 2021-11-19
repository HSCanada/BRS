Operation =1
Option =0
Where ="(((Integration_F5554240_fg_redeem_Staging.WKAC10_division_code)<>\"AZA\") AND (("
    "Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number) Is Null))"
Begin InputTables
    Name ="Integration_F5554240_fg_redeem_Staging"
End
Begin OutputColumns
    Expression ="Integration_F5554240_fg_redeem_Staging.order_file_name"
    Expression ="Integration_F5554240_fg_redeem_Staging.line_id"
    Expression ="Integration_F5554240_fg_redeem_Staging.CalMonth"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKAC10_division_code"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKLNTY_line_type"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKLITM_item_number"
    Expression ="Integration_F5554240_fg_redeem_Staging.WKECST_extended_cost"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[WKLNTY_line_type], [Query1].[WKDCTO_order_type], [Query1].[WKECST_exte"
    "nded_cost] DESC"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLITM_item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKAC10_division_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKLNTY_line_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_F5554240_fg_redeem_Staging.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1303
    Bottom =918
    Left =-1
    Top =-1
    Right =1287
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =64
        Top =77
        Right =441
        Bottom =636
        Top =0
        Name ="Integration_F5554240_fg_redeem_Staging"
        Name =""
    End
End
