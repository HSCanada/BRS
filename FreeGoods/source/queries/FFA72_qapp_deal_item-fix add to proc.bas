Operation =3
Name ="fg_deal_item"
Option =0
Begin InputTables
    Name ="BRS_Config"
    Name ="Redemptions_tbl_Items"
    Name ="BRS_Item"
End
Begin OutputColumns
    Name ="CalMonthRedeem"
    Expression ="BRS_Config.PriorFiscalMonth"
    Name ="item"
    Expression ="Redemptions_tbl_Items.ItemNumber"
    Name ="deal_id"
    Expression ="Redemptions_tbl_Items.RecID"
    Name ="FamilySetLeader"
    Expression ="BRS_Item.FamilySetLeader"
    Alias ="Expr1"
    Name ="deal_source_cd"
    Expression ="\"SSD\""
End
Begin Joins
    LeftTable ="Redemptions_tbl_Items"
    RightTable ="BRS_Item"
    Expression ="Redemptions_tbl_Items.ItemNumber = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
Begin
    Begin
        dbText "Name" ="BRS_Config.PriorFiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.FamilySetLeader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Items.RecID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Items.ItemNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1312
    Bottom =918
    Left =-1
    Top =-1
    Right =1296
    Bottom =282
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="BRS_Config"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="Redemptions_tbl_Items"
        Name =""
    End
    Begin
        Left =432
        Top =12
        Right =576
        Bottom =156
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
