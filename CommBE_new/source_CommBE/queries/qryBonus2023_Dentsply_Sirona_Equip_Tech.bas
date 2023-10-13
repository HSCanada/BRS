Operation =4
Option =0
Where ="(((BRS_Item.comm_bonus1_cd) Is Null) AND ((BRS_ItemSupplier.SupplierFamily)=\"SI"
    "RONG\") AND ((BRS_Item.comm_group_cd) Like \"ITMFO*\")) OR (((BRS_Item.comm_bonu"
    "s1_cd) Is Null) AND ((BRS_ItemSupplier.SupplierFamily)=\"REDLCA\") AND ((BRS_Ite"
    "m.comm_group_cd) Like \"ITMFO*\"))"
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemSupplier"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Name ="BRS_Item.comm_bonus1_cd"
    Expression ="\"Dentsply_Sirona_Equip_Tech\""
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
Begin
    Begin
        dbText "Name" ="BRS_Item.comm_bonus3_cd"
        dbInteger "ColumnWidth" ="2085"
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
        dbInteger "ColumnWidth" ="2085"
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
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.SupplierFamily"
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
    Right =1245
    Bottom =946
    Left =-1
    Top =-1
    Right =1221
    Bottom =392
    Left =0
    Top =0
    ColumnsShown =579
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
        Left =571
        Top =8
        Right =715
        Bottom =152
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =582
        Top =183
        Right =886
        Bottom =444
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
