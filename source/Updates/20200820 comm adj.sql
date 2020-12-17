--finalize adjustment 
-- Add TS and EST, tmc, 16 Dec 20

--drop TABLE [Integration].[comm_adjustment_Staging]
CREATE TABLE [Integration].[comm_adjustment_Staging](

	-- ORG Sales order (may have bad data)
	[WSDOC__document_number] [int] NOT NULL

	-- default to AA
	,[WSDCTO_order_type] [char](2) NOT NULL Default('AA')

	-- ORG Line No (may get extented)
	,[WSOGNO_original_line_number] [int] NOT NULL

	-- Fiscal mo
	,[FiscalMonth] [int] NOT NULL

	-- transaction_dt
	,[WSDGL__gl_date] [datetime] NOT NULL

	-- Owner
	,[WSVR01_reference] [varchar](25) NOT NULL

	-- Adj Type Actual	
	,[WSSRP6_manufacturer] [char](6) NOT NULL

	-- transaction_amt
	,[transaction_amt] [money] NOT NULL

	,[gp_ext_amt] [money] NOT NULL

	--item_id
	,[WSLITM_item_number] [char](10) NOT NULL

	-- Shipto
	,[WSSHAN_shipto] [int] NOT NULL

	-- Additional Notes	
	,[WSDSC1_description] [varchar](30) NOT NULL

	-- customer_nm
	,[WSVR02_reference_2] [varchar](25) NOT NULL

	-- FSC
	,[fsc_code] [char](5) NULL
	,[fsc_comm_group_cd] [char](6) NULL
	,[fsc_comm_amt] [money] NOT NULL

	-- ESS / CSS
	,[ess_code] [char](5) NULL
	,[ess_comm_group_cd] [char](6) NULL
	,[ess_comm_amt] [money] NOT NULL

	-- CPS / PMTS
	,[cps_code] [char](5) NULL
	,[cps_comm_group_cd] [char](6) NULL
	,[cps_comm_amt] [money] NOT NULL

	-- EPS
	,[eps_code] [char](5) NULL
	,[eps_comm_group_cd] [char](6) NULL
	,[eps_comm_amt] [money] NULL

	-- ISR
	,[isr_code] [char](5) NULL
	,[isr_comm_group_cd] [char](6) NULL
	,[isr_comm_amt] [money] NULL

	-- EST
	,[est_code] [char](5) NULL
	,[est_comm_group_cd] [char](6) NULL
	,[est_comm_amt] [money] NULL

	-- internal flags

	,[source_cd] [char](3) NOT NULL

	-- Sales order (clean)
	,[WSDOCO_salesorder_number] [int] NULL

	-- based on ORG, but may be extended due to ESS split
	,[WSLNID_line_number] [int] NOT NULL
	-- add costs from Pre- process. 
	,[WS$UNC_sales_order_cost_markup] [money] NOT NULL

	-- add MA for GP
	,[WSURAT_user_reserved_amount] [money] NOT NULL

	,[ID_legacy] [int] NULL
	,[cust_comm_group_cd] [char](6) NULL
	,[item_comm_group_cd] [char](6) NULL

	,[fsc_salesperson_key_id] [varchar](30) NULL
	,[ess_salesperson_key_id] [varchar](30) NULL
	,[cps_salesperson_key_id] [varchar](30) NULL
	,[eps_salesperson_key_id] [varchar](30) NULL
	,[isr_salesperson_key_id] [varchar](30) NULL
	,[est_salesperson_key_id] [varchar](30) NULL

 CONSTRAINT [comm_adjustment_Staging_c_pk] PRIMARY KEY CLUSTERED 
(
	[WSDOC__document_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSOGNO_original_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

SELECT
	-- test       
--	TOP (10) 
	fiscal_yearmo_num
	,LEFT(salesperson_cd,5) salesperson_cd
	,LEFT(source_cd,3) source_cd
	,transaction_dt
	,transaction_amt
	,line_id
	,doc_id as salesorder
	,doc_id
	,ISNULL(reference_order_txt,'') reference_order_txt
	,LEFT(item_id,10) item_id
	,transaction_txt
	,salesperson_key_id
	,comm_plan_id
	,comm_amt
	,item_comm_group_cd
	,item_comm_rt
	,ess_salesperson_key_id
	,gp_ext_amt
	,doc_type_cd
	,ess_comm_plan_id
	,ess_comm_group_cd
	,ess_comm_rt
	,ess_comm_amt
	,hsi_shipto_id
	,LEFT(ess_salesperson_cd,5) ess_salesperson_cd
	,LEFT(pmts_salesperson_cd,5) pmts_salesperson_cd
	,record_id
FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num between  '202006' and '202006') AND
--	load only adj? (comment out next line for all)
	source_cd NOT in('JDE') AND
--	test
--	(doc_id = 13182717 ) AND
	(1=1)
GO


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	top 10
		[FiscalMonth]
      ,[WSDOCO_salesorder_number]
      ,[WSORD__equipment_order]
      ,[WSAC10_division_code]
      ,[ID]

      ,[WSTKBY_order_taken_by]
      ,[WS$ESS_equipment_specialist_code]
      ,[ess_code]

  FROM [BRSales].[comm].[transaction_F555115]
  where
	(	
  				(WSTKBY_order_taken_by like 'ESS%') OR
				(WSTKBY_order_taken_by like 'CCS%') OR
				(WSTKBY_order_taken_by like 'PMT%') OR
				-- EQ legacy
				(WSTKBY_order_taken_by like 'DTS%') OR
				(WSTKBY_order_taken_by like 'DSS%') 
	) AND
	[WSORD__equipment_order] is null AND
--	[ess_code] <> '' AND
--  [WS$ESS_equipment_specialist_code] <> ''
  (1=1)

  UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201901
UPDATE [CommBE].[dbo].[comm_configure] SET [current_fiscal_yearmo_num] = 201901

SELECT comm.test_detail.fiscal_yearmo_num, comm.test_detail.ID_legacy, comm.test_detail.doc_id, comm.test_detail.dock_key_id, comm.test_detail.line_id, comm.test_detail.source_cd, comm.test_detail.owner_cd, comm.test_detail.src, comm.test_detail.hsi_shipto_id, comm.test_detail.item_id, comm.test_detail.fsc_comm_plan_id, comm.test_detail.fsc_salesperson_key_id, comm.test_detail.fsc_code, comm.test_detail.ess_code, comm.test_detail.disp_fsc_comm_group_cd, comm.test_detail.fsc_comm_group_cd, comm.test_detail.shipped_qty, comm.test_detail.transaction_amt, comm.test_detail.gp_ext_amt, comm.test_detail.fsc_comm_amt, comm.test_detail.fsc_calc_key, comm.test_detail.cust_comm_group_cd, comm.test_detail.item_comm_group_cd, comm.test_detail.ess_calc_key, comm.test_detail.xfer_key, comm.test_detail.xfer_fsc_code_org, comm.test_detail.xfer_ess_code_org
FROM comm.test_detail
WHERE 
(comm.test_detail.doc_id=1110225) AND 
(comm.test_detail.fsc_comm_plan_id Like 'fsc%') AND 
(comm.test_detail.fsc_salesperson_key_id<>'Internal') AND
(1=1)

--

SELECT
-- TOP (10) 
s.Shipto, 
s.FiscalMonth, 

d.HIST_TerritoryCd, 
s.HIST_TerritoryCd, 

d.HIST_fsc_salesperson_key_id, 
s.HIST_fsc_salesperson_key_id, 

d.HIST_fsc_comm_plan_id,
s.HIST_fsc_comm_plan_id

FROM
	DEV_BRSales.dbo.BRS_CustomerFSC_History AS s 
	INNER JOIN BRS_CustomerFSC_History AS d 
	ON s.Shipto = d.Shipto AND 
	s.FiscalMonth = d.FiscalMonth
where 
	d.Shipto > 0 AND
	d.FiscalMonth >= 201901 AND
--	(d.HIST_TerritoryCd <> s.HIST_TerritoryCd) AND
	(
	(d.HIST_fsc_salesperson_key_id <> s.HIST_fsc_salesperson_key_id) OR
	(d.HIST_fsc_comm_plan_id <> s.HIST_fsc_comm_plan_id) 
	) 


-- 919 109

UPDATE       d
SET
HIST_fsc_salesperson_key_id = s.HIST_fsc_salesperson_key_id, 
HIST_fsc_comm_plan_id = s.HIST_fsc_comm_plan_id
FROM
DEV_BRSales.dbo.BRS_CustomerFSC_History AS s 
INNER JOIN BRS_CustomerFSC_History AS d 
ON s.Shipto = d.Shipto AND 
s.FiscalMonth = d.FiscalMonth
WHERE
(d.Shipto > 0) AND 
(d.FiscalMonth >= 201901) AND 
(d.HIST_fsc_salesperson_key_id <> s.HIST_fsc_salesperson_key_id) 
OR
(d.Shipto > 0) AND 
(d.FiscalMonth >= 201901) AND 
(d.HIST_fsc_comm_plan_id <> s.HIST_fsc_comm_plan_id)
