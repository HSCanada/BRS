Version =21
VersionRequired =20
Begin Report
    LayoutForPrint = NotDefault
    DividingLines = NotDefault
    AllowDesignChanges = NotDefault
    DateGrouping =1
    GrpKeepTogether =1
    PictureAlignment =2
    DatasheetGridlinesBehavior =3
    GridX =24
    GridY =24
    Width =11520
    DatasheetFontHeight =11
    ItemSuffix =234
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0x5eed8a95f6f5e340
    End
    RecordSource ="qryCommESSStatementSummaryExport"
    Caption ="CommESSStatementDetailReport"
    DatasheetFontName ="Calibri"
    PrtMip = Begin
        0x6801000068010000680100006801000000000000002d00000e01000001000000 ,
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
            ControlSource ="branch_cd"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="ESS_nm"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            ControlSource ="FSC_nm"
        End
        Begin BreakLevel
            ControlSource ="customer_nm"
        End
        Begin BreakLevel
            ControlSource ="transaction_dt"
        End
        Begin FormHeader
            KeepTogether = NotDefault
            Height =0
            Name ="ReportHeader"
        End
        Begin PageHeader
            Height =1560
            Name ="PageHeaderSection"
            Begin
                Begin TextBox
                    Enabled = NotDefault
                    FontItalic = NotDefault
                    IMESentenceMode =3
                    Width =10740
                    Height =480
                    FontSize =14
                    FontWeight =700
                    Name ="Text153"
                    ControlSource ="=\"Branch ESS / CCS Commission Invoice List Sign-off\""

                    LayoutCachedWidth =10740
                    LayoutCachedHeight =480
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1140
                    Top =720
                    Width =4020
                    Height =270
                    TabIndex =1
                    Name ="Text156"
                    ControlSource ="branch_cd"

                    LayoutCachedLeft =1140
                    LayoutCachedTop =720
                    LayoutCachedWidth =5160
                    LayoutCachedHeight =990
                    Begin
                        Begin Label
                            Left =60
                            Top =720
                            Width =960
                            Height =270
                            FontSize =10
                            ForeColor =0
                            Name ="Label157"
                            Caption ="Branch"
                            LayoutCachedLeft =60
                            LayoutCachedTop =720
                            LayoutCachedWidth =1020
                            LayoutCachedHeight =990
                        End
                    End
                End
                Begin Rectangle
                    BackStyle =0
                    Top =600
                    Width =11460
                    Height =960
                    Name ="Box160"
                    LayoutCachedTop =600
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =1560
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1140
                    Top =1110
                    Width =4020
                    Height =270
                    TabIndex =2
                    Name ="Text213"
                    ControlSource ="=[fiscal_begin_dt] & \" - \" & [fiscal_end_dt]"

                    LayoutCachedLeft =1140
                    LayoutCachedTop =1110
                    LayoutCachedWidth =5160
                    LayoutCachedHeight =1380
                    Begin
                        Begin Label
                            Left =60
                            Top =1110
                            Width =1080
                            Height =270
                            FontSize =10
                            ForeColor =0
                            Name ="Label214"
                            Caption ="Month"
                            LayoutCachedLeft =60
                            LayoutCachedTop =1110
                            LayoutCachedWidth =1140
                            LayoutCachedHeight =1380
                        End
                    End
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            RepeatSection = NotDefault
            Height =660
            Name ="GroupHeader0"
            AlternateBackColor =11450043
            Begin
                Begin Rectangle
                    OldBorderStyle =0
                    Width =11460
                    Height =600
                    BackColor =12765388
                    Name ="Box134"
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =600
                End
                Begin Line
                    OldBorderStyle =1
                    Top =600
                    Width =11460
                    BorderColor =0
                    Name ="Line111"
                    LayoutCachedTop =600
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =600
                End
                Begin Label
                    TextAlign =3
                    Left =300
                    Top =60
                    Width =1020
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label169"
                    Caption ="Ship to #"
                    LayoutCachedLeft =300
                    LayoutCachedTop =60
                    LayoutCachedWidth =1320
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =1
                    Left =1440
                    Top =60
                    Width =1440
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label170"
                    Caption ="Customer Name"
                    LayoutCachedLeft =1440
                    LayoutCachedTop =60
                    LayoutCachedWidth =2880
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =4680
                    Top =60
                    Width =960
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label171"
                    Caption ="Order#"
                    LayoutCachedLeft =4680
                    LayoutCachedTop =60
                    LayoutCachedWidth =5640
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =5820
                    Top =60
                    Width =900
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label172"
                    Caption ="Invoice Date"
                    LayoutCachedLeft =5820
                    LayoutCachedTop =60
                    LayoutCachedWidth =6720
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =2940
                    Top =60
                    Width =1740
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label173"
                    Caption ="FSC Name"
                    LayoutCachedLeft =2940
                    LayoutCachedTop =60
                    LayoutCachedWidth =4680
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =3
                    Left =6900
                    Top =60
                    Width =1140
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label174"
                    Caption ="Invoice Amount"
                    LayoutCachedLeft =6900
                    LayoutCachedTop =60
                    LayoutCachedWidth =8040
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =3
                    Left =8100
                    Top =60
                    Width =1200
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label175"
                    Caption ="Gross \015\012Profit $"
                    LayoutCachedLeft =8100
                    LayoutCachedTop =60
                    LayoutCachedWidth =9300
                    LayoutCachedHeight =540
                End
                Begin Label
                    Visible = NotDefault
                    TextAlign =3
                    Left =10440
                    Top =60
                    Width =1020
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label176"
                    Caption ="Comm. Amount $"
                    LayoutCachedLeft =10440
                    LayoutCachedTop =60
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =9360
                    Top =60
                    Width =960
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label229"
                    Caption ="Gross \015\012Profit %"
                    LayoutCachedLeft =9360
                    LayoutCachedTop =60
                    LayoutCachedWidth =10320
                    LayoutCachedHeight =540
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            RepeatSection = NotDefault
            Height =420
            BreakLevel =1
            Name ="GroupHeader2"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =180
                    Top =60
                    Width =4020
                    Height =270
                    FontWeight =700
                    Name ="Text154"
                    ControlSource ="ESS_nm"

                    LayoutCachedLeft =180
                    LayoutCachedTop =60
                    LayoutCachedWidth =4200
                    LayoutCachedHeight =330
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =120
            BreakLevel =2
            Name ="GroupHeader1"
        End
        Begin Section
            KeepTogether = NotDefault
            Height =270
            Name ="Detail"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7080
                    Width =1080
                    FontSize =8
                    Name ="transaction_amt"
                    ControlSource ="transaction_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7080
                    LayoutCachedWidth =8160
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8220
                    Width =1080
                    FontSize =8
                    TabIndex =1
                    Name ="gp_ext_amt"
                    ControlSource ="gp_ext_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8220
                    LayoutCachedWidth =9300
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =10440
                    Width =1020
                    FontSize =8
                    TabIndex =2
                    Name ="comm_amt"
                    ControlSource ="comm_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =10440
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =300
                    Width =1080
                    Height =270
                    FontSize =10
                    TabIndex =3
                    Name ="hsi_shipto_id"
                    ControlSource ="hsi_shipto_id"

                    LayoutCachedLeft =300
                    LayoutCachedWidth =1380
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    TextFontCharSet =0
                    TextAlign =1
                    IMESentenceMode =3
                    Left =5820
                    Width =1200
                    Height =255
                    ColumnWidth =2940
                    FontSize =8
                    TabIndex =4
                    Name ="transaction_dt"
                    ControlSource ="transaction_dt"
                    Format ="Medium Date"

                    LayoutCachedLeft =5820
                    LayoutCachedWidth =7020
                    LayoutCachedHeight =255
                End
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =4800
                    Width =900
                    Height =270
                    FontSize =8
                    TabIndex =5
                    Name ="doc_id"
                    ControlSource ="doc_id"

                    LayoutCachedLeft =4800
                    LayoutCachedWidth =5700
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =1440
                    Width =1620
                    Height =270
                    FontSize =8
                    TabIndex =6
                    Name ="Text114"
                    ControlSource ="customer_nm"

                    LayoutCachedLeft =1440
                    LayoutCachedWidth =3060
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =3060
                    Width =1740
                    Height =270
                    FontSize =8
                    TabIndex =7
                    Name ="Text211"
                    ControlSource ="FSC_nm"

                    LayoutCachedLeft =3060
                    LayoutCachedWidth =4800
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =9300
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =8
                    Name ="Text232"
                    ControlSource ="=IIf([transaction_amt]<>0,([gp_ext_amt])/([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =9300
                    LayoutCachedWidth =10380
                    LayoutCachedHeight =270
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =735
            BreakLevel =1
            BackColor =12765388
            Name ="GroupFooter6"
            Begin
                Begin Line
                    OldBorderStyle =1
                    Width =11460
                    BorderColor =0
                    Name ="Line126"
                    LayoutCachedWidth =11460
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =180
                    Top =60
                    Width =1140
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text103"
                    ControlSource ="=\"Sub Total\""

                    LayoutCachedLeft =180
                    LayoutCachedTop =60
                    LayoutCachedWidth =1320
                    LayoutCachedHeight =330
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7080
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =1
                    Name ="SalesESS"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7080
                    LayoutCachedWidth =8160
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8220
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =2
                    Name ="sumofGP"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8220
                    LayoutCachedWidth =9300
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =10440
                    Width =1020
                    Height =270
                    FontSize =8
                    TabIndex =3
                    Name ="CommTotal_ESS"
                    ControlSource ="=Sum([comm_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =10440
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1440
                    Top =60
                    Width =4020
                    Height =270
                    TabIndex =4
                    Name ="Text219"
                    ControlSource ="ESS_nm"

                    LayoutCachedLeft =1440
                    LayoutCachedTop =60
                    LayoutCachedWidth =5460
                    LayoutCachedHeight =330
                End
                Begin Label
                    TextAlign =3
                    Left =3480
                    Top =420
                    Width =3540
                    Height =300
                    FontSize =10
                    ForeColor =0
                    Name ="Label225"
                    Caption ="Percent of Total Branch Sales ="
                    LayoutCachedLeft =3480
                    LayoutCachedTop =420
                    LayoutCachedWidth =7020
                    LayoutCachedHeight =720
                End
                Begin TextBox
                    DecimalPlaces =1
                    OldBorderStyle =1
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7080
                    Top =420
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =5
                    Name ="Text226"
                    ControlSource ="=[SalesESS]/[SalesBRANCH]"
                    Format ="Percent"

                    LayoutCachedLeft =7080
                    LayoutCachedTop =420
                    LayoutCachedWidth =8160
                    LayoutCachedHeight =690
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    Top =720
                    Width =11460
                    BorderColor =0
                    Name ="Line115"
                    LayoutCachedTop =720
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =720
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =9300
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =6
                    Name ="Text231"
                    ControlSource ="=Sum([gp_ext_amt])/Sum([transaction_amt])"
                    Format ="Percent"

                    LayoutCachedLeft =9300
                    LayoutCachedWidth =10380
                    LayoutCachedHeight =270
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =480
            Name ="GroupFooter4"
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Width =1620
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text215"
                    ControlSource ="=\"Branch Total\""

                    LayoutCachedWidth =1620
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7080
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =1
                    Name ="SalesBranch"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7080
                    LayoutCachedWidth =8160
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8220
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =2
                    Name ="Text217"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8220
                    LayoutCachedWidth =9300
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =10440
                    Width =1020
                    Height =270
                    FontSize =8
                    TabIndex =3
                    Name ="CommTotal_BRANCH"
                    ControlSource ="=Sum([comm_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =10440
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =9300
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =4
                    Name ="Text233"
                    ControlSource ="=Sum([gp_ext_amt])/Sum([transaction_amt])"
                    Format ="Percent"

                    LayoutCachedLeft =9300
                    LayoutCachedWidth =10380
                    LayoutCachedHeight =270
                End
            End
        End
        Begin PageFooter
            Height =360
            Name ="PageFooterSection"
            Begin
                Begin TextBox
                    TextAlign =1
                    IMESentenceMode =3
                    Left =60
                    Top =60
                    Width =4200
                    Height =300
                    Name ="Text63"
                    ControlSource ="=Now()"
                    Format ="General Date"

                    LayoutCachedLeft =60
                    LayoutCachedTop =60
                    LayoutCachedWidth =4260
                    LayoutCachedHeight =360
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Width =11400
                    BorderColor =12632256
                    Name ="Line69"
                    GridlineColor =0
                    LayoutCachedWidth =11400
                End
                Begin TextBox
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7920
                    Top =60
                    Width =3540
                    Height =270
                    TabIndex =1
                    Name ="Text199"
                    ControlSource ="=\"Page \" & [Page] & \" of \" & [Pages]"

                    LayoutCachedLeft =7920
                    LayoutCachedTop =60
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =330
                End
            End
        End
        Begin FormFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            Height =780
            Name ="ReportFooter"
            Begin
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =1
                    Left =2880
                    Top =360
                    Width =4620
                    BorderColor =-2147483617
                    Name ="Line221"
                    GridlineColor =0
                    LayoutCachedLeft =2880
                    LayoutCachedTop =360
                    LayoutCachedWidth =7500
                    LayoutCachedHeight =360
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =1
                    Left =8100
                    Top =360
                    Width =3240
                    BorderColor =-2147483617
                    Name ="Line222"
                    GridlineColor =0
                    LayoutCachedLeft =8100
                    LayoutCachedTop =360
                    LayoutCachedWidth =11340
                    LayoutCachedHeight =360
                End
                Begin Label
                    Left =2880
                    Top =420
                    Width =4320
                    Height =270
                    FontSize =10
                    ForeColor =0
                    Name ="Label223"
                    Caption ="Branch Manager Signature"
                    LayoutCachedLeft =2880
                    LayoutCachedTop =420
                    LayoutCachedWidth =7200
                    LayoutCachedHeight =690
                End
                Begin Label
                    Left =8100
                    Top =420
                    Width =2220
                    Height =270
                    FontSize =10
                    ForeColor =0
                    Name ="Label224"
                    Caption ="Date"
                    LayoutCachedLeft =8100
                    LayoutCachedTop =420
                    LayoutCachedWidth =10320
                    LayoutCachedHeight =690
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
