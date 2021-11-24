Operation =3
Name ="fg_deal"
Option =0
Where ="(((Redemptions_tbl_Main.RecID)>0) AND ((fg_deal.deal_id) Is Null))"
Begin InputTables
    Name ="Redemptions_tbl_Main"
    Name ="fg_deal"
End
Begin OutputColumns
    Name ="deal_id"
    Expression ="Redemptions_tbl_Main.RecID"
    Name ="SalesDivision"
    Expression ="Redemptions_tbl_Main.Div"
    Alias ="Expr1"
    Name ="Supplier"
    Expression ="\"\""
    Name ="supplier_nmOrg"
    Expression ="Redemptions_tbl_Main.VendorName"
    Name ="BuyOrg"
    Expression ="Redemptions_tbl_Main.Buy"
    Name ="GetOrg"
    Expression ="Redemptions_tbl_Main.Get"
    Name ="RedeemOrg"
    Expression ="Redemptions_tbl_Main.Redeem"
    Name ="QuarterOrg"
    Expression ="Redemptions_tbl_Main.Quarter"
    Alias ="Expr3"
    Name ="SummaryOrg"
    Expression ="\"\""
    Name ="NoteOrg"
    Expression ="Redemptions_tbl_Main.Note"
    Name ="EffDate"
    Expression ="Redemptions_tbl_Main.EffDate"
    Name ="Expired"
    Expression ="Redemptions_tbl_Main.Expired"
    Alias ="Expr2"
    Name ="auto_add_ind"
    Expression ="0"
End
Begin Joins
    LeftTable ="Redemptions_tbl_Main"
    RightTable ="fg_deal"
    Expression ="Redemptions_tbl_Main.RecID = fg_deal.deal_id"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Expired"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Div"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.RecID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.VendorName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Get"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Buy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Quarter"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Redeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.EffDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Redemptions_tbl_Main.RedeemDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_deal.deal_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1489
    Bottom =918
    Left =-1
    Top =-1
    Right =1473
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =130
        Top =172
        Right =502
        Bottom =523
        Top =0
        Name ="Redemptions_tbl_Main"
        Name =""
    End
    Begin
        Left =689
        Top =165
        Right =833
        Bottom =309
        Top =0
        Name ="fg_deal"
        Name =""
    End
End
