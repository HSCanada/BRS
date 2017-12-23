Version =20
VersionRequired =20
Begin Report
    LayoutForPrint = NotDefault
    DividingLines = NotDefault
    AllowAdditions = NotDefault
    AllowDesignChanges = NotDefault
    DateGrouping =1
    GrpKeepTogether =1
    PictureAlignment =2
    DatasheetGridlinesBehavior =3
    GridX =24
    GridY =24
    Width =11415
    DatasheetFontHeight =11
    ItemSuffix =166
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0xb1976c2f75a3e340
    End
    RecordSource ="qryCommESSStatementDetailReport-Summary-Final"
    Caption ="subrptCommESS-Summary"
    DatasheetFontName ="Calibri"
    PrtMip = Begin
        0x68010000f000000068010000f000000000000000972c00002e01000001000000 ,
        0x010000006801000000000000a10700000100000001000000
    End
    FilterOnLoad =0
    FitToPage =1
    DisplayOnSharePointSite =1
    DatasheetAlternateBackColor =16053492
    DatasheetGridlinesColor12 =15062992
    FitToScreen =1
    Begin
        Begin Label
            BackStyle =0
            TextFontCharSet =161
            FontSize =9
            FontWeight =700
            BorderColor =5066944
            ForeColor =11830108
            FontName ="Calibri"
            GridlineColor =-2147483609
        End
        Begin Rectangle
            BorderLineStyle =0
            BackColor =5054976
            BorderColor =-2147483617
            GridlineColor =-2147483609
        End
        Begin Line
            OldBorderStyle =0
            BorderLineStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin Image
            BorderLineStyle =0
            SizeMode =3
            PictureAlignment =2
            BackColor =5054976
            BorderColor =-2147483617
            GridlineColor =-2147483609
        End
        Begin CommandButton
            TextFontCharSet =161
            FontSize =9
            FontWeight =400
            ForeColor =14919545
            FontName ="Calibri"
            GridlineColor =-2147483609
            BorderLineStyle =0
        End
        Begin OptionButton
            OldBorderStyle =0
            BorderLineStyle =0
            LabelX =230
            LabelY =-30
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin CheckBox
            BorderLineStyle =0
            LabelX =230
            LabelY =-30
            GridlineColor =-2147483609
        End
        Begin OptionGroup
            OldBorderStyle =0
            BorderLineStyle =0
            BorderColor =5066944
        End
        Begin BoundObjectFrame
            SizeMode =3
            OldBorderStyle =0
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin TextBox
            FELineBreak = NotDefault
            OldBorderStyle =0
            TextFontCharSet =161
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            AsianLineBreak =1
            GridlineColor =-2147483609
            ShowDatePicker =0
        End
        Begin ListBox
            TextFontCharSet =161
            OldBorderStyle =0
            BorderLineStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            GridlineColor =-2147483609
            AllowValueListEdits =1
            InheritValueList =1
        End
        Begin ComboBox
            OldBorderStyle =0
            TextFontCharSet =161
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            GridlineColor =-2147483609
            AllowValueListEdits =1
            InheritValueList =1
        End
        Begin Subform
            BorderLineStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin UnboundObjectFrame
            BackStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin CustomControl
            OldBorderStyle =1
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin ToggleButton
            TextFontCharSet =161
            FontSize =9
            FontWeight =400
            ForeColor =14919545
            FontName ="Calibri"
            GridlineColor =-2147483609
            BorderLineStyle =0
        End
        Begin Tab
            TextFontCharSet =161
            BackStyle =0
            FontSize =9
            FontName ="Calibri"
            BorderLineStyle =0
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="salesperson_key_id"
        End
        Begin BreakLevel
            ControlSource ="report_sort_id"
        End
        Begin FormHeader
            KeepTogether = NotDefault
            Height =0
            Name ="ReportHeader"
        End
        Begin PageHeader
            Height =0
            Name ="PageHeaderSection"
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =506
            Name ="GroupHeader0"
            AlternateBackColor =16777215
            Begin
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Top =60
                    Width =11415
                    BorderColor =0
                    Name ="Line111"
                    LayoutCachedTop =60
                    LayoutCachedWidth =11415
                    LayoutCachedHeight =60
                End
                Begin TextBox
                    FontItalic = NotDefault
                    IMESentenceMode =3
                    Left =60
                    Top =120
                    Width =4440
                    Height =270
                    FontSize =12
                    FontWeight =700
                    Name ="Text147"
                    ControlSource ="=\"ESS SALES CATEGORY TOTALS\""

                    LayoutCachedLeft =60
                    LayoutCachedTop =120
                    LayoutCachedWidth =4500
                    LayoutCachedHeight =390
                End
                Begin Line
                    OldBorderStyle =1
                    Top =420
                    Width =4500
                    BorderColor =0
                    Name ="Line149"
                    LayoutCachedTop =420
                    LayoutCachedWidth =4500
                    LayoutCachedHeight =420
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Left =11400
                    Top =60
                    Width =0
                    Height =446
                    BorderColor =0
                    Name ="Line150"
                    LayoutCachedLeft =11400
                    LayoutCachedTop =60
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =506
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    BorderWidth =2
                    Top =60
                    Width =0
                    Height =446
                    BorderColor =0
                    Name ="Line163"
                    LayoutCachedTop =60
                    LayoutCachedHeight =506
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =6240
                    Top =60
                    Width =1080
                    Height =420
                    FontSize =10
                    ForeColor =0
                    Name ="Label174"
                    Caption ="Sales $"
                    LayoutCachedLeft =6240
                    LayoutCachedTop =60
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =480
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =7380
                    Top =60
                    Width =1080
                    Height =420
                    FontSize =10
                    ForeColor =0
                    Name ="Label175"
                    Caption ="GP $"
                    LayoutCachedLeft =7380
                    LayoutCachedTop =60
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =480
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =8520
                    Top =60
                    Width =1080
                    Height =420
                    FontSize =10
                    ForeColor =0
                    Name ="Label211"
                    Caption ="GP %"
                    LayoutCachedLeft =8520
                    LayoutCachedTop =60
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =480
                End
            End
        End
        Begin Section
            KeepTogether = NotDefault
            Height =302
            Name ="Detail"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6239
                    Width =1080
                    Height =300
                    FontSize =8
                    Name ="transaction_amt"
                    ControlSource ="total_transaction_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6239
                    LayoutCachedWidth =7319
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1080
                    Height =300
                    FontSize =8
                    TabIndex =1
                    Name ="gp_ext_amt"
                    ControlSource ="total_gp_ext_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Width =3300
                    Height =270
                    FontSize =10
                    FontWeight =700
                    TabIndex =2
                    Name ="Text128"
                    ControlSource ="comm_group_desc"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =4380
                    LayoutCachedHeight =270
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    BorderWidth =2
                    Left =11400
                    Width =0
                    Height =299
                    BorderColor =0
                    Name ="Line145"
                    LayoutCachedLeft =11400
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =299
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Width =0
                    Height =302
                    BorderColor =0
                    Name ="Line146"
                    LayoutCachedHeight =302
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Width =1080
                    Height =300
                    FontSize =8
                    TabIndex =3
                    Name ="Text164"
                    ControlSource ="=IIf(([total_transaction_amt])<>0,([total_gp_ext_amt])/([total_transaction_amt])"
                        ",0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =300
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =720
            Name ="GroupFooter4"
            Begin
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =60
                    Top =60
                    Width =3540
                    Height =345
                    FontSize =12
                    FontWeight =700
                    Name ="Text152"
                    ControlSource ="=\"TOTAL \""

                    LayoutCachedLeft =60
                    LayoutCachedTop =60
                    LayoutCachedWidth =3600
                    LayoutCachedHeight =405
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6239
                    Width =1080
                    Height =300
                    FontSize =8
                    TabIndex =1
                    Name ="Text154"
                    ControlSource ="=Sum([total_transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6239
                    LayoutCachedWidth =7319
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1065
                    Height =300
                    FontSize =8
                    TabIndex =2
                    Name ="Text155"
                    ControlSource ="=Sum([total_gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8445
                    LayoutCachedHeight =300
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Width =0
                    Height =600
                    BorderColor =0
                    Name ="Line157"
                    LayoutCachedHeight =600
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    BorderWidth =2
                    Left =11400
                    Width =0
                    Height =600
                    BorderColor =0
                    Name ="Line158"
                    LayoutCachedLeft =11400
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =600
                End
                Begin Line
                    OldBorderStyle =1
                    Width =11340
                    BorderColor =0
                    Name ="Line159"
                    LayoutCachedWidth =11340
                End
                Begin Line
                    OldBorderStyle =1
                    Top =420
                    Width =11340
                    BorderColor =0
                    Name ="Line160"
                    LayoutCachedTop =420
                    LayoutCachedWidth =11340
                    LayoutCachedHeight =420
                End
                Begin Line
                    OldBorderStyle =1
                    Top =480
                    Width =11340
                    BorderColor =0
                    Name ="Line161"
                    LayoutCachedTop =480
                    LayoutCachedWidth =11340
                    LayoutCachedHeight =480
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Top =600
                    Width =11415
                    BorderColor =0
                    Name ="Line162"
                    LayoutCachedTop =600
                    LayoutCachedWidth =11415
                    LayoutCachedHeight =600
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Width =1065
                    Height =300
                    FontSize =8
                    TabIndex =3
                    Name ="Text165"
                    ControlSource ="=IIf(Sum([total_transaction_amt])<>0,Sum([total_gp_ext_amt])/Sum([total_transact"
                        "ion_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedWidth =9585
                    LayoutCachedHeight =300
                End
            End
        End
        Begin PageFooter
            Height =0
            Name ="PageFooterSection"
        End
        Begin FormFooter
            KeepTogether = NotDefault
            Height =0
            Name ="ReportFooter"
            AutoHeight =1
        End
    End
End
CodeBehindForm
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
