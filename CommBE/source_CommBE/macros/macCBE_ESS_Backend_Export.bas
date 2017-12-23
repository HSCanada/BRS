Version =196611
ColumnsShown =0
Begin
    Action ="TransferSpreadsheet"
    Comment ="ESS_Backend"
    Argument ="1"
    Argument ="10"
    Argument ="ESS_Backend"
    Argument ="S:\\Business Reporting\\CommBE\\Publish\\ESS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Comment ="ESS_Backend_Monthly"
End
Begin
    Action ="TransferSpreadsheet"
    Comment ="ESS_Backend_FreeGoods"
    Argument ="1"
    Argument ="10"
    Argument ="ESS_Backend_FreeGoods"
    Argument ="S:\\Business Reporting\\CommBE\\Publish\\ESS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="CCS_Backend"
    Argument ="S:\\Business Reporting\\CommBE\\Publish\\CCS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="MsgBox"
    Argument ="ESS backend exported to \"S:\\Business Reporting\\CommBE\\Publish\\ESS_Backend Y"
        "YYYMM.xlsx\""
    Argument ="-1"
    Argument ="0"
End
Begin
    Comment ="_AXL:<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\"?>\015\012<UserI"
        "nterfaceMacro MinimumClientDesignVersion=\"14.0.0000.0000\" xmlns=\"http://schem"
        "as.microsoft.com/office/accessservices/2009/11/application\"><Statements><Commen"
        "t>ESS_Backend</Comment><Actio"
End
Begin
    Comment ="_AXL:n Name=\"ImportExportSpreadsheet\"><Argument Name=\"TransferType\">Export</"
        "Argument><Argument Name=\"TableName\">ESS_Backend</Argument><Argument Name=\"Fil"
        "eName\">S:\\Business Reporting\\CommBE\\Publish\\ESS_Backend YYYYMM.xlsx</Argume"
        "nt><Argument Name=\"HasFie"
End
Begin
    Comment ="_AXL:ldNames\">Yes</Argument></Action><Comment>ESS_Backend_Monthly</Comment><Com"
        "ment></Comment><Comment>ESS_Backend_FreeGoods</Comment><Action Name=\"ImportExpo"
        "rtSpreadsheet\"><Argument Name=\"TransferType\">Export</Argument><Argument Name="
        "\"TableName\">ESS_Ba"
End
Begin
    Comment ="_AXL:ckend_FreeGoods</Argument><Argument Name=\"FileName\">S:\\Business Reportin"
        "g\\CommBE\\Publish\\ESS_Backend YYYYMM.xlsx</Argument><Argument Name=\"HasFieldN"
        "ames\">Yes</Argument></Action><Action Name=\"ImportExportSpreadsheet\"><Argument"
        " Name=\"TransferType\">Ex"
End
Begin
    Comment ="_AXL:port</Argument><Argument Name=\"TableName\">CCS_Backend</Argument><Argument"
        " Name=\"FileName\">S:\\Business Reporting\\CommBE\\Publish\\CCS_Backend YYYYMM.x"
        "lsx</Argument><Argument Name=\"HasFieldNames\">Yes</Argument></Action><Comment><"
        "/Comment><Action Name=\""
End
Begin
    Comment ="_AXL:MessageBox\"><Argument Name=\"Message\">ESS backend exported to \"S:\\Busin"
        "ess Reporting\\CommBE\\Publish\\ESS_Backend YYYYMM.xlsx\"</Argument></Action></S"
        "tatements></UserInterfaceMacro>"
End
