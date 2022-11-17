Operation =1
Option =0
Where ="(((BRS_TransactionDW.CalMonth)>=202207) AND ((BRS_TransactionDW.OrderSourceCode)"
    " In (\"E\",\"H\",\"W\",\"T\")) AND ((BRS_TransactionDW.DocType) In (\"SL\",\"SO\""
    ",\"SE\")) AND ((BRS_TransactionDW.FreeGoodsInvoicedInd)=True))"
Begin InputTables
    Name ="BRS_TransactionDW"
    Name ="zzzItem"
End
Begin OutputColumns
    Expression ="BRS_TransactionDW.SalesOrderNumber"
    Expression ="BRS_TransactionDW.Item"
    Alias ="deal"
    Expression ="zzzItem.Note1"
    Alias ="deal_type"
    Expression ="zzzItem.Note2"
    Expression ="BRS_TransactionDW.NetSalesAmt"
    Expression ="BRS_TransactionDW.ShippedQty"
    Expression ="BRS_TransactionDW.FreeGoodsInvoicedInd"
    Expression ="BRS_TransactionDW.PromotionCode"
End
Begin Joins
    LeftTable ="BRS_TransactionDW"
    RightTable ="zzzItem"
    Expression ="BRS_TransactionDW.Item = zzzItem.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_TransactionDW.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.FreeGoodsInvoicedInd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.ShippedQty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.PromotionCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.OrderSourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1001"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfSalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qryFG_Template_Promo.deal_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="deal_type"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1555
    Bottom =918
    Left =-1
    Top =-1
    Right =1177
    Bottom =327
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =224
        Top =40
        Right =622
        Bottom =414
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =717
        Top =60
        Right =861
        Bottom =204
        Top =0
        Name ="zzzItem"
        Name =""
    End
End
