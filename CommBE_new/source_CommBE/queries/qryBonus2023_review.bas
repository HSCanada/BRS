Operation =1
Option =0
Where ="(((BRS_ItemCategory.CategoryRollup) In (\"D4DMLB\",\"CERMER\",\"D4DMER\",\"LABPR"
    "D\")))"
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemSupplier"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_ItemSupplier.SupplierFamily"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_bonus1_cd"
    Expression ="BRS_Item.comm_bonus2_cd"
    Expression ="BRS_Item.comm_bonus3_cd"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemSupplier"
    Expression ="BRS_Item.Supplier = BRS_ItemSupplier.Supplier"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemCategory"
    Expression ="BRS_Item.MinorProductClass = BRS_ItemCategory.MinorProductClass"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "Filter" ="([qryBonus2023_review].[comm_group_cd]=\"DIGMAT\")"
dbMemo "OrderBy" ="[qryBonus2023_review].[comm_bonus1_cd], [qryBonus2023_review].[comm_group_cd], ["
    "qryBonus2023_review].[CategoryRollup]"
Begin
    Begin
        dbText "Name" ="BRS_Item.comm_bonus3_cd"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_bonus2_cd"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_bonus1_cd"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.SupplierFamily"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1515
    Bottom =946
    Left =-1
    Top =-1
    Right =1491
    Bottom =375
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =69
        Top =49
        Right =508
        Bottom =397
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =706
        Top =21
        Right =962
        Bottom =236
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =641
        Top =261
        Right =785
        Bottom =405
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
