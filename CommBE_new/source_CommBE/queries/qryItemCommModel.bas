Operation =1
Option =0
Begin InputTables
    Name ="subItemCommModel"
    Name ="BRS_ItemSupplier"
    Name ="comm_item_group_rule"
End
Begin OutputColumns
    Expression ="subItemCommModel.SalesCategory"
    Expression ="subItemCommModel.Supplier"
    Expression ="BRS_ItemSupplier.supplier_nm"
    Expression ="subItemCommModel.major_cd"
    Expression ="subItemCommModel.major_desc"
    Expression ="subItemCommModel.SubMajorProdClass"
    Expression ="subItemCommModel.submajor_desc"
    Expression ="subItemCommModel.CategoryRollup"
    Expression ="subItemCommModel.comm_group_cd"
    Expression ="subItemCommModel.Est12MoSales"
    Expression ="subItemCommModel.item_count"
    Alias ="rule_comm_group_cd"
    Expression ="comm_item_group_rule.comm_group_cd"
    Alias ="rule_confidence_rt"
    Expression ="comm_item_group_rule.confidence_rt"
    Alias ="rule_comm_note_txt"
    Expression ="comm_item_group_rule.comm_note_txt"
    Alias ="rule_id"
    Expression ="comm_item_group_rule.id"
End
Begin Joins
    LeftTable ="subItemCommModel"
    RightTable ="BRS_ItemSupplier"
    Expression ="subItemCommModel.Supplier = BRS_ItemSupplier.Supplier"
    Flag =1
    LeftTable ="subItemCommModel"
    RightTable ="BRS_ItemSupplier"
    Expression ="subItemCommModel.Supplier = BRS_ItemSupplier.Supplier"
    Flag =1
    LeftTable ="subItemCommModel"
    RightTable ="comm_item_group_rule"
    Expression ="subItemCommModel.MinorProductClass = comm_item_group_rule.MinorProductClass"
    Flag =2
    LeftTable ="subItemCommModel"
    RightTable ="comm_item_group_rule"
    Expression ="subItemCommModel.Supplier = comm_item_group_rule.Supplier"
    Flag =2
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
Begin
    Begin
        dbText "Name" ="BRS_ItemSupplier.supplier_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.item_count"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.major_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.major_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.submajor_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="subItemCommModel.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="rule_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="rule_comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="rule_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="rule_confidence_rt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1625
    Bottom =946
    Left =-1
    Top =-1
    Right =1601
    Bottom =601
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =108
        Top =66
        Right =449
        Bottom =397
        Top =0
        Name ="subItemCommModel"
        Name =""
    End
    Begin
        Left =597
        Top =249
        Right =741
        Bottom =393
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =743
        Top =87
        Right =1031
        Bottom =314
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
End
