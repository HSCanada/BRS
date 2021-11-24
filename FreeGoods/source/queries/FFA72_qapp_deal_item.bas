dbMemo "SQL" ="INSERT INTO fg_deal_item ( CalMonthRedeem, item, deal_id, FamilySetLeader, deal_"
    "source_cd )\015\012SELECT BRS_Config.PriorFiscalMonth, Redemptions_tbl_Items.Ite"
    "mNumber, Redemptions_tbl_Items.RecID, BRS_Item.FamilySetLeader, \"SSD\" AS Expr1"
    "\015\012FROM BRS_Config, Redemptions_tbl_Items INNER JOIN BRS_Item ON Redemption"
    "s_tbl_Items.ItemNumber = BRS_Item.Item;\015\012"
dbMemo "Connect" =""
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
