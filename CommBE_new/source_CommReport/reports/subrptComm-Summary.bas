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
    Width =10080
    DatasheetFontHeight =11
    ItemSuffix =169
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0x0a9c1d4f97a1e340
    End
    RecordSource ="qryCommStatementDetailReport-Summary-Final"
    Caption ="subrptComm-Summary"
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
            ControlSource ="sort_id"
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =480
            Name ="GroupHeader0"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    FontUnderline = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =60
                    Width =8520
                    Height =480
                    ColumnOrder =0
                    FontSize =14
                    FontWeight =700
                    ForeColor =11830108
                    Name ="Text222"
                    ControlSource ="=\"Sales Category Totals\""

                    LayoutCachedLeft =60
                    LayoutCachedWidth =8580
                    LayoutCachedHeight =480
                End
            End
        End
        Begin Section
            KeepTogether = NotDefault
            Height =360
            Name ="Detail"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Top =60
                    Width =1080
                    Height =300
                    FontSize =8
                    Name ="transaction_amt"
                    ControlSource ="total_transaction_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedTop =60
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =360
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Top =60
                    Width =1080
                    Height =300
                    FontSize =8
                    TabIndex =1
                    Name ="gp_ext_amt"
                    ControlSource ="total_gp_ext_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedTop =60
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =360
                End
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =1500
                    Top =60
                    Width =4260
                    Height =300
                    FontSize =12
                    FontWeight =700
                    TabIndex =2
                    Name ="Text230"
                    ControlSource ="comm_group_desc"

                    LayoutCachedLeft =1500
                    LayoutCachedTop =60
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =360
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Top =60
                    Width =1080
                    Height =300
                    FontSize =8
                    TabIndex =3
                    Name ="Text167"
                    ControlSource ="=IIf(([total_transaction_amt])<>0,([total_gp_ext_amt])/([total_transaction_amt])"
                        ",0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedTop =60
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =360
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =420
            Name ="GroupFooter4"
            Begin
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Top =60
                    Width =1080
                    Height =300
                    FontSize =8
                    FontWeight =700
                    Name ="Text154"
                    ControlSource ="=Sum([total_transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedTop =60
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =360
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7440
                    Top =60
                    Width =1065
                    Height =300
                    FontSize =8
                    FontWeight =700
                    TabIndex =1
                    Name ="Text155"
                    ControlSource ="=Sum([total_gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7440
                    LayoutCachedTop =60
                    LayoutCachedWidth =8505
                    LayoutCachedHeight =360
                End
                Begin Line
                    OldBorderStyle =1
                    Width =9660
                    BorderColor =0
                    Name ="Line229"
                    LayoutCachedWidth =9660
                End
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =60
                    Width =4260
                    Height =300
                    FontSize =12
                    FontWeight =700
                    TabIndex =2
                    Name ="Text166"
                    ControlSource ="=\"Total  ** \""

                    LayoutCachedLeft =60
                    LayoutCachedWidth =4320
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8580
                    Top =60
                    Width =1065
                    Height =300
                    FontSize =8
                    FontWeight =700
                    TabIndex =3
                    Name ="Text168"
                    ControlSource ="=IIf(Sum([total_transaction_amt])<>0,Sum([total_gp_ext_amt])/Sum([total_transact"
                        "ion_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8580
                    LayoutCachedTop =60
                    LayoutCachedWidth =9645
                    LayoutCachedHeight =360
                End
            End
        End
    End
End
CodeBehindForm
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
