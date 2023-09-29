Operation =3
Name ="STAGE_BRS_ItemBaseHistory_"
Option =0
Begin InputTables
    Name ="STAGE_BRS_ItemBaseHistory"
End
Begin OutputColumns
    Name ="Item"
    Expression ="STAGE_BRS_ItemBaseHistory.Item"
    Name ="Supplier"
    Expression ="STAGE_BRS_ItemBaseHistory.Supplier"
    Name ="Currency"
    Expression ="STAGE_BRS_ItemBaseHistory.Currency"
    Name ="SupplierCost"
    Expression ="STAGE_BRS_ItemBaseHistory.SupplierCost"
    Name ="CorporatePrice"
    Expression ="STAGE_BRS_ItemBaseHistory.CorporatePrice"
    Name ="SellPrcBrk2"
    Expression ="STAGE_BRS_ItemBaseHistory.SellPrcBrk2"
    Name ="SellPrcBrk3"
    Expression ="STAGE_BRS_ItemBaseHistory.SellPrcBrk3"
    Name ="SellQtyBrk2"
    Expression ="STAGE_BRS_ItemBaseHistory.SellQtyBrk2"
    Name ="SellQtyBrk3"
    Expression ="STAGE_BRS_ItemBaseHistory.SellQtyBrk3"
End
Begin OrderBy
    Expression ="STAGE_BRS_ItemBaseHistory.Item"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbBoolean "UseTransaction" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellQtyBrk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.FamilySetLeader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CorporatePrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SupplierCost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellPrcBrk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellPrcBrk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellQtyBrk2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1494
    Bottom =818
    Left =-1
    Top =-1
    Right =1470
    Bottom =447
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =119
        Top =63
        Right =626
        Bottom =336
        Top =0
        Name ="STAGE_BRS_ItemBaseHistory"
        Name =""
    End
End
