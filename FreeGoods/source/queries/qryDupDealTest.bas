Operation =1
Option =0
Where ="(((fgprod_tbl_Main.RecID)<>21018) AND ((fgprod_tbl_Main.EffDate)<#8/15/2022#) AN"
    "D ((fgprod_tbl_Main.Expired)>=#8/15/2022#))"
Begin InputTables
    Name ="fgprod_tbl_Main"
    Name ="fgprod_tbl_Items"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="fgprod_tbl_Items.ItemID"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="fgprod_tbl_Main.RecID"
    Expression ="fgprod_tbl_Main.Buy"
    Expression ="fgprod_tbl_Main.Get"
    Expression ="fgprod_tbl_Main.Redeem"
    Expression ="fgprod_tbl_Main.BQ"
    Expression ="fgprod_tbl_Main.GQ"
    Expression ="fgprod_tbl_Main.EffDate"
    Expression ="fgprod_tbl_Main.Expired"
End
Begin Joins
    LeftTable ="fgprod_tbl_Main"
    RightTable ="fgprod_tbl_Items"
    Expression ="fgprod_tbl_Main.RecID = fgprod_tbl_Items.RecID"
    Flag =1
    LeftTable ="fgprod_tbl_Items"
    RightTable ="BRS_Item"
    Expression ="fgprod_tbl_Items.ItemNumber = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryDupDealTest].[ItemID]"
Begin
    Begin
        dbText "Name" ="fgprod_tbl_Main.Expired"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.EffDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.Redeem"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="11205"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.Get"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="6390"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.Buy"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="7005"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.RecID"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="945"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3240"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Items.ItemID"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.BQ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fgprod_tbl_Main.GQ"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1381
    Bottom =546
    Left =-1
    Top =-1
    Right =1095
    Bottom =301
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =73
        Top =36
        Right =217
        Bottom =180
        Top =0
        Name ="fgprod_tbl_Main"
        Name =""
    End
    Begin
        Left =270
        Top =62
        Right =414
        Bottom =206
        Top =0
        Name ="fgprod_tbl_Items"
        Name =""
    End
    Begin
        Left =454
        Top =17
        Right =598
        Bottom =161
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
