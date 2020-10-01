-- finalize adjustment 
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

--drop TABLE [Integration].[comm_adjustment_Staging]
CREATE TABLE [Integration].[comm_adjustment_Staging](
	[WSDOCO_salesorder_number] [int] NOT NULL
	,[WSDCTO_order_type] [char](2) NOT NULL
	,[WSLNID_line_number] [int] NOT NULL
	-- sort out line org vs RI
	[WSOGNO_original_line_number] [int] NOT NULL,

	,[FiscalMonth] [int] NOT NULL
	,[WSDGL__gl_date] [datetime] NOT NULL
	,[WSVR01_reference] [varchar](25) NOT NULL
	,[transaction_amt] [money] NOT NULL
	,[gp_ext_amt] [money] NOT NULL
	,[WS$UNC_sales_order_cost_markup] [money] NOT NULL
	,[WSLITM_item_number] [char](10) NOT NULL
	,[WSSHAN_shipto] [int] NOT NULL
	,[WSDSC1_description] [varchar](30) NOT NULL
	,[WSVR02_reference_2] [varchar](25) NOT NULL

	,[fsc_code] [char](5) NULL
	,[fsc_comm_group_cd] [char](6) NULL
	,[fsc_comm_amt] [money] NOT NULL

	,[ess_code] [char](5) NULL
	,[ess_comm_group_cd] [char](6) NULL
	,[ess_comm_amt] [money] NOT NULL

	,[cps_code] [char](5) NULL
	,[cps_comm_group_cd] [char](6) NULL
	,[cps_comm_amt] [money] NOT NULL

	,[eps_code] [char](5) NULL
	,[eps_comm_group_cd] [char](6) NULL
	,[eps_comm_amt] [money] NULL

	,[source_cd] [char](3) NOT NULL
/*
	[ID_legacy] [int] NULL,

	[fsc_salesperson_key_id] [varchar](30) NULL,
	[fsc_comm_plan_id] [char](10) NULL,
	[fsc_comm_rt] [float] NULL,
	[ess_salesperson_key_id] [varchar](30) NULL,
	[ess_comm_plan_id] [char](10) NULL,
	[ess_comm_rt] [float] NULL,
	[cps_salesperson_key_id] [varchar](30) NULL,
	[cps_comm_plan_id] [char](10) NULL,
	[cps_comm_rt] [float] NULL,
	[eps_salesperson_key_id] [varchar](30) NULL,
	[eps_comm_plan_id] [char](10) NULL,
	[eps_comm_rt] [float] NULL,
	[cust_comm_group_cd] [char](6) NULL,
	[item_comm_group_cd] [char](6) NULL,
	[fsc_calc_key] [int] NULL,
	[ess_calc_key] [int] NULL,
	[cps_calc_key] [int] NULL,
	[eps_calc_key] [int] NULL,
	[xfer_key] [int] NULL,
	[xfer_fsc_code_org] [char](5) NULL,
	[xfer_ess_code_org] [char](5) NULL,
	[WSCO___company] [char](5) NOT NULL,
	[WSLNTY_line_type] [char](2) NOT NULL,
	[WS$OSC_order_source_code] [char](1) NOT NULL,
	[WSAN8__billto] [int] NOT NULL,
	[WSDSC2_description_2] [varchar](30) NOT NULL,
	[WSSRP1_major_product_class] [char](3) NOT NULL,
	[WSSRP2_sub_major_product_class] [char](3) NOT NULL,
	[WSSRP3_minor_product_class] [char](3) NOT NULL,
	[WSSRP6_manufacturer] [char](6) NOT NULL,
	[WSUORG_quantity] [smallint] NOT NULL,
	[WSSOQS_quantity_shipped] [smallint] NOT NULL,
	[WSAEXP_extended_price] [money] NOT NULL,
	[WSURAT_user_reserved_amount] [money] NOT NULL,
	[WSOORN_original_order_number] [char](8) NOT NULL,
	[WSOCTO_original_order_type] [char](2) NOT NULL,
	[WSTRDJ_order_date] [date] NOT NULL,
	[WSITM__item_number_short] [int] NOT NULL,
	[WSPROV_price_override_code] [char](1) NOT NULL,
	[WSASN__adjustment_schedule] [char](10) NOT NULL,
	[WSKCO__document_company] [char](5) NOT NULL,
	[WSDOC__document_number] [numeric](8, 0) NOT NULL,
	[WSDCT__document_type] [char](2) NOT NULL,
	[WSPSN__pick_slip_number] [numeric](8, 0) NOT NULL,
	[WSROUT_ship_method] [char](3) NOT NULL,
	[WSZON__zone_number] [char](3) NOT NULL,
	[WSFRTH_freight_handling_code] [char](3) NOT NULL,
	[WSFRAT_rate_code_freightmisc] [varchar](10) NOT NULL,
	[WSRATT_rate_type_freightmisc] [char](1) NOT NULL,
	[WSGLC__gl_offset] [char](4) NOT NULL,
	[WSSO08_price_adjustment_line_indicator] [char](1) NOT NULL,
	[WSENTB_entered_by] [char](10) NOT NULL,
	[WS$PMC_promotion_code_price_method] [char](2) NOT NULL,
	[WSTKBY_order_taken_by] [char](10) NOT NULL,
	[WSKTLN_kit_master_line_number] [smallint] NOT NULL,
	[WSCOMM_committed_hs] [char](1) NOT NULL,
	[WSEMCU_header_business_unit] [char](12) NOT NULL,
	[WS$SPC_supplier_code] [char](6) NOT NULL,
	[WS$VCD_vendor_code] [char](6) NOT NULL,
	[WS$CLC_classification_code] [char](3) NOT NULL,
	[WSCYCL_cycle_count_category] [char](3) NOT NULL,
	[WSORD__equipment_order] [char](15) NOT NULL,
	[WSORDT_order_type] [char](2) NOT NULL,
	[WSCAG__cagess_code] [char](5) NOT NULL,
	[WSEST__employment_status] [char](10) NOT NULL,
	[WS$ESS_equipment_specialist_code] [char](5) NOT NULL,
	[WS$TSS_tech_specialist_code] [char](5) NOT NULL,
	[WS$CCS_cadcam_specialist_code] [char](5) NOT NULL,
	[WS$NM1__name_1] [varchar](30) NOT NULL,
	[WS$NM3_researched_by] [varchar](30) NOT NULL,
	[WS$NM4_completed_by] [varchar](30) NOT NULL,
	[WS$NM5__name_5] [varchar](30) NOT NULL,
	[WS$L01_level_code_01] [char](5) NOT NULL,
	[WSSRP4_sub_minor_product_class] [char](3) NOT NULL,
	[WSCITM_customersupplier_item_number] [varchar](25) NOT NULL,
	[WSSIC__speciality] [char](10) NOT NULL,
	[WSAC04_practice_type] [char](3) NOT NULL,
	[WSAC10_division_code] [char](3) NOT NULL,
	[WS$O01_number_equipment_serial_01] [varchar](30) NOT NULL,
	[WS$O02_number_equipment_serial_02] [varchar](30) NOT NULL,
	[WS$O03_number_equipment_serial_03] [varchar](30) NOT NULL,
	[WS$O04_number_equipment_serial_04] [varchar](30) NOT NULL,
	[WS$O05_number_equipment_serial_05] [varchar](30) NOT NULL,
	[WS$O06_number_equipment_serial_06] [varchar](30) NOT NULL,
	[WSDL03_description_03] [numeric](6, 0) NOT NULL,
	[WS$ODS_order_discount_amount] [money] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FreeGoodsInvoicedInd] [bit] NOT NULL,
	[FreeGoodsRedeemedInd] [bit] NOT NULL,
	[FreeGoodsEstInd] [bit] NOT NULL,
	[gp_ext_org_amt] [money] NULL,
*/
 CONSTRAINT [comm_transaction_F555115_pk] PRIMARY KEY NONCLUSTERED 
(
	[WSDOCO_salesorder_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSLNID_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
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
