﻿Operation =1
Option =0
Begin InputTables
    Name ="zItem_model_20200627-out"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="BRS_ItemCategory.MinorProductClass"
    Expression ="[zItem_model_20200627-out].Supplier"
    Expression ="[zItem_model_20200627-out].comm_group_cd_baseline"
End
Begin Joins
    LeftTable ="BRS_ItemCategory"
    RightTable ="zItem_model_20200627-out"
    Expression ="BRS_ItemCategory.submajor_cd = [zItem_model_20200627-out].SubMajorProdClass"
    Flag =1
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
        dbText "Name" ="[zItem_model_20200627-out].comm_group_cd_baseline"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[zItem_model_20200627-out].Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.MinorProductClass"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =937
    Left =-1
    Top =-1
    Right =1388
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =95
        Top =37
        Right =239
        Bottom =181
        Top =0
        Name ="zItem_model_20200627-out"
        Name =""
    End
    Begin
        Left =334
        Top =136
        Right =478
        Bottom =280
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
