Operation =1
Option =0
Where ="(((comm_group.comm_group_cd) In (\"ITMFO1\",\"ITMFO2\",\"ITMFO3\",\"ITMFRT\",\"I"
    "TMISC\",\"ITMCPU\",\"ITMSOF\",\"ITMMID\")))"
Begin InputTables
    Name ="comm_group"
    Name ="zzcomm_group_report"
End
Begin OutputColumns
    Expression ="comm_group.comm_group_cd"
    Expression ="comm_group.comm_group_desc"
    Expression ="[zzcomm_group_report].report_sort_id"
End
Begin Joins
    LeftTable ="comm_group"
    RightTable ="zzcomm_group_report"
    Expression ="comm_group.report_group_1_cd=[zzcomm_group_report].report_group_1_cd"
    Flag =1
    LeftTable ="comm_group"
    RightTable ="zzcomm_group_report"
    Expression ="comm_group.report_group_2_cd=[zzcomm_group_report].report_group_2_cd"
    Flag =1
    LeftTable ="comm_group"
    RightTable ="zzcomm_group_report"
    Expression ="comm_group.report_group_3_cd=[zzcomm_group_report].report_group_3_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qsubCommESSStatementDetailReportSummary].[report_sort_id]"
Begin
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3900"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_group_report.report_sort_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1289
    Bottom =977
    Left =-1
    Top =-1
    Right =1273
    Bottom =549
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_group"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="comm_group_report"
        Name =""
    End
End
