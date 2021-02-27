Operation =1
Option =0
Having ="(((BRS_Item.SubMajorProdClass) In (\"800-04\",\"800-05\",\"800-06\",'800-08')) A"
    "ND ((BRS_Item.comm_group_cd) Not In (\"ITMEQ0\",\"ITMPAR\")) AND ((BRS_Item.Supp"
    "lier) In (\"SIRONC\",\"TRIAFS\",\"PELCRA\")))"
Begin InputTables
    Name ="BRS_ItemCategory"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.Supplier"
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
dbMemo "OrderBy" ="[qryESSModel2021-3-TREATMENT].[SumOfEst12MoSales] DESC"
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
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1492
    Bottom =756
    Left =-1
    Top =-1
    Right =1468
    Bottom =348
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =534
        Top =59
        Right =880
        Bottom =460
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
    Begin
        Left =246
        Top =75
        Right =452
        Bottom =403
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
