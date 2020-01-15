Operation =1
Option =0
Where ="(((BRS_CustomerFSC_History.FiscalMonth)=(SELECT [PriorFiscalMonth] FROM [comm_co"
    "nfig])) AND ((BRS_CustomerFSC_History.HIST_cust_comm_group_cd)<>[Note]))"
Begin InputTables
    Name ="zzzShipto"
    Name ="BRS_CustomerFSC_History"
End
Begin OutputColumns
    Expression ="BRS_CustomerFSC_History.Shipto"
    Expression ="BRS_CustomerFSC_History.FiscalMonth"
    Alias ="cust_group"
    Expression ="Trim([Note])"
    Expression ="BRS_CustomerFSC_History.HIST_cust_comm_group_cd"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_CustomerFSC_History"
    Expression ="zzzShipto.ST = BRS_CustomerFSC_History.Shipto"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cust_group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.Shipto"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =330
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =84
        Top =34
        Right =228
        Bottom =178
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =349
        Top =11
        Right =493
        Bottom =155
        Top =0
        Name ="BRS_CustomerFSC_History"
        Name =""
    End
End
