
-- AR backend tables, tmc, 29 Oct 24
/****** Object:  Schema [ar]    Script Date: 2024/10/25 2:00:08 PM ******/
CREATE SCHEMA [ar]
GO

--------------------------------------------------------------------------------
-- DROP TABLE Integration.F56CUSA2_CUSINF2A
--------------------------------------------------------------------------------

CREATE TABLE [Integration].[F56CUSA2_CUSINF2A](
	[A5AN8__billto] [numeric](8, 0) NOT NULL,
	[ABALPH_alpha_name] [char](40) NOT NULL,
	[ABAC01_category_code_01] [char](3) NOT NULL,
	[ABAC04_geographic_region] [char](3) NOT NULL,
	[ABAC10_category_code_10] [char](3) NOT NULL,
	[ABCM___credit_message] [char](2) NOT NULL,
	[A5ACL__credit_limit] [numeric](15, 0) NOT NULL,
	[A5CLMG_collection_manager] [char](10) NOT NULL,
	[A5CMGR_credit_manager] [char](10) NOT NULL,
	[A5AVD__average_days_late] [numeric](3, 0) NOT NULL,
	[A5URAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[A5TSTA_temporary_credit_message] [char](2) NOT NULL,
	[A5AFC__apply_finance_charges_yn] [char](1) NOT NULL,
	[A5DLC__date_of_last_credit_review] [date] NULL,
	[A5CYCN_statement_cycle] [char](2) NOT NULL,
	[MAPA8__parent_number] [numeric](8, 0) NOT NULL,
	[MAOSTP_structure_type] [char](3) NOT NULL,
	[A5BADT_billing_address_type] [char](1) NOT NULL,
	[ALADDS_state] [char](3) NOT NULL,
	[ALADDZ_postal_code] [char](12) NOT NULL,
	[ABATPR_user_code] [char](1) NOT NULL,
	[ABAN82__2nd_address_number] [numeric](8, 0) NOT NULL,
	[ABEFTB_start_effective_date] [date] NULL,
	[A5DLP__date_last_paid] [date] NULL,
	[QC$FLG_reason_code] [char](1) NOT NULL,
	[QB$A04_address_flag_future_4] [char](1) NOT NULL,
	[A5RYIN_payment_instrument] [char](1) NOT NULL,
	[A5TRAR_payment_terms_ar] [char](3) NOT NULL,
	[WPAR1__prefix] [char](6) NOT NULL,
	[WPPH1__phone_number] [char](40) NOT NULL,
	[ALADD1_address_line_1] [char](40) NOT NULL,
	[ALADD2_address_line_2] [char](40) NOT NULL,
	[ALADD3_address_line_3] [char](40) NOT NULL,
	[ALADD4_address_line_4] [char](40) NOT NULL,
	[ALCTY1_city] [char](25) NOT NULL,
	[A5EXR1_tax_expl_code] [char](2) NOT NULL,
	[ABTAX__tax_id] [char](20) NOT NULL,
	[ABTX2__addl_ind_tax_id] [char](20) NOT NULL,
	[ABTXCT_certificate] [char](20) NOT NULL,
	[ALCTR__country] [char](3) NOT NULL,
	[ABAC03_category_code_03] [char](3) NOT NULL,
	[QB$RPC_representative_preference_code] [char](1) NOT NULL,
 CONSTRAINT [F56CUSA2_CUSINF2A_c_pk] PRIMARY KEY CLUSTERED 
(
	[A5AN8__billto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


--
-- truncate table Integration.F56CUSA2_CUSINF2A

select * from [Integration].[F56CUSA2_CUSINF2A]

INSERT INTO [Integration].[F56CUSA2_CUSINF2A]
(
		[A5AN8__billto]
      ,[ABALPH_alpha_name]
      ,[ABAC01_category_code_01]
      ,[ABAC04_geographic_region]
      ,[ABAC10_category_code_10]
      ,[ABCM___credit_message]
      ,[A5ACL__credit_limit]
      ,[A5CLMG_collection_manager]
      ,[A5CMGR_credit_manager]
      ,[A5AVD__average_days_late]
      ,[A5URAB_user_reserved_number]
      ,[A5TSTA_temporary_credit_message]
      ,[A5AFC__apply_finance_charges_yn]
      ,[A5DLC__date_of_last_credit_review]
      ,[A5CYCN_statement_cycle]
      ,[MAPA8__parent_number]
      ,[MAOSTP_structure_type]
      ,[A5BADT_billing_address_type]
      ,[ALADDS_state]
      ,[ALADDZ_postal_code]
      ,[ABATPR_user_code]
      ,[ABAN82__2nd_address_number]
      ,[ABEFTB_start_effective_date]
      ,[A5DLP__date_last_paid]
      ,[QC$FLG_reason_code]
      ,[QB$A04_address_flag_future_4]
      ,[A5RYIN_payment_instrument]
      ,[A5TRAR_payment_terms_ar]
      ,[WPAR1__prefix]
      ,[WPPH1__phone_number]
      ,[ALADD1_address_line_1]
      ,[ALADD2_address_line_2]
      ,[ALADD3_address_line_3]
      ,[ALADD4_address_line_4]
      ,[ALCTY1_city]
      ,[A5EXR1_tax_expl_code]
      ,[ABTAX__tax_id]
      ,[ABTX2__addl_ind_tax_id]
      ,[ABTXCT_certificate]
      ,[ALCTR__country]
      ,[ABAC03_category_code_03]
      ,[QB$RPC_representative_preference_code]
)
SELECT 
--  Top 1000
 "A5AN8" AS A5AN8__billto
,"ABALPH" AS ABALPH_alpha_name
,"ABAC01" AS ABAC01_category_code_01
,"ABAC04" AS ABAC04_geographic_region
,"ABAC10" AS ABAC10_category_code_10
,"ABCM" AS ABCM___credit_message
,"A5ACL" AS A5ACL__credit_limit
,"A5CLMG" AS A5CLMG_collection_manager
,"A5CMGR" AS A5CMGR_credit_manager
,"A5AVD" AS A5AVD__average_days_late
,"A5URAB" AS A5URAB_user_reserved_number
,"A5TSTA" AS A5TSTA_temporary_credit_message
,"A5AFC" AS A5AFC__apply_finance_charges_yn

,"A5DLC" AS A5DLC__date_of_last_credit_review

,"A5CYCN" AS A5CYCN_statement_cycle
,"MAPA8" AS MAPA8__parent_number
,"MAOSTP" AS MAOSTP_structure_type
,"A5BADT" AS A5BADT_billing_address_type
,"ALADDS" AS ALADDS_state
,"ALADDZ" AS ALADDZ_postal_code
,"ABATPR" AS ABATPR_user_code
,"ABAN82" AS ABAN82__2nd_address_number
,"ABEFTB" AS ABEFTB_start_effective_date
,"A5DLP" AS A5DLP__date_last_paid
,"QC$FLG" AS QC$FLG_reason_code
,"QB$A04" AS QB$A04_address_flag_future_4
,"A5RYIN" AS A5RYIN_payment_instrument
,"A5TRAR" AS A5TRAR_payment_terms_ar
,"WPAR1" AS WPAR1__prefix
,"WPPH1" AS WPPH1__phone_number
,"ALADD1" AS ALADD1_address_line_1
,"ALADD2" AS ALADD2_address_line_2
,"ALADD3" AS ALADD3_address_line_3
,"ALADD4" AS ALADD4_address_line_4
,"ALCTY1" AS ALCTY1_city
,"A5EXR1" AS A5EXR1_tax_expl_code
,"ABTAX" AS ABTAX__tax_id
,"ABTX2" AS ABTX2__addl_ind_tax_id
,"ABTXCT" AS ABTXCT_certificate
,"ALCTR" AS ALCTR__country
,"ABAC03" AS ABAC03_category_code_03
,"QB$RPC" AS QB$RPC_representative_preference_code 

-- INTO Integration.F56CUSA2_CUSINF2A

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		A5AN8
,ABALPH
,ABAC01
,ABAC04
,ABAC10
,ABCM
,A5ACL
,A5CLMG
,A5CMGR
,A5AVD
,A5URAB
,A5TSTA
,A5AFC

--,A5DLC
--,CASE WHEN A5DLC IS NOT NULL THEN DATE(DIGITS(DEC(A5DLC+ 1900000,7,0))) ELSE NULL END AS A5DLC
,CASE WHEN A5DLC > 0 THEN DATE(DIGITS(DEC(A5DLC+ 1900000,7,0))) ELSE NULL END AS A5DLC

,A5CYCN
,MAPA8
,MAOSTP
,A5BADT
,ALADDS
,ALADDZ
,ABATPR
,ABAN82

--,ABEFTB 
--,CASE WHEN ABEFTB IS NOT NULL THEN DATE(DIGITS(DEC(ABEFTB+ 1900000,7,0))) ELSE NULL END AS ABEFTB
,CASE WHEN ABEFTB > 0 THEN DATE(DIGITS(DEC(ABEFTB+ 1900000,7,0))) ELSE NULL END AS ABEFTB

--,A5DLP
--,CASE WHEN A5DLP IS NOT NULL THEN DATE(DIGITS(DEC(A5DLP+ 1900000,7,0))) ELSE NULL END AS A5DLP
,CASE WHEN A5DLP > 0 THEN DATE(DIGITS(DEC(A5DLP+ 1900000,7,0))) ELSE NULL END AS A5DLP

,QC$FLG
,QB$A04
,A5RYIN
,A5TRAR
,WPAR1
,WPPH1
,ALADD1
,ALADD2
,ALADD3
,ALADD4
,ALCTY1
,A5EXR1
,ABTAX
,ABTX2
,ABTXCT
,ALCTR
,ABAC03
,QB$RPC

	FROM
		ARCUSRFLE.F56CUSA2
    WHERE
		A5BADT = ''B'' AND
--        A5AN8 = 1520907 AND
		1=1
    ORDER BY
        1
')

--------------------------------------------------------------------------------


-- drop TABLE [Integration].[F564201_AgingBillto]

-- truncate TABLE [Integration].[F564201_AgingBillto]

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
	[Area_Code] [smallint] NULL,
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
	[Territory_AAFS] [nvarchar](50) NULL

	CONSTRAINT [F564201_AgingBillto_c_pk] PRIMARY KEY CLUSTERED 
	(
	[Account_Number] ASC,
	[Ship_To] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]

) ON [USERDATA]
GO


--
select [Account_Number], [ship_to], count(*) from [Integration].[F564201_AgingBillto] group by [Account_Number], [Ship_To] order by 2 desc

--[Account_Number] = 1697187

select count(*) from [Integration].[F564201_AgingBillto] 





/****** Object:  Table [Integration].[F564201_AgingBillto]    Script Date: 2024/10/25 1:40:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Integration].[F564201_AgingBillto]') AND type in (N'U'))
DROP TABLE [Integration].[F564201_AgingBillto]
GO




--


-- truncate table [Integration].[F564201_AgingBillto]
GO


SELECT BRS_Customer.BillTo, Sum(BRS_TransactionDW.NetSalesAmt) AS SumOfNetSalesAmt
FROM BRS_TransactionDW INNER JOIN BRS_Customer ON BRS_TransactionDW.Shipto = BRS_Customer.ShipTo
GROUP BY BRS_Customer.BillTo

-- drop table Integration.F564201_aging_detail

CREATE TABLE [Integration].[F564201_aging_detail](
	[Account_Number] [int] NOT NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[Company_Code] [smallint] NULL,
	[Invoice_Type] [nvarchar](50) NULL,
	[Document_Number] [int] NULL,
	[Pay_Type] [tinyint] NULL,
	[InvoiceDate] [int] NULL,
	[DueDate] [int] NULL,
	[Gross_Amount] [money] NULL,
	[Open_Amount] [money] NULL,
	[Future_Amount] [money] NULL,
	[Current_Amount] [money] NULL,
	[Pastdue30] [money] NULL,
	[Pastdue60] [money] NULL,
	[Pastdue90] [money] NULL,
	[Pastdue120] [money] NULL,
	[Dummy] [money] NULL,
	[Business_Unit] [bigint] NULL,
	[Parent_Number] [int] NULL,
	[Account_Status] [nvarchar](50) NULL,
	[Account_Level_Business_Unit] [bigint] NULL,
	[Customer_Business_Unit] [nvarchar](50) NULL,
	[Market_Segment] [nvarchar](50) NULL,
	[Practice_Type] [nvarchar](50) NULL,
	[Division_Code] [nvarchar](50) NULL,
	[Credit_Representative] [nvarchar](50) NULL,
	[Ship_To] [int] NULL,
	[SO_Number] [int] NULL,
	[Order_Entry] [nvarchar](2) NULL,
	[Payment_Type] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Zip] [nvarchar](50) NULL,
	[Two_Digit_Zip] [nvarchar](50) NULL,
	[Credit_Manager] [nvarchar](50) NULL,
	[Transfer] [nvarchar](50) NULL,
	[Add_Transfer] [nvarchar](50) NULL,
	[Credit_Limit] [int] NULL,
	[Late_Charge_Flag] [nvarchar](50) NULL,
	[Statement_Cycle] [nvarchar](50) NULL,
	[Start_Date] [date] NULL,
	[Payment_Terms_Inv_Level] [nvarchar](50) NULL,
	[Payment_Terms_Customer_Level] [nvarchar](50) NULL,
	[Country_Code] [nvarchar](50) NULL,
	[G_L_Date] [date] NULL,
	[Bill_To_Type] [nvarchar](50) NULL,
	[Print_Statement] [nvarchar](50) NULL,
	[Last_Transaction_Date] [date] NULL,
	[Delinquency_Notice] [nvarchar](50) NULL,
	[Credit_Flag_Spread] [nvarchar](1) NULL,
	[Credit_Card_Auto_Pay] [nvarchar](1) NULL,
	[Preferred_Credit_Card] [nvarchar](1) NULL,
	[Business_Name] [nvarchar](50) NULL,
	[Attention] [nvarchar](1) NULL,
	[Address_3] [nvarchar](50) NULL,
	[Address_4] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[County] [nvarchar](50) NULL,
	[Phone_Number] [nvarchar](50) NULL,
	[Average_Days_Late] [tinyint] NULL,
	[Invoice_This_Year] [nvarchar](50) NULL,
	[Invoice_Prior_Year] [nvarchar](50) NULL,
	[Temporary_Message] [nvarchar](50) NULL,
	[Last_Credit_Review] [date] NULL,
	[Tax_Expl_Code] [nvarchar](50) NULL,
	[Tax_ID] [nvarchar](1) NULL,
	[Hold_Invoices] [nvarchar](50) NULL,
	[Sent_Statement_To] [nvarchar](50) NULL,
	[Send_Invoice_To] [nvarchar](50) NULL,
	[Exempt_From_Credit_Hold] [nvarchar](50) NULL,
	[Credit_Card_Status] [nvarchar](1) NULL,
	[Area_Code] [smallint] NULL,
	[Address_1] [nvarchar](50) NULL,
	[ShipTo_Default] [int] NULL,
	[PD61_Over] [float] NULL,
	[Terms_Compare] [nvarchar](50) NULL,
	[PD1to30] [money] NULL,
	[PD31to60] [money] NULL,
	[PD61to90] [money] NULL,
	[PD91andover] [money] NULL,
	[PD31andover] [money] NULL,
	[PD61andover] [money] NULL,
	[Invoice_Date] [date] NULL,
	[Due_Date] [date] NULL,
	[current3] [float] NULL,
	[pastdue303] [money] NULL,
	[Pastdue602] [money] NULL,
	[Pastdue902] [money] NULL,
	[Pastdue1202] [money] NULL,
	[AgingCheck2] [float] NULL,
	[CalAgPD61_74] [money] NULL,
	[CalAgPD75_90] [money] NULL,
	[Pastdue302] [money] NULL,
	[Compare] [nvarchar](50) NULL,
	[Current2] [float] NULL,
	[CalAgCheck2] [float] NULL,
	[Check2] [tinyint] NULL,
	[DaysPastDue] [smallint] NULL,
	[DaysOld] [smallint] NULL,
	[CalAgPD1_30] [money] NULL,
	[CalAgPD31_60] [money] NULL,
	[CalAgPD61_90] [money] NULL,
	[CalAgPD91_120] [money] NULL,
	[CalAgPD121_150] [money] NULL,
	[CalAgPD151_180] [money] NULL,
	[CalAgPD181_Over] [money] NULL,
	[CalAgCheck] [float] NULL,
	[AgingCheck] [float] NULL,
	[Check] [tinyint] NULL,
	[ShipTo_Name] [nvarchar](50) NULL,
	[ID] [int] identity(1,1) NOT NULL
 CONSTRAINT [PK_F564201_aging_detail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

--

drop table ar.credit_rep


CREATE TABLE ar.credit_rep
	(
	Credit_Rep char(10) NOT NULL,
	Credit_Rep_nm nvarchar(50) NULL,
	Credit_Rep_key int NOT NULL IDENTITY (1, 1)
	)  ON USERDATA
GO
ALTER TABLE ar.credit_rep SET (LOCK_ESCALATION = TABLE)
GO

BEGIN TRANSACTION
GO
ALTER TABLE ar.credit_rep ADD CONSTRAINT
	credit_rep_c_pk PRIMARY KEY CLUSTERED 
	(
	Credit_Rep
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE ar.credit_rep SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX credit_rep_u_idx_1 ON ar.credit_rep
	(
	Credit_Rep_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE ar.credit_rep SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
insert into ar.credit_rep
(Credit_Rep)
VALUES ('')


select * from ar.credit_rep

-- truncate table Integration.F56CUSA2_CUSINF2A

-- truncate table [Integration].[F564201_AgingBillto]
-- truncate table [Integration].[F564201_aging_detail]

