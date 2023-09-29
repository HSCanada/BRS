dbMemo "SQL" ="UPDATE [Item Master Export] INNER JOIN STAGE_BRS_ItemBaseHistory ON [Item Master"
    " Export].[HSI Item#] = STAGE_BRS_ItemBaseHistory.Item SET [Item Master Export].["
    "Currency] = [STAGE_BRS_ItemBaseHistory]![Currency], [Item Master Export].[Cost P"
    "rc Brk1] = [SupplierCost]\015\012WHERE (((Nz([Item Master Export]!Currency,\"CAD"
    "\"))<>STAGE_BRS_ItemBaseHistory!Currency) And ((STAGE_BRS_ItemBaseHistory.CalMon"
    "th)=0)) Or (((Nz([Item Master Export]![Cost Prc Brk1],0))<>[SupplierCost]) And ("
    "(STAGE_BRS_ItemBaseHistory.CalMonth)=0));\015\012"
dbMemo "Connect" =""
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
dbText "Description" ="tc"
Begin
    Begin
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="curr_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost__"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Nz([Item Master Export]![Currency],\"CAD\")"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CalMonth"
        dbLong "AggregateType" ="-1"
    End
End
