
-- Add objects to BRSales

/****** Object:  Schema [comm]    Script Date: 11/16/2017 8:21:08 PM ******/
CREATE SCHEMA [comm]
GO

---
--------------------------------------------------------------------------------
-- DROP TABLE Integration.F55510_customer_territory_Staging
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "WRCO" AS WRCO___company,
	"WR$GTC" AS WR$GTC_group_type_category,
	"WR$GTY" AS WR$GTY_group_type,
	"WR$VNO" AS WR$VNO_number_version,
	"WR$SLO" AS WR$SLO_sales_organization,
	"WRAC10" AS WRAC10_division_code,
	"WR$TER" AS WR$TER_territory_code,
	"WR$L01" AS WR$L01_level_code_01,
	"WR$L02" AS WR$L02_level_code_02,
	"WR$L03" AS WR$L03_level_code_03,
	"WR$L04" AS WR$L04_level_code_04,
	"WR$L05" AS WR$L05_level_code_05,
	"WR$L06" AS WR$L06_level_code_06,
	"WR$L07" AS WR$L07_level_code_07,
	"WR$L08" AS WR$L08_level_code_08,
	"WR$L09" AS WR$L09_level_code_09,
	"WR$L10" AS WR$L10_level_code_10,
	"WR$K01" AS WR$K01_level_id01,
	"WR$K02" AS WR$K02_level_id02,
	"WR$K03" AS WR$K03_level_id03,
	"WR$K04" AS WR$K04_level_id04,
	"WR$K05" AS WR$K05_level_id05,
	"WR$K06" AS WR$K06_level_id06,
	"WR$K07" AS WR$K07_level_id07,
	"WR$K08" AS WR$K08_level_id08,
	"WR$K09" AS WR$K09_level_id09,
	"WR$K10" AS WR$K10_level_id10,
	"WRTKBY" AS WRTKBY_order_taken_by,
	"WR$CGN" AS WR$CGN_customer_group,
	"WR$CLS" AS WR$CLS_classification_code,
	"WRAN8" AS WRAN8__billto,
	"WRSHAN" AS WRSHAN_shipto,
	"WRNAME" AS WRNAME_name,
	"WREFFF" AS WREFFF_effective_from_date,
	"WREFFT" AS WREFFT_effective_thru_date,
	"WRUSER" AS WRUSER_user_id,
	"WRPID" AS WRPID__program_id,
	"WRJOBN" AS WRJOBN_work_station_id,
	"WRUPMJ" AS WRUPMJ_date_updated,
	"WRUPMT" AS WRUPMT_time_last_updated 

INTO Integration.F55510_customer_territory_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WRCO,
		WR$GTC,
		WR$GTY,
		WR$VNO,
		WR$SLO,
		WRAC10,
		WR$TER,
		WR$L01,
		WR$L02,
		WR$L03,
		WR$L04,
		WR$L05,
		WR$L06,
		WR$L07,
		WR$L08,
		WR$L09,
		WR$L10,
		WR$K01,
		WR$K02,
		WR$K03,
		WR$K04,
		WR$K05,
		WR$K06,
		WR$K07,
		WR$K08,
		WR$K09,
		WR$K10,
		WRTKBY,
		WR$CGN,
		WR$CLS,
		WRAN8,
		WRSHAN,
		WRNAME,
		CASE WHEN WREFFF IS NOT NULL THEN DATE(DIGITS(DEC(WREFFF+ 1900000,7,0))) ELSE NULL END AS WREFFF,
		CASE WHEN WREFFT IS NOT NULL THEN DATE(DIGITS(DEC(WREFFT+ 1900000,7,0))) ELSE NULL END AS WREFFT,
		WRUSER,
		WRPID,
		WRJOBN,
		CASE WHEN WRUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(WRUPMJ+ 1900000,7,0))) ELSE NULL END AS WRUPMJ,
		WRUPMT

	FROM
		ARCPDTA71.F55510
	WHERE
		WREFFF <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 		
		WREFFT >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3))  		

--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

ALTER TABLE Integration.F55510_customer_territory_Staging ADD CONSTRAINT
	idx_F55510_customer_territory_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WRSHAN_shipto,
	WR$TER_territory_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO




SELECT 

    Top 5 
    "WSCO" AS WSCO___company,
	"WSDOCO" AS WSDOCO_salesorder_number,
	"WSDCTO" AS WSDCTO_order_type,
	"WSLNTY" AS WSLNTY_line_type,
	"WSLNID" AS WSLNID_line_number,
	"WS$OSC" AS WS$OSC_order_source_code,
	"WSAN8" AS WSAN8__billto,
	"WSSHAN" AS WSSHAN_shipto,
	"WSDGL" AS WSDGL__gl_date,
	"WSLITM" AS WSLITM_item_number,
	"WSDSC1" AS WSDSC1_description,
	"WSDSC2" AS WSDSC2_description_2,
	"WSSRP1" AS WSSRP1_major_product_class,
	"WSSRP2" AS WSSRP2_sub_major_product_class,
	"WSSRP3" AS WSSRP3_minor_product_class,
	"WSSRP6" AS WSSRP6_manufacturer,
	"WSUORG" AS WSUORG_quantity,
	"WSSOQS" AS WSSOQS_quantity_shipped,
	"WSAEXP" AS WSAEXP_extended_price,
	"WSURAT" AS WSURAT_user_reserved_amount,
	"WS$UNC" AS WS$UNC_sales_order_cost_markup,
	"WSOORN" AS WSOORN_original_order_number,
	"WSOCTO" AS WSOCTO_original_order_type,
	"WSOGNO" AS WSOGNO_original_line_number,
	"WSTRDJ" AS WSTRDJ_order_date,
	"WSVR01" AS WSVR01_reference,
	"WSVR02" AS WSVR02_reference_2,
	"WSITM" AS WSITM__item_number_short,
	"WSPROV" AS WSPROV_price_override_code,
	"WSASN" AS WSASN__adjustment_schedule,
	"WSKCO" AS WSKCO__document_company,
	"WSDOC" AS WSDOC__document_number,
	"WSDCT" AS WSDCT__document_type,
	"WSPSN" AS WSPSN__pick_slip_number,
	"WSROUT" AS WSROUT_ship_method,
	"WSZON" AS WSZON__zone_number,
	"WSFRTH" AS WSFRTH_freight_handling_code,
	"WSFRAT" AS WSFRAT_rate_code_freightmisc,
	"WSRATT" AS WSRATT_rate_type_freightmisc,
	"WSGLC" AS WSGLC__gl_offset,
	"WSSO08" AS WSSO08_price_adjustment_line_indicator,
	"WSENTB" AS WSENTB_entered_by,
	"WS$PMC" AS WS$PMC_promotion_code_price_method,
	"WSTKBY" AS WSTKBY_order_taken_by,
	"WSKTLN" AS WSKTLN_kit_master_line_number,
	"WSCOMM" AS WSCOMM_committed_hs,
	"WSEMCU" AS WSEMCU_header_business_unit,
	"WS$SPC" AS WS$SPC_supplier_code,
	"WS$VCD" AS WS$VCD_vendor_code,
	"WS$CLC" AS WS$CLC_classification_code,
	"WSCYCL" AS WSCYCL_cycle_count_category,
	"WSORD" AS WSORD__equipment_order,
	"WSORDT" AS WSORDT_order_type,
	"WSCAG" AS WSCAG__cagess_code,
	"WSEST" AS WSEST__employment_status,
	"WS$ESS" AS WS$ESS_equipment_specialist_code,
	"WS$TSS" AS WS$TSS_tech_specialist_code,
	"WS$CCS" AS WS$CCS_cadcam_specialist_code,
	"WS$NM1" AS WS$NM1__name_1,
	"WS$NM3" AS WS$NM3_researched_by,
	"WS$NM4" AS WS$NM4_completed_by,
	"WS$NM5" AS WS$NM5__name_5,
	"WS$L01" AS WS$L01_level_code_01,
	"WSSRP4" AS WSSRP4_sub_minor_product_class,
	"WSCITM" AS WSCITM_customersupplier_item_number,
	"WSSIC" AS WSSIC__speciality,
	"WSAC04" AS WSAC04_practice_type,
	"WSAC10" AS WSAC10_division_code,
	"WS$O01" AS WS$O01_number_equipment_serial_01,
	"WS$O02" AS WS$O02_number_equipment_serial_02,
	"WS$O03" AS WS$O03_number_equipment_serial_03,
	"WS$O04" AS WS$O04_number_equipment_serial_04,
	"WS$O05" AS WS$O05_number_equipment_serial_05,
	"WS$O06" AS WS$O06_number_equipment_serial_06,
	"WSDL03" AS WSDL03_description_03,
	"WS$ODS" AS WS$ODS_order_discount_amount 

INTO Integration.F555115_commission_sales_extract_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WSCO,
		WSDOCO,
		WSDCTO,
		WSLNTY,
		CAST((WSLNID)/1000.0 AS DEC(15,3)) AS WSLNID,
		WS$OSC,
		WSAN8,
		WSSHAN,
		CASE WHEN WSDGL IS NOT NULL THEN DATE(DIGITS(DEC(WSDGL+ 1900000,7,0))) ELSE NULL END AS WSDGL,
		WSLITM,
		WSDSC1,
		WSDSC2,
		WSSRP1,
		WSSRP2,
		WSSRP3,
		WSSRP6,
		WSUORG,
		WSSOQS,
		CAST((WSAEXP)/100.0 AS DEC(15,2)) AS WSAEXP,
		CAST((WSURAT)/100.0 AS DEC(15,2)) AS WSURAT,
		CAST((WS$UNC)/10000.0 AS DEC(15,4)) AS WS$UNC,
		WSOORN,
		WSOCTO,
		CAST((WSOGNO)/1000.0 AS DEC(15,3)) AS WSOGNO,
		CASE WHEN WSTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(WSTRDJ+ 1900000,7,0))) ELSE NULL END AS WSTRDJ,
		WSVR01,
		WSVR02,
		WSITM,
		WSPROV,
		WSASN,
		WSKCO,
		WSDOC,
		WSDCT,
		WSPSN,
		WSROUT,
		WSZON,
		WSFRTH,
		WSFRAT,
		WSRATT,
		WSGLC,
		WSSO08,
		WSENTB,
		WS$PMC,
		WSTKBY,
		CAST((WSKTLN)/1000.0 AS DEC(15,3)) AS WSKTLN,
		WSCOMM,
		WSEMCU,
		WS$SPC,
		WS$VCD,
		WS$CLC,
		WSCYCL,
		WSORD,
		WSORDT,
		WSCAG,
		WSEST,
		WS$ESS,
		WS$TSS,
		WS$CCS,
		WS$NM1,
		WS$NM3,
		WS$NM4,
		WS$NM5,
		WS$L01,
		WSSRP4,
		WSCITM,
		WSSIC,
		WSAC04,
		WSAC10,
		WS$O01,
		WS$O02,
		WS$O03,
		WS$O04,
		WS$O05,
		WS$O06,
		WSDL03,
		CAST((WS$ODS)/100.0 AS DEC(15,2)) AS WS$ODS

	FROM
		ARCPDTA71.F555115
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


SELECT        WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number, COUNT(*) AS Expr1
FROM            Integration.F555115_commission_sales_extract_Staging AS s
GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type, WSLNID_line_number
HAVING        (COUNT(*) > 1)


ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	F555115_commission_sales_extract_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	WSDOCO_salesorder_number,
	WSDCTO_order_type,
	WSLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO

-- Phase 0 - drop unneeded objects from CommBE


/****** Object:  StoredProcedure [dbo].[comm_transaction_sales_history_calc_proc]    Script Date: 11/18/2017 12:54:48 PM ******/
DROP PROCEDURE [dbo].[comm_transaction_sales_history_calc_proc]
GO

/****** Object:  View [dbo].[zzcomm_ess_statement_export02]    Script Date: 11/18/2017 12:56:36 PM ******/
DROP VIEW 
	comm_eps_region_map, 
	comm_salesperson_RIS_map, 
	zzcomm_ess_statement_export02,
	zzcomm_ess_statement_history,
	zzcomm_rate_map,
	zzcomm_salesperson_category_map,
	zzcomm_statement_detail_all,
	zzcomm_statement_export03,
	zzcomm_statement_summary,
	comm_salesorder_ESS_map,
	comm_salesperson_territory_map
GO

/****** Object:  Table [dbo].[comm_eps_region]    Script Date: 11/18/2017 12:59:22 PM ******/
DROP TABLE 
comm_customer_master_ISR,
comm_eps_productline,
comm_eps_region,
comm_eps_specialist_map,
comm_salesperson_RIS,
comm_transaction_ISR,
zzcomm_group_report


ALTER TABLE dbo.comm_batch_control
	DROP CONSTRAINT comm_batch_control_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_salesperson_master_stage
	DROP CONSTRAINT comm_salesperson_master_stage_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction
	DROP CONSTRAINT comm_transaction_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction_external_stage
	DROP CONSTRAINT comm_transaction_external_stage_comm_status_code_fk_1
GO
ALTER TABLE dbo.comm_transaction_stage
	DROP CONSTRAINT comm_transaction_stage_comm_status_code_fk_1
GO

ALTER TABLE dbo.comm_salesperson_master
	DROP CONSTRAINT comm_salesperson_master_comm_salesperson_category_fk_1
GO

DROP TABLE [dbo].[comm_status_code], comm_salesperson_category
GO

-- Phase 1 - add needed tables to BRSales



CREATE TABLE [comm].[source](
	[source_cd] [char](10) NOT NULL,
	[source_desc] [varchar](40) NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[source_key] [smallint] NOT NULL identity(1,1),

 CONSTRAINT [comm_source_c_pk] PRIMARY KEY CLUSTERED 
(
	[source_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[source] ADD  DEFAULT (1) FOR [active_ind]
GO

ALTER TABLE [comm].[source] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

INSERT        
INTO              comm.[source](source_cd, source_desc)
VALUES        ('', 'Unassigned')

--

CREATE TABLE [comm].[group](
	[comm_group_cd] [char](6) NOT NULL,
	[comm_group_desc] [varchar](40) NOT NULL,
	[source_cd] [char](10) NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[comm_calc_rt] [int] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[booking_rt] [float] NOT NULL,
	[SPM_comm_group_cd] [char](6) NOT NULL,
	[show_ind] [bit] NOT NULL,
	[SPM_EQOptOut] [char](1) NOT NULL,
	[sort_id] [smallint] NOT NULL,
	[FRG_comm_group_cd] [char](6) NOT NULL,
	[comm_group_key] [smallint] NOT NULL Identity(1,1),
 CONSTRAINT [comm_group_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[group] ADD  DEFAULT ('') FOR [source_cd]
GO

ALTER TABLE [comm].[group] ADD  DEFAULT (0) FOR [active_ind]
GO

ALTER TABLE [comm].[group] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_booking_rt]  DEFAULT ((0)) FOR [booking_rt]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_comm_calc_rt]  DEFAULT ((0)) FOR [comm_calc_rt]
GO

GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_comm_group_cd]  DEFAULT ('') FOR [SPM_comm_group_cd]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_show_ind]  DEFAULT ((1)) FOR [show_ind]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_EQOptOut]  DEFAULT ('') FOR [SPM_EQOptOut]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_sort_id]  DEFAULT ((0)) FOR [sort_id]
GO

ALTER TABLE [comm].[group] ADD  CONSTRAINT [DF_comm_group_SPM_comm_group_cd1]  DEFAULT ('') FOR [FRG_comm_group_cd]
GO

ALTER TABLE [comm].[group]  WITH NOCHECK ADD  CONSTRAINT [comm_group_comm_source_fk_1] FOREIGN KEY([source_cd])
REFERENCES [comm].[source] ([source_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [comm_group_comm_source_fk_1]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD  CONSTRAINT [FK_comm_group_comm_group] FOREIGN KEY([SPM_comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [FK_comm_group_comm_group]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD  CONSTRAINT [FK_comm_group_comm_group1] FOREIGN KEY([FRG_comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[group] CHECK CONSTRAINT [FK_comm_group_comm_group1]
GO

ALTER TABLE [comm].[group]  WITH CHECK ADD CHECK  (([comm_calc_rt] = 1 or ([comm_calc_rt] = 0 or [comm_calc_rt] = (-1))))
GO

--

CREATE TABLE [comm].[plan](
	[comm_plan_id] [char](10) NOT NULL,
	[comm_plan_nm] [varchar](30) NOT NULL,
	[note_txt] [varchar](255) NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[SPM_StatusCd] [char](1) NOT NULL,
	[comm_key] [smallint] NOT NULL identity(1,1),

 CONSTRAINT [comm_plan_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_plan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[plan] ADD  DEFAULT (1) FOR [active_ind]
GO

ALTER TABLE [comm].[plan] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan] ADD  CONSTRAINT [DF_comm_plan_SPM_StatusCd]  DEFAULT ('') FOR [SPM_StatusCd]
GO

--


CREATE TABLE [comm].[plan_group_rate](
	[comm_plan_id] [char](10) NOT NULL,
	[comm_group_cd] [char](6) NOT NULL,
	[comm_base_rt] [float] NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [datetime] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[show_ind] [bit] NOT NULL,
 CONSTRAINT [commission_plan_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_plan_id] ASC,
	[comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (0) FOR [comm_base_rt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (0) FOR [active_ind]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  CONSTRAINT [DF_comm_plan_group_rate_show_ind]  DEFAULT ((0)) FOR [show_ind]
GO

ALTER TABLE [comm].[plan_group_rate]  WITH NOCHECK ADD  CONSTRAINT [comm_plan_group_rate_comm_group_fk_1] FOREIGN KEY([comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[plan_group_rate] CHECK CONSTRAINT [comm_plan_group_rate_comm_group_fk_1]
GO

ALTER TABLE [comm].[plan_group_rate]  WITH NOCHECK ADD  CONSTRAINT [comm_plan_group_rate_comm_plan_fk_1] FOREIGN KEY([comm_plan_id])
REFERENCES [comm].[plan] ([comm_plan_id])
GO

ALTER TABLE [comm].[plan_group_rate] CHECK CONSTRAINT [comm_plan_group_rate_comm_plan_fk_1]
GO

--

CREATE TABLE [Integration].[salesperson_master_Staging](
	[master_salesperson_cd] [char](6) NOT NULL,
	[fiscal_yearmo_num] [char](6) NOT NULL,
	[salesperson_nm] [varchar](30) NOT NULL,
	[comm_plan_id] [char](10) NOT NULL,
	[employee_num] [char](10) NOT NULL,
	[territory_start_dt] [datetime] NOT NULL,
	[SALD30_amt] [money] NOT NULL,
	[STMPBA_amt] [money] NOT NULL,
	[note_txt] [varchar](255) NULL,
	[salesperson_key_id] [char](30) NOT NULL,
 CONSTRAINT [PK_comm_salesperson_master_stage] PRIMARY KEY CLUSTERED 
(
	[master_salesperson_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [Integration].[salesperson_master_Staging] ADD  DEFAULT ('') FOR [salesperson_key_id]
GO

--

ALTER TABLE dbo.BRS_Branch ADD
	ZoneName varchar(50) NOT NULL CONSTRAINT DF_BRS_Branch_zone_cd DEFAULT ('')
GO

--

ALTER TABLE dbo.BRS_Item ADD
	comm_group_cd char(6) NOT NULL CONSTRAINT DF_BRS_Item_comm_group_cd DEFAULT (''),
	comm_note_txt varchar(50) NULL
GO

INSERT        
INTO              comm.[group](comm_group_cd, comm_group_desc)
VALUES        ('', 'Unassigned')


ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_group FOREIGN KEY
	(
	comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_Customer ADD
	comm_status_cd char(6) NOT NULL CONSTRAINT DF_BRS_Customer_comm_status_cd DEFAULT (''),
	comm_note_txt varchar(50) NULL
GO

--


CREATE TABLE [comm].[salesperson_master](
	[employee_num] [smallint] NOT NULL,
	[master_salesperson_cd] [char](5) NOT NULL,

	[salesperson_key_id] [varchar](30) NOT NULL,

	[salesperson_nm] [varchar](30) NOT NULL,
	[comm_plan_id] [char](10) NOT NULL,
	[territory_start_dt] [datetime] NOT NULL,
	[creation_dt] [datetime] NOT NULL,

	salesperson_master_key smallint NOT NULL identity(1,1),

	[note_txt] [varchar](50) NULL,
	[flag_ind] [bit] NULL,

 CONSTRAINT [comm_salesperson_master_pk] PRIMARY KEY NONCLUSTERED 
(
	[employee_num], [master_salesperson_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [comm].[salesperson_master] ADD  CONSTRAINT [DF_comm_salesperson_master_create_dt]  DEFAULT (getdate()) FOR [creation_dt]
GO


ALTER TABLE [comm].[salesperson_master]  WITH NOCHECK ADD  CONSTRAINT [comm_salesperson_master_comm_plan_fk_1] FOREIGN KEY([comm_plan_id])
REFERENCES [comm].[plan] ([comm_plan_id])
GO

ALTER TABLE [comm].[salesperson_master]  WITH NOCHECK ADD  CONSTRAINT [comm_salesperson_master_comm_salesperson_code_map_fk_1] FOREIGN KEY([master_salesperson_cd])
REFERENCES [dbo].[BRS_FSC_Rollup] ([TerritoryCd])
GO

CREATE UNIQUE CLUSTERED INDEX idx_salesperson_master_uc_idx_01 ON comm.salesperson_master
	(
	salesperson_key_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

--

ALTER TABLE dbo.BRS_FSC_Rollup ADD
	comm_salesperson_key_id varchar(30) NULL
GO

ALTER TABLE dbo.BRS_FSC_Rollup  WITH NOCHECK ADD  CONSTRAINT [BRS_FSC_Rollup_comm_salesperson_master_fk] FOREIGN KEY([comm_salesperson_key_id])
REFERENCES [comm].[salesperson_master] ([salesperson_key_id])
GO

---

CREATE TABLE [comm].[transaction_F555115](
	[FiscalMonth] [Integer] NOT NULL,
	[WSCO___company] [char](5) NOT NULL,
	[WSDOCO_salesorder_number] [integer] NOT NULL,
	[WSDCTO_order_type] [char](2) NOT NULL,
	[WSLNTY_line_type] [char](2) NOT NULL,
	[WSLNID_line_number] [integer] NOT NULL,
	[WS$OSC_order_source_code] [char](1) NOT NULL,
	[WSAN8__billto] [Integer] NOT NULL,
	[WSSHAN_shipto] [Integer] NOT NULL,
	[WSDGL__gl_date] [datetime] NOT NULL,
	[WSLITM_item_number] [char](10) NOT NULL,
	[WSDSC1_description] [varchar](30) NOT NULL,
	[WSDSC2_description_2] [varchar](30) NOT NULL,
	[WSSRP1_major_product_class] [char](3) NOT NULL,
	[WSSRP2_sub_major_product_class] [char](3) NOT NULL,
	[WSSRP3_minor_product_class] [char](3) NOT NULL,
	[WSSRP6_manufacturer] [char](6) NOT NULL,
	[WSUORG_quantity] [smallint] NOT NULL,
	[WSSOQS_quantity_shipped] [smallint] NOT NULL,
	[WSAEXP_extended_price] [money] NOT NULL,
	[WSURAT_user_reserved_amount] [money] NOT NULL,
	[WS$UNC_sales_order_cost_markup] [money] NOT NULL,
	[WSOORN_original_order_number] [char](8) NOT NULL,
	[WSOCTO_original_order_type] [char](2) NOT NULL,
	[WSOGNO_original_line_number] [integer] NOT NULL,
	[WSTRDJ_order_date] [date] NOT NULL,
	[WSVR01_reference] [varchar](25) NOT NULL,
	[WSVR02_reference_2] [varchar](25) NOT NULL,
	[WSITM__item_number_short] [smallint] NOT NULL,
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
	[ID] [integer] identity(1,1) NOT NULL
 CONSTRAINT [comm_transaction_F555115_pk] PRIMARY KEY NONCLUSTERED 
(
	[WSDOCO_salesorder_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSLNID_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_TransactionDW_Ext FOREIGN KEY
	(
	WSDOCO_salesorder_number
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_DocType FOREIGN KEY
	(
	WSDCTO_order_type
	) REFERENCES dbo.BRS_DocType
	(
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_OrderSource FOREIGN KEY
	(
	WS$OSC_order_source_code
	) REFERENCES dbo.BRS_OrderSource
	(
	OrderSourceCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_Customer FOREIGN KEY
	(
	WSSHAN_shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerBT FOREIGN KEY
	(
	WSAN8__billto
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_SalesDay FOREIGN KEY
	(
	WSDGL__gl_date
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_Item FOREIGN KEY
	(
	WSLITM_item_number
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemMPC FOREIGN KEY
	(
	WSSRP1_major_product_class
	) REFERENCES dbo.BRS_ItemMPC
	(
	MajorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerVPA FOREIGN KEY
	(
	WSASN__adjustment_schedule
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_BusinessUnit FOREIGN KEY
	(
	WSEMCU_header_business_unit
	) REFERENCES dbo.BRS_BusinessUnit
	(
	BusinessUnit
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemSupplier FOREIGN KEY
	(
	WS$SPC_supplier_code
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup FOREIGN KEY
	(
	WSCAG__cagess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup1 FOREIGN KEY
	(
	WS$ESS_equipment_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup2 FOREIGN KEY
	(
	WS$TSS_tech_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup3 FOREIGN KEY
	(
	WS$CCS_cadcam_specialist_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup4 FOREIGN KEY
	(
	WS$L01_level_code_01
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerSpecialty FOREIGN KEY
	(
	WSSIC__speciality
	) REFERENCES dbo.BRS_CustomerSpecialty
	(
	Specialty
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_SalesDivision FOREIGN KEY
	(
	WSAC10_division_code
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

--- add RI


--- add data...



