Operation =1
Option =0
Where ="(((BRS_Customer.VPA) In (\"ALT01\",\"ALT02\",\"ALT03\",\"ALT04\",\"CHAU01\",\"DE"
    "N18CO\",\"DEN25EX\",\"DENCORP\",\"DENFINE\",\"DENUOFT\",\"GUP01\",\"HSK01\",\"LA"
    "B16EX\",\"MEDIX01\",\"PBWORKS\",\"RAJ01\",\"RID01\",\"SARHAN01\",\"SHIVJI\",\"SI"
    "ERRA01\",\"SMALIN12\",\"SMKING12\",\"DAVEORTH\",\"HERE01\",\"APPLWAY\",\"RYKISS\""
    ",\"KHAN001\",\"JAFFER01\",\"TRILLIUM\",\"OXFORD\",\"SHERGHIN\",\"DRROBERT\",\"DR"
    "CHUN\",\"20CHAHAL\",\"ALBERTA\",\"UBC101\",\"VCC101\",\"CAMOSUNC\",\"ALT05\",\"S"
    "MDBRUSH\",\"MEISELS1\",\"WORKCTR1\",\"GILL01\",\"BACHAN01\",\"TRILL01\",\"MELVER"
    "N\",\"FILICE\",\"HUSSIAN\",\"CDSC\",\"BUTTAR01\",\" LEBOEUF\",\"WOOPON\",\"LEGEN"
    "DS\",\"ANTOSH\",\"LNEWTON\",\"SARHAN01\",\"SARHAN02\",\"SWAIDA01\",\"TEETHFRS\")"
    ")) OR (((BRS_Customer.MarketClass) In (\"ELITE\",\"INSTIT\",\"MIDMKT\")) AND ((B"
    "RS_FSC_Rollup.FSCRollup)=\"WZ124\")) OR (((BRS_FSC_Rollup.TerritoryCd)=\"QZ1X2\""
    ")) OR (((BRS_Customer.BillTo) In (1663045,3185276,1765054))) OR (((BRS_Customer."
    "Specialty)<>\"STUD\") AND ((BRS_Customer.CustGrpWrk) In (\"Trillium College\",\""
    "Trillium Group\",\"Southern Alberta Institure of Technology\")))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="BRS_Customer.BillTo"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.Est12MoMerch"
    Expression ="comm_customer_master.creation_dt"
    Expression ="BRS_Customer.Specialty"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_customer_master.SPM_EQOptOut"
    Expression ="comm_customer_master.SPM_ReasonTxt"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.VPA"
    Expression ="BRS_Customer.CustGrpWrk"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.FSCRollup"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
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
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="-1"
dbMemo "OrderBy" ="[CBE05B_Customer_UpdateVPA].[SPM_StatusCd]"
Begin
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.creation_dt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Medium Date"
    End
    Begin
        dbText "Name" ="BRS_Customer.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3255"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrk"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4080"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
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
    Right =1434
    Bottom =672
    Left =-1
    Top =-1
    Right =1545
    Bottom =-1
    Left =1580
    Top =0
    ColumnsShown =539
    Begin
        Left =-1473
        Top =6
        Right =-1159
        Bottom =265
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =-1099
        Top =20
        Right =-955
        Bottom =164
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =-885
        Top =12
        Right =-667
        Bottom =280
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
