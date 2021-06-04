Operation =1
Option =0
Where ="(((Abs([UnitChargeback]-CDbl([Note1])))>0.02) AND ((BRS_Item.Est12MoSales)>=1004"
    "473.39)) OR (((Abs([UnitChargeback]-CDbl([Note1])))>10))"
Begin InputTables
    Name ="zzzItem"
    Name ="Pricing_item_price_dcc"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="Pricing_item_price_dcc.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="Pricing_item_price_dcc.UnitChargeback"
    Alias ="UnitChargebackDW"
    Expression ="CDbl([Note1])"
    Alias ="diff"
    Expression ="Abs([UnitChargeback]-CDbl([Note1]))"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="zzzItem"
    RightTable ="Pricing_item_price_dcc"
    Expression ="zzzItem.Item = Pricing_item_price_dcc.Item"
    Flag =1
    LeftTable ="Pricing_item_price_dcc"
    RightTable ="BRS_Item"
    Expression ="Pricing_item_price_dcc.Item = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[Est12MoSales] DESC"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.UnitChargeback"
        dbInteger "ColumnWidth" ="1875"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Pricing_item_price_dcc.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="UnitChargebackDW"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="diff"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1518
    Bottom =918
    Left =-1
    Top =-1
    Right =618
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =52
        Top =135
        Right =196
        Bottom =279
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =244
        Top =146
        Right =388
        Bottom =290
        Top =0
        Name ="Pricing_item_price_dcc"
        Name =""
    End
    Begin
        Left =470
        Top =147
        Right =752
        Bottom =475
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
