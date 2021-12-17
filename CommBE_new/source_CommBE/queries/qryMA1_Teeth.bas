Operation =1
Option =0
Where ="(((BRS_Item.SalesCategory)=\"TEETH\") AND ((BRS_Item.ItemStatus)<>\"P\") AND ((B"
    "RS_Item.MajorProductClass)<>\"904\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.ItemStatus"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.FreightAdjPct"
    Expression ="BRS_Item.CorporateMarketAdjustmentPct"
    Expression ="BRS_Item.Est12MoSales"
    Alias ="MA_new"
    Expression ="[FreightAdjPct]*[CorporateMarketAdjustmentPct]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryMA1_Teeth].[Est12MoSales] DESC"
Begin
    Begin
        dbText "Name" ="MA_new"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.CorporateMarketAdjustmentPct"
        dbInteger "ColumnWidth" ="3390"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FreightAdjPct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemStatus"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3210"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1519
    Bottom =946
    Left =-1
    Top =-1
    Right =1341
    Bottom =489
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =67
        Top =22
        Right =432
        Bottom =402
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
