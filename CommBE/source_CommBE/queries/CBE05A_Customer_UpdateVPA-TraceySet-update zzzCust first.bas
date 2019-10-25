Operation =4
Option =0
Where ="(((comm_customer_master.SPM_StatusCd)<>[note_txt] Or (comm_customer_master.SPM_S"
    "tatusCd) Is Null)) OR (((comm_customer_master.SPM_EQOptOut)<>[note2_txt] Or (com"
    "m_customer_master.SPM_EQOptOut) Is Null))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Customer"
    Name ="zzzCustList"
End
Begin OutputColumns
    Name ="comm_customer_master.SPM_StatusCd"
    Expression ="Trim([note_txt])"
    Name ="comm_customer_master.SPM_EQOptOut"
    Expression ="Trim([note2_txt])"
End
Begin Joins
    LeftTable ="comm_customer_master"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_customer_master.salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="comm_customer_master"
    RightTable ="BRS_Customer"
    Expression ="comm_customer_master.hsi_shipto_id = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="zzzCustList"
    RightTable ="comm_customer_master"
    Expression ="zzzCustList.hsi_customer_id = comm_customer_master.hsi_shipto_id"
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
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_ReasonTxt"
        dbInteger "ColumnWidth" ="4650"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1534
    Bottom =865
    Left =-1
    Top =-1
    Right =1510
    Bottom =139
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =267
        Top =25
        Right =581
        Bottom =284
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =690
        Top =58
        Right =834
        Bottom =202
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =893
        Top =9
        Right =1111
        Bottom =277
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =17
        Top =76
        Right =161
        Bottom =220
        Top =0
        Name ="zzzCustList"
        Name =""
    End
End
