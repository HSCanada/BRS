Operation =1
Option =0
Having ="(((BRS_Item.SubMajorProdClass) In (\"800-04\",\"800-05\",\"800-06\",'800-08')) A"
    "ND ((BRS_ItemCategory.CategoryRollup)=\"EQUPKG\") AND ((BRS_Item.comm_group_cd) "
    "Not In (\"ITMEQ0\",\"ITMPAR\")) AND ((BRS_Item.Supplier) Not In (\"SIRONC\",\"TR"
    "IAFS\",\"PELCRA\")))"
Begin InputTables
    Name ="BRS_ItemCategory"
    Name ="BRS_Item"
    Name ="BRS_ItemSupplier"
    Name ="BRS_ItemSupplierFamily"
End
Begin OutputColumns
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_ItemSupplier.SupplierFamily"
    Expression ="BRS_ItemSupplierFamily.buying_group_cd"
    Alias ="SumOfEst12MoSales"
    Expression ="Sum(BRS_Item.Est12MoSales)"
    Alias ="CountOfItem"
    Expression ="Count(BRS_Item.Item)"
End
Begin Joins
    LeftTable ="BRS_ItemCategory"
    RightTable ="BRS_Item"
    Expression ="BRS_ItemCategory.MinorProductClass = BRS_Item.MinorProductClass"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemSupplier"
    Expression ="BRS_Item.Supplier = BRS_ItemSupplier.Supplier"
    Flag =1
    LeftTable ="BRS_ItemSupplier"
    RightTable ="BRS_ItemSupplierFamily"
    Expression ="BRS_ItemSupplier.SupplierFamily = BRS_ItemSupplierFamily.SupplierFamily"
    Flag =1
End
Begin Groups
    Expression ="BRS_Item.SubMajorProdClass"
    GroupLevel =0
    Expression ="BRS_ItemCategory.CategoryRollup"
    GroupLevel =0
    Expression ="BRS_Item.comm_group_cd"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
    Expression ="BRS_ItemSupplier.SupplierFamily"
    GroupLevel =0
    Expression ="BRS_ItemSupplierFamily.buying_group_cd"
    GroupLevel =0
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
dbMemo "OrderBy" ="[zqryESSModel2021-3-TREATMENT].[Supplier], [zqryESSModel2021-3-TREATMENT].[SumOf"
    "Est12MoSales] DESC, [zqryESSModel2021-3-TREATMENT].[buying_group_cd] DESC, [zqry"
    "ESSModel2021-3-TREATMENT].[SupplierFamily] DESC"
dbMemo "Filter" ="([zqryESSModel2021-3-TREATMENT].[SupplierFamily]=\"PELTON\")"
Begin
    Begin
        dbText "Name" ="CountOfItem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfEst12MoSales"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.SupplierFamily"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplierFamily.buying_group_cd"
        dbInteger "ColumnWidth" ="2010"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1308
    Bottom =946
    Left =-1
    Top =-1
    Right =1284
    Bottom =331
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =818
        Top =213
        Right =1164
        Bottom =614
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
    Begin
        Left =43
        Top =52
        Right =249
        Bottom =380
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =352
        Top =32
        Right =496
        Bottom =176
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =567
        Top =16
        Right =866
        Bottom =160
        Top =0
        Name ="BRS_ItemSupplierFamily"
        Name =""
    End
End
