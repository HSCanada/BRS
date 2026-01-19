
/****** Object:  Table [Integration].[F564201_AgingBillto]    Script Date: 2025/11/24 10:04:36 AM ******/

-- drop TABLE [Integration].[F564201_AgingBillto]

CREATE TABLE [Integration].[F564201_AgingBillto](
	[Account_Number] [int] NOT NULL,
	[Ship_To] [int] NOT NULL,
	[ShipTo_Default] [int] NULL,
	[Business_Name] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[Open_Amount] [money] NULL,
	[Future_Amount] [money] NULL,
	[Gross_Amount] [money] NULL,
	[Current_Amount] [money] NULL,
	[Pastdue30] [money] NULL,
	[Pastdue60] [money] NULL,
	[Pastdue90] [money] NULL,
	[Pastdue120] [money] NULL,
	[CalAgPD91_120] [money] NULL,
	[CalAgPD121_150] [money] NULL,
	[CalAgPD151_180] [money] NULL,
	[CalAgPD181_Over] [money] NULL,
	[CalAgPD61_74] [money] NULL,
	[CalAgPD75_90] [money] NULL,
	[Practice_Type] [nvarchar](50) NULL,
	[Division_Code] [nvarchar](50) NULL,
	[Credit_Representative] [nvarchar](50) NULL,
	[Account_Status] [nvarchar](50) NULL,
	[Auto_ACH] [nvarchar](1) NULL,
	[Phone_Number] [nvarchar](50) NULL,
	[Credit_Limit] [int] NULL,
	[Invoice_Type] [nvarchar](50) NULL,
	[Document_Number] [int] NULL,
	[City] [nvarchar](50) NULL,
	[Account_Level_Business_Unit] [bigint] NULL,
	[Add_Transfer] [nvarchar](50) NULL,
	[Address_1] [varchar](50) NULL,
	[Address_3] [nvarchar](50) NULL,
	[Address_4] [nvarchar](50) NULL,

	[Area_Code] [nvarchar](50) NULL,
--	[Area_Code] [smallint] NULL,

	[Attention] [nvarchar](1) NULL,
	[Average_Days_Late] [tinyint] NULL,
	[Bill_To] [int] NULL,
	[Business_Unit] [bigint] NULL,
	[Company_Code] [smallint] NULL,
	[Country_Code] [nvarchar](50) NULL,
	[County] [nvarchar](1) NULL,
	[Credit_Card_Auto_Pay] [nvarchar](50) NULL,
	[Credit_Card_Status] [nvarchar](50) NULL,
	[Credit_Flag_Spread] [nvarchar](50) NULL,
	[Credit_Manager] [nvarchar](50) NULL,
	[Customer_Business_Unit] [nvarchar](50) NULL,
	[Delinquency_Notice] [nvarchar](50) NULL,
	[Due_Date] [date] NULL,
	[Dummy] [tinyint] NULL,
	[Exempt_From_Credit_Hold] [nvarchar](50) NULL,
	[G_L_Date] [date] NULL,
	[Hold_Invoices] [nvarchar](50) NULL,
	[Invoice_Date] [date] NULL,
	[Invoice_Prior_Year] [money] NULL,
	[Invoice_This_Year] [money] NULL,
	[Last_Credit_Review] [date] NULL,
	[Last_Transaction_Date] [date] NULL,
	[Late_Charge_Flag] [nvarchar](50) NULL,
	[Market_Segment] [nvarchar](50) NULL,
	[Order_Entry] [nvarchar](50) NULL,
	[Parent_Number] [int] NULL,
	[Pay_Type] [tinyint] NULL,
	[Payment_Terms_Customer_Level] [nvarchar](50) NULL,
	[Payment_Terms_Inv_Level] [nvarchar](50) NULL,
	[Payment_Type] [nvarchar](50) NULL,
	[Preferred_Credit_Card] [nvarchar](50) NULL,
	[Print_Statement] [nvarchar](50) NULL,
	[Send_Invoice_To] [nvarchar](50) NULL,
	[Sent_Statement_To] [nvarchar](50) NULL,
	[SO_Number] [int] NULL,
	[Start_Date] [date] NULL,
	[State] [nvarchar](50) NULL,
	[Statement_Cycle] [nvarchar](50) NULL,
	[Tax_Expl_Code] [nvarchar](50) NULL,
	[Tax_ID] [nvarchar](1) NULL,
	[Temporary_Message] [nvarchar](50) NULL,
	[Transfer] [nvarchar](50) NULL,
	[Two_Digit_Zip] [nvarchar](50) NULL,
	[Zip] [nvarchar](50) NULL,
	[Last_Pay_Date] [date] NULL,
	[FSC] [nvarchar](50) NULL,
	[Territory_AAFS] [nvarchar](50) NULL,
 CONSTRAINT [F564201_AgingBillto_c_pk] PRIMARY KEY CLUSTERED 
(
	[Account_Number] ASC,
	[Ship_To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO

GRANT DELETE ON [Integration].[F564201_AgingBillto] TO [maint_role]
GO
use [BRSales]
GO
GRANT INSERT ON [Integration].[F564201_AgingBillto] TO [maint_role]
GO
use [BRSales]
GO
GRANT UPDATE ON [Integration].[F564201_AgingBillto] TO [maint_role]
GO

