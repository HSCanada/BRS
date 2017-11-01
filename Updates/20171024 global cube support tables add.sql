-- add Global Cube support tables

CREATE SCHEMA [hfm] AUTHORIZATION [dbo]
GO

-- Exclusive source data setup

ALTER TABLE dbo.BRS_ItemHistory ADD
	MinorProductClass char(9) NOT NULL CONSTRAINT DF_BRS_ItemHistory_MinorProductClass DEFAULT (''),
	Label char(1) NOT NULL CONSTRAINT DF_BRS_ItemHistory_Label DEFAULT (''),
	Brand char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_Brand DEFAULT (''),
	Excl_key int NULL
GO

-- 30 sec
UPDATE       BRS_ItemHistory
SET                
MinorProductClass = BRS_Item.MinorProductClass , 
Label = BRS_Item.Label, 
Brand = BRS_Item.Brand

FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item ON BRS_ItemHistory.Item = BRS_Item.Item
/*
-- test comp

select  distinct FiscalMonth, Item
from BRS_Transaction t
where 
-- t.FiscalMonth = 201302 AND
NOT exists (

SELECT        *
FROM            BRS_ItemHistory h
where h.FiscalMonth = t.FiscalMonth and h.Item = t.Item
)
*/

-- Private label setup


ALTER TABLE dbo.BRS_ItemMPC ADD
	PrivateLabelScopeInd bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_PrivateLabelScopeInd DEFAULT (0)
GO

UPDATE       BRS_ItemMPC
SET                PrivateLabelScopeInd = 1
WHERE        (MajorProductClass in( '001','002','003','004','005','006','007','008','009','010','011','012','013','016','017','019','020','021','022','023','024','025','026','028','029','035','036','037','038','039','041','044','045','046','050','051','052','053','054','057','058','060','061','069','123','124','125','126','127','128','300','315','316','320','321','330','331','340','341','350','355','356','357','364','365','366','367','368','369','370','901','081','082','083','084','372'))



SELECT 

--    Top 5 
    "ACOBJ" AS ACOBJ__object_account, "ACCO" AS ACCO___company, "ACDL01" AS ACDL01_description, "ACLDA" AS ACLDA__account_level_of_detail, "ACPEC" AS ACPEC__posting_edit, "ACUM" AS ACUM___unit_of_measure 

 INTO Integration.F0909_chart_of_accounts_Stage

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		ACOBJ, ACCO, ACDL01, ACLDA, ACPEC, ACUM

	FROM
		ARCPDTA71.F0909
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

ALTER TABLE Integration.F0909_chart_of_accounts_Stage ADD CONSTRAINT
	PK_F0909_chart_of_accounts_Stage PRIMARY KEY CLUSTERED 
	(
	ACOBJ__object_account
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO


/*
-- need?

SELECT 
--    Top 5 
    "MCMCU" AS MCMCU__business_unit,
		"MCSTYL" AS MCSTYL_type_business_unit,
		"MCDC" AS MCDC___description_compressed,
		"MCLDM" AS MCLDM__level_of_detail,
		"MCCO" AS MCCO___company,
		"MCAN8" AS MCAN8__billto,
		"MCAN8O" AS MCAN8O_ownerreceivable_address,
		"MCCNTY" AS MCCNTY_county,
		"MCADDS" AS MCADDS_state,
		"MCFMOD" AS MCFMOD_model_accountconsolidations,
		"MCDL01" AS MCDL01_description,
		"MCDL02" AS MCDL02_description_02,
		"MCDL03" AS MCDL03_description_03,
		"MCDL04" AS MCDL04_description_04,
		"MCRP01" AS MCRP01_sector,
		"MCRP02" AS MCRP02_group,
		"MCRP03" AS MCRP03_meddenvet,
		"MCRP04" AS MCRP04_govt_tyoe,
		"MCRP05" AS MCRP05_lab_type,
		"MCRP06" AS MCRP06_category_code_06,
		"MCRP07" AS MCRP07_category_code_07,
		"MCRP08" AS MCRP08_category_code_08,
		"MCRP09" AS MCRP09_category_code_09,
		"MCRP10" AS MCRP10_category_code_10,
		"MCRP11" AS MCRP11_category_code_11,
		"MCRP12" AS MCRP12_category_code_12,
		"MCRP13" AS MCRP13_category_code_13,
		"MCRP14" AS MCRP14_category_code_14,
		"MCRP15" AS MCRP15_category_code_15,
		"MCRP16" AS MCRP16_category_code_16,
		"MCRP17" AS MCRP17_category_code_17,
		"MCRP18" AS MCRP18_category_code_18,
		"MCRP19" AS MCRP19_category_code_19,
		"MCRP20" AS MCRP20_brnchid_planning,
		"MCRP21" AS MCRP21_category_code_21,
		"MCRP22" AS MCRP22_pl_cde_planning,
		"MCRP23" AS MCRP23_category_code_23,
		"MCRP24" AS MCRP24_category_code_24,
		"MCRP25" AS MCRP25_category_code_25,
		"MCRP26" AS MCRP26_category_code_26,
		"MCRP27" AS MCRP27_category_code_27,
		"MCRP28" AS MCRP28_category_code_28,
		"MCRP29" AS MCRP29_category_code_29,
		"MCRP30" AS MCRP30_category_code_30,
		"MCTA" AS MCTA___tax_area,
		"MCTXJS" AS MCTXJS_tax_entity,
		"MCTXA1" AS MCTXA1_tax_ratearea,
		"MCEXR1" AS MCEXR1_tax_expl_code,
		"MCTC01" AS MCTC01_taxdeduction_codes_01,
		"MCTC02" AS MCTC02_taxdeduction_codes_02,
		"MCTC03" AS MCTC03_taxdeduction_codes_03,
		"MCTC04" AS MCTC04_taxdeduction_codes_04,
		"MCTC05" AS MCTC05_taxdeduction_codes_05,
		"MCTC06" AS MCTC06_taxdeduction_codes_06,
		"MCTC07" AS MCTC07_taxdeduction_codes_07,
		"MCTC08" AS MCTC08_taxdeduction_codes_08,
		"MCTC09" AS MCTC09_taxdeduction_codes_09,
		"MCTC10" AS MCTC10_taxdeduction_codes_10,
		"MCND01" AS MCND01_tax_distributablenondistr_01,
		"MCND02" AS MCND02_tax_distributablenondistr_02,
		"MCND03" AS MCND03_tax_distributablenondistr_03,
		"MCND04" AS MCND04_tax_distributablenondistr_04,
		"MCND05" AS MCND05_tax_distributablenondistr_05,
		"MCND06" AS MCND06_tax_distributablenondistr_06,
		"MCND07" AS MCND07_tax_distributablenondistr_07,
		"MCND08" AS MCND08_tax_distributablenondistr_08,
		"MCND09" AS MCND09_tax_distributablenondistr_09,
		"MCND10" AS MCND10_tax_distributablenondistr_10,
		"MCCC01" AS MCCC01_compute_status_code_01,
		"MCCC02" AS MCCC02_compute_status_code_02,
		"MCCC03" AS MCCC03_compute_status_code_03,
		"MCCC04" AS MCCC04_compute_status_code_04,
		"MCCC05" AS MCCC05_compute_status_code_05,
		"MCCC06" AS MCCC06_compute_status_code_06,
		"MCCC07" AS MCCC07_compute_status_code_07,
		"MCCC08" AS MCCC08_compute_status_code_08,
		"MCCC09" AS MCCC09_compute_status_code_09,
		"MCCC10" AS MCCC10_compute_status_code_10,
		"MCPECC" AS MCPECC_posting_edit,
		"MCALS" AS MCALS__summarization_method,
		"MCISS" AS MCISS__invstmt_summarization_method,
		"MCGLBA" AS MCGLBA_gl_bank_account,
		"MCALCL" AS MCALCL_allocation_level,
		"MCLMTH" AS MCLMTH_labor_distri_meth,
		"MCLF" AS MCLF___labor_distri_mult,
		"MCOBJ1" AS MCOBJ1_labor_account,
		"MCOBJ2" AS MCOBJ2_premium_account,
		"MCOBJ3" AS MCOBJ3_burden_account,
		"MCSUB1" AS MCSUB1_subsidiary,
		"MCTOU" AS MCTOU__total_units,
		"MCSBLI" AS MCSBLI_subledger_inactive_code,
		"MCANPA" AS MCANPA_supervisor,
		"MCCT" AS MCCT___contract_type,
		"MCCERT" AS MCCERT_certified_job_yn,
		"MCMCUS" AS MCMCUS_project_number,
		"MCBTYP" AS MCBTYP_billing_type,
		"MCPC" AS MCPC___percent_complete,
		"MCPCA" AS MCPCA__percent_complete_aggregate_detail,
		"MCPCC" AS MCPCC__cost_to_complete_obsolete,
		"MCINTA" AS MCINTA_int_comp_code,
		"MCINTL" AS MCINTL_interest_comp_code_late_revenue,
		"MCD1J" AS MCD1J__planned_start_date,
		"MCD2J" AS MCD2J__actual_start_date,
		"MCD3J" AS MCD3J__planned_comp_date,
		"MCD4J" AS MCD4J__actual_comp_date,
		"MCD5J" AS MCD5J__other_date_5,
		"MCD6J" AS MCD6J__other_date_6,
		"MCFPDJ" AS MCFPDJ_final_payment,
		"MCCAC" AS MCCAC__cost_at_completion,
		"MCPAC" AS MCPAC__profit_at_completion,
		"MCEEO" AS MCEEO__eeo_code_yn,
		"MCERC" AS MCERC__equipment_rate_code,
		"MCAFE" AS MCAFE__afe_number,
		"MCTSBU" AS MCTSBU_target_business_unit,
		"MCDTFR" AS MCDTFR_date_from,
		"MCDTTO" AS MCDTTO_date_thru,
		"MCCEDF" AS MCCEDF_current_effective_date_flag,
		"MCUSER" AS MCUSER_user_id,
		"MCPID" AS MCPID__program_id,
		"MCUPMJ" AS MCUPMJ_date_updated,
		"MCJOBN" AS MCJOBN_work_station_id,
		"MCUPMT" AS MCUPMT_time_last_updated,
		"MCISNM" AS MCISNM_mcu_value_is_numeric 

--INTO Integration.F0006_business_unit_master_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		MCMCU, MCSTYL, MCDC, MCLDM, MCCO, MCAN8, MCAN8O, MCCNTY, MCADDS, MCFMOD, MCDL01, MCDL02, MCDL03, MCDL04, MCRP01, MCRP02, MCRP03, MCRP04, MCRP05, MCRP06, MCRP07, MCRP08, MCRP09, MCRP10, MCRP11, MCRP12, MCRP13, MCRP14, MCRP15, MCRP16, MCRP17, MCRP18, MCRP19, MCRP20, MCRP21, MCRP22, MCRP23, MCRP24, MCRP25, MCRP26, MCRP27, MCRP28, MCRP29, MCRP30, MCTA, MCTXJS, MCTXA1, MCEXR1, MCTC01, MCTC02, MCTC03, MCTC04, MCTC05, MCTC06, MCTC07, MCTC08, MCTC09, MCTC10, MCND01, MCND02, MCND03, MCND04, MCND05, MCND06, MCND07, MCND08, MCND09, MCND10, MCCC01, MCCC02, MCCC03, MCCC04, MCCC05, MCCC06, MCCC07, MCCC08, MCCC09, MCCC10, MCPECC, MCALS, MCISS, MCGLBA, MCALCL, MCLMTH, CAST((MCLF)/10000.0 AS DEC(15,4)) AS MCLF, MCOBJ1, MCOBJ2, MCOBJ3, MCSUB1, CAST((MCTOU)/100.0 AS DEC(15,2)) AS MCTOU, MCSBLI, MCANPA, MCCT, MCCERT, MCMCUS, MCBTYP, MCPC, CAST((MCPCA)/100.0 AS DEC(15,2)) AS MCPCA, CAST((MCPCC)/100.0 AS DEC(15,2)) AS MCPCC, MCINTA, MCINTL, CASE WHEN MCD1J IS NOT NULL THEN DATE(DIGITS(DEC(MCD1J+ 1900000,7,0))) ELSE NULL END AS MCD1J, CASE WHEN MCD2J IS NOT NULL THEN DATE(DIGITS(DEC(MCD2J+ 1900000,7,0))) ELSE NULL END AS MCD2J, CASE WHEN MCD3J IS NOT NULL THEN DATE(DIGITS(DEC(MCD3J+ 1900000,7,0))) ELSE NULL END AS MCD3J, CASE WHEN MCD4J IS NOT NULL THEN DATE(DIGITS(DEC(MCD4J+ 1900000,7,0))) ELSE NULL END AS MCD4J, CASE WHEN MCD5J IS NOT NULL THEN DATE(DIGITS(DEC(MCD5J+ 1900000,7,0))) ELSE NULL END AS MCD5J, CASE WHEN MCD6J IS NOT NULL THEN DATE(DIGITS(DEC(MCD6J+ 1900000,7,0))) ELSE NULL END AS MCD6J, CASE WHEN MCFPDJ IS NOT NULL THEN DATE(DIGITS(DEC(MCFPDJ+ 1900000,7,0))) ELSE NULL END AS MCFPDJ, CAST((MCCAC)/100.0 AS DEC(15,2)) AS MCCAC, CAST((MCPAC)/100.0 AS DEC(15,2)) AS MCPAC, MCEEO, MCERC, MCAFE, MCTSBU, CASE WHEN MCDTFR IS NOT NULL THEN DATE(DIGITS(DEC(MCDTFR+ 1900000,7,0))) ELSE NULL END AS MCDTFR, CASE WHEN MCDTTO IS NOT NULL THEN DATE(DIGITS(DEC(MCDTTO+ 1900000,7,0))) ELSE NULL END AS MCDTTO, MCCEDF, MCUSER, MCPID, CASE WHEN MCUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(MCUPMJ+ 1900000,7,0))) ELSE NULL END AS MCUPMJ, MCJOBN, MCUPMT, MCISNM

	FROM
		ARCPDTA71.F0006
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')


*/


-- Exclusive - main table


CREATE TABLE [hfm].[exclusive_product](
	[Excl_Code] [nchar](20) NOT NULL,
	[Excl_Name] [nvarchar](50) NOT NULL,
	[BrandEquityCategory] [nvarchar](30) NULL,
	[ProductCategory] [nvarchar](30) NULL,
	[Owner] [nvarchar](30) NULL,
	[DataContact] [nvarchar](30) NULL,
	[DataSourceCode] [char](2) NULL,
	[Note] [nvarchar](50) NULL,
	[LastReviewed] [date] NULL,
	[EffectivePeriod] int NULL,
	[ExpiredPeriod] int NULL,
	[Excl_Key] Int Identity(0, 1)

 CONSTRAINT [exclusive_product_c_pk] PRIMARY KEY CLUSTERED 
(
	[Excl_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

/****** Object:  Index [BRS_ExclusiveProduct_u_idx_01]    Script Date: 10/24/2017 4:11:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [exclusive_product_u_idx_01] ON [hfm].[exclusive_product]
(
	[Excl_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

INSERT INTO hfm.exclusive_product
                         (Excl_Code, Excl_Name)
VALUES        
	(N'', N'Unassigned'),
    (N'CORPORATE_BRAND', N'Corporate Brand'),
    (N'BRANDED', N'Branded')

-- Exclusive - mapping rules

CREATE TABLE [hfm].[exclusive_product_rule](
	[Supplier_WhereClauseLike] [varchar](30) NOT NULL,
	[Brand_WhereClauseLike] [varchar](30) NOT NULL,
	[MinorProductClass_WhereClauseLike] [varchar](30) NOT NULL,
	[Item_WhereClauseLike] [char](10) NOT NULL,
	[Excl_Code_TargKey] [nchar](20) NOT NULL,
	[Sequence] [int] NOT NULL,
	[RuleName] [varchar](50) NOT NULL,
	[LastReviewed] [date] NOT NULL,
	[Note] [nvarchar](50) NULL,
	[StatusCd] [int] NOT NULL,
 CONSTRAINT [exclusive_product_rule_c_pk] PRIMARY KEY CLUSTERED 
(
	[Supplier_WhereClauseLike] ASC,
	[Brand_WhereClauseLike] ASC,
	[MinorProductClass_WhereClauseLike] ASC,
	[Item_WhereClauseLike] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_Brand]  DEFAULT ('') FOR [Brand_WhereClauseLike]
GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_MinorProductClass]  DEFAULT ('') FOR [MinorProductClass_WhereClauseLike]
GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_RuleOrder]  DEFAULT ((0)) FOR [Sequence]
GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_Note]  DEFAULT ('') FOR [RuleName]
GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_LastReviewDate]  DEFAULT (getdate()) FOR [LastReviewed]
GO

ALTER TABLE [hfm].[exclusive_product_rule] ADD  CONSTRAINT [DF_exclusive_product_rule_StatusCd]  DEFAULT ((0)) FOR [StatusCd]
GO

ALTER TABLE [hfm].[exclusive_product_rule]  WITH CHECK ADD  CONSTRAINT [FK_exclusive_product_rule_exclusive_product] FOREIGN KEY([Excl_Code_TargKey])
REFERENCES [hfm].[exclusive_product] ([Excl_Code])
GO

ALTER TABLE [hfm].[exclusive_product_rule] CHECK CONSTRAINT [FK_exclusive_product_rule_exclusive_product]
GO


CREATE TABLE [Integration].[F0901_account_master](
	[GMCO___company] [char](5) NOT NULL,
	[GMAID__account_id] [char](8) NOT NULL,
	[GMMCU__business_unit] [char](12) NOT NULL,
	[GMOBJ__object_account] [char](6) NOT NULL,
	[GMSUB__subsidiary] [char](8) NOT NULL,
	[GMANS__free_form_3rd_acct_no] [char](25) NOT NULL,
	[GMDL01_description] [char](30) NOT NULL,
	[GMLDA__account_level_of_detail] [char](1) NOT NULL,
	[GMBPC__budget_pattern_code] [char](3) NOT NULL,
	[GMPEC__posting_edit] [char](1) NOT NULL,
	[GMSTPC_type_code] [char](1) NOT NULL,
	[GMFPEC_fixed_asset_posting_edit_code] [char](1) NOT NULL,
	[GMBILL_billable_yn] [char](1) NOT NULL,
	[GMCRCD_currency_code] [char](3) NOT NULL,
	[GMUM___unit_of_measure] [char](2) NOT NULL,
	[GMR001_bill_item_code] [char](3) NOT NULL,
	[GMR002_category_code_002] [char](3) NOT NULL,
	[GMR003_location] [char](3) NOT NULL,
	[GMR004_floor] [char](3) NOT NULL,
	[GMR005_category_code_005] [char](3) NOT NULL,
	[GMR006_category_code_006] [char](3) NOT NULL,
	[GMR007_category_code_007] [char](3) NOT NULL,
	[GMR008_category_code_008] [char](3) NOT NULL,
	[GMR009_category_code_009] [char](3) NOT NULL,
	[GMR010_category_code_010] [char](3) NOT NULL,
	[GMR011_category_code_011] [char](3) NOT NULL,
	[GMR012_category_code_012] [char](3) NOT NULL,
	[GMR013_category_code_013] [char](3) NOT NULL,
	[GMR014_category_code_014] [char](3) NOT NULL,
	[GMR015_category_code_015] [char](3) NOT NULL,
	[GMR016_category_code_016] [char](3) NOT NULL,
	[GMR017_category_code_017] [char](3) NOT NULL,
	[GMR018_category_code_018] [char](3) NOT NULL,
	[GMR019_category_code_019] [char](3) NOT NULL,
	[GMR020_pl_cde_planning] [char](3) NOT NULL,
	[GMR021_category_code_021] [char](10) NOT NULL,
	[GMR022_category_code_022] [char](10) NOT NULL,
	[GMR023_category_code_023] [char](10) NOT NULL,
	[GMOBJA_alternate_object_account] [char](6) NOT NULL,
	[GMSUBA_alternate_subsidiary] [char](8) NOT NULL,
	[GMWCMP_workers_comp] [char](4) NOT NULL,
	[GMCCT__method_of_computation] [char](1) NOT NULL,
	[GMERC__equipment_rate_code] [char](2) NOT NULL,
	[GMHTC__header_type_code] [char](1) NOT NULL,
	[GMQLDA_quantity_rollup_level] [char](1) NOT NULL,
	[GMCCC__cost_code_complete_yn] [char](1) NOT NULL,
	[GMFMOD_model_accountconsolidations] [char](1) NOT NULL,
	[GMDTFR_date_from_JDT] [numeric](6, 0) NOT NULL,
	[GMDTTO_date_thru_JDT] [numeric](6, 0) NOT NULL,
	[GMCEDF_current_effective_date_flag] [char](1) NOT NULL,
	[GMTOBJ_target_object_account] [char](6) NOT NULL,
	[GMTSUB_target_subsidiary] [char](8) NOT NULL,
	[GMTXA1_tax_ratearea] [char](10) NOT NULL,
	[GMEXR1_tax_expl_code] [char](2) NOT NULL,
	[GMTXA2_tax_area_2] [char](10) NOT NULL,
	[GMEXR2_tax_expl_code_2] [char](2) NOT NULL,
	[GMTXGL_gl_account_taxable_flag] [char](1) NOT NULL,
	[GMUSER_user_id] [char](10) NOT NULL,
	[GMPID__program_id] [char](10) NOT NULL,
	[GMJOBN_work_station_id] [char](10) NOT NULL,
	[GMUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[GMUPMT_time_last_updated] [numeric](6, 0) NOT NULL,
 CONSTRAINT [idx_F0901_account_master_c_pk] PRIMARY KEY CLUSTERED 
(
	[GMMCU__business_unit] ASC,
	[GMOBJ__object_account] ASC,
	[GMSUB__subsidiary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

CREATE TABLE [hfm].[account_master_F0901](
	[GMCO___company] [char](5) NOT NULL,
	[GMAID__account_id] [char](8) NOT NULL,
	[GMMCU__business_unit] [char](12) NOT NULL,
	[GMOBJ__object_account] [char](10) NOT NULL, -- 6->10 for RI
	[GMSUB__subsidiary] [char](8) NOT NULL,
	[GMANS__free_form_3rd_acct_no] [char](25) NOT NULL,
	[GMDL01_description] [char](30) NOT NULL,
	[GMLDA__account_level_of_detail] [char](1) NOT NULL,
	[GMBPC__budget_pattern_code] [char](3) NOT NULL,
	[GMPEC__posting_edit] [char](1) NOT NULL,
	[GMSTPC_type_code] [char](1) NOT NULL,
	[GMFPEC_fixed_asset_posting_edit_code] [char](1) NOT NULL,
	[GMBILL_billable_yn] [char](1) NOT NULL,
	[GMCRCD_currency_code] [char](3) NOT NULL,
	[GMUM___unit_of_measure] [char](2) NOT NULL,
	[GMR001_bill_item_code] [char](3) NOT NULL,
	[GMR002_category_code_002] [char](3) NOT NULL,
	[GMR003_location] [char](3) NOT NULL,
	[GMR004_floor] [char](3) NOT NULL,
	[GMR005_category_code_005] [char](3) NOT NULL,
	[GMR006_category_code_006] [char](3) NOT NULL,
	[GMR007_category_code_007] [char](3) NOT NULL,
	[GMR008_category_code_008] [char](3) NOT NULL,
	[GMR009_category_code_009] [char](3) NOT NULL,
	[GMR010_category_code_010] [char](3) NOT NULL,
	[GMR011_category_code_011] [char](3) NOT NULL,
	[GMR012_category_code_012] [char](3) NOT NULL,
	[GMR013_category_code_013] [char](3) NOT NULL,
	[GMR014_category_code_014] [char](3) NOT NULL,
	[GMR015_category_code_015] [char](3) NOT NULL,
	[GMR016_category_code_016] [char](3) NOT NULL,
	[GMR017_category_code_017] [char](3) NOT NULL,
	[GMR018_category_code_018] [char](3) NOT NULL,
	[GMR019_category_code_019] [char](3) NOT NULL,
	[GMR020_pl_cde_planning] [char](3) NOT NULL,
	[GMR021_category_code_021] [char](10) NOT NULL,
	[GMR022_category_code_022] [char](10) NOT NULL,
	[GMR023_category_code_023] [char](10) NOT NULL,
	[GMOBJA_alternate_object_account] [char](6) NOT NULL,
	[GMSUBA_alternate_subsidiary] [char](8) NOT NULL,
	[GMWCMP_workers_comp] [char](4) NOT NULL,
	[GMCCT__method_of_computation] [char](1) NOT NULL,
	[GMERC__equipment_rate_code] [char](2) NOT NULL,
	[GMHTC__header_type_code] [char](1) NOT NULL,
	[GMQLDA_quantity_rollup_level] [char](1) NOT NULL,
	[GMCCC__cost_code_complete_yn] [char](1) NOT NULL,
	[GMFMOD_model_accountconsolidations] [char](1) NOT NULL,
	[GMDTFR_date_from_JDT] [numeric](6, 0) NOT NULL,
	[GMDTTO_date_thru_JDT] [numeric](6, 0) NOT NULL,
	[GMCEDF_current_effective_date_flag] [char](1) NOT NULL,
	[GMTOBJ_target_object_account] [char](6) NOT NULL,
	[GMTSUB_target_subsidiary] [char](8) NOT NULL,
	[GMTXA1_tax_ratearea] [char](10) NOT NULL,
	[GMEXR1_tax_expl_code] [char](2) NOT NULL,
	[GMTXA2_tax_area_2] [char](10) NOT NULL,
	[GMEXR2_tax_expl_code_2] [char](2) NOT NULL,
	[GMTXGL_gl_account_taxable_flag] [char](1) NOT NULL,
	[GMUSER_user_id] [char](10) NOT NULL,
	[GMPID__program_id] [char](10) NOT NULL,
	[GMJOBN_work_station_id] [char](10) NOT NULL,
	[GMUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[GMUPMT_time_last_updated] [numeric](6, 0) NOT NULL,
 CONSTRAINT [account_master_F0901_c_pk] PRIMARY KEY CLUSTERED 
(
	[GMMCU__business_unit] ASC,
	[GMOBJ__object_account] ASC,
	[GMSUB__subsidiary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

-- pop data into prod
INSERT INTO hfm.account_master_F0901
SELECT        Integration.F0901_account_master.*
FROM            Integration.F0901_account_master

INSERT INTO
[dbo].[BRS_BusinessUnit] ([BusinessUnit])
SELECT        distinct GMMCU__business_unit
FROM            hfm.account_master_F0901
WHERE NOT EXISTS 
(SELECT * FROM [dbo].[BRS_BusinessUnit] bu where bu.BusinessUnit = GMMCU__business_unit)


INSERT INTO
[dbo].[BRS_Object]([GLAcctNumberObj])

SELECT        distinct [GMOBJ__object_account]
FROM            hfm.account_master_F0901
WHERE NOT EXISTS 
(SELECT * FROM [dbo].[BRS_Object] ob where ob.[GLAcctNumberObj] = [GMOBJ__object_account])

-- ri
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	FK_account_master_F0901_BRS_BusinessUnit FOREIGN KEY
	(
	GMMCU__business_unit
	) REFERENCES dbo.BRS_BusinessUnit
	(
	BusinessUnit
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	FK_account_master_F0901_BRS_Object FOREIGN KEY
	(
	GMOBJ__object_account
	) REFERENCES dbo.BRS_Object
	(
	GLAcctNumberObj
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

-- Create tables

CREATE TABLE [hfm].[object_to_account_map_rule](
	[DataKey] [int] NOT NULL,
	[RuleName] [nvarchar](30) NOT NULL,
	[RuleCategory] [nvarchar](30) NOT NULL,
	[Rule_WhereClauseLike] [nvarchar](30) NOT NULL,
	[HFM_Account_TargetKey] [nvarchar](30) NOT NULL,
 CONSTRAINT [object_to_account_map_rule_pk] PRIMARY KEY NONCLUSTERED 
(
	[DataKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


/****** Object:  Index [object_map_rule_uc_idx_01]    Script Date: 10/26/2017 7:38:18 PM ******/
CREATE UNIQUE CLUSTERED INDEX [object_to_account_map_rule_uc_idx_01] ON [hfm].[object_to_account_map_rule]
(
	[Rule_WhereClauseLike] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

/****** Object:  Index [object_map_rule_idx_02]    Script Date: 10/26/2017 7:38:18 PM ******/
CREATE NONCLUSTERED INDEX [object_map_rule_idx_02] ON [hfm].[object_to_account_map_rule]
(
	[HFM_Account_TargetKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

CREATE TABLE [hfm].[account](
	[HFM_Account] [nvarchar](30) NOT NULL,
	[Note] [nvarchar](100) NULL,

 CONSTRAINT [account_c_pk] PRIMARY KEY CLUSTERED 
(
	[HFM_Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


CREATE TABLE [hfm].[cost_center](
	[CostCenter] [nvarchar](30) NOT NULL,
	[CostCenterDescr] [nvarchar](75) NOT NULL,
	[CostCenterParent] [nvarchar](30) NOT NULL,
	[LevelNum] [smallint] NOT NULL,
	[ActiveInd] [bit] NOT NULL,
	[Note] [nvarchar](100) NULL,
 CONSTRAINT [cost_center_c_pk] PRIMARY KEY CLUSTERED 
(
	[CostCenter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [hfm].[cost_center] ADD  CONSTRAINT [DF_cost_center_LevelNum]  DEFAULT ((0)) FOR [LevelNum]
GO

ALTER TABLE [hfm].[cost_center] ADD  CONSTRAINT [DF_cost_center_ActiveInd]  DEFAULT ((0)) FOR [ActiveInd]
GO

Alter Table [hfm].[cost_center]
Add CostCenterKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX cost_center_u_idx ON [hfm].[cost_center]
	(
	CostCenterKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



-- ri

BEGIN TRANSACTION
GO
ALTER TABLE hfm.exclusive_product ADD CONSTRAINT
	FK_exclusive_product_BRS_FiscalMonth FOREIGN KEY
	(
	EffectivePeriod
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE hfm.exclusive_product ADD CONSTRAINT
	FK_exclusive_product_BRS_FiscalMonth1 FOREIGN KEY
	(
	ExpiredPeriod
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE hfm.exclusive_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


---



BEGIN TRANSACTION
GO
ALTER TABLE hfm.business_unit_to_cost_center_map ADD CONSTRAINT
	FK_business_unit_to_cost_center_map_BRS_BusinessUnit FOREIGN KEY
	(
	BusinessUnit
	) REFERENCES dbo.BRS_BusinessUnit
	(
	BusinessUnit
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.business_unit_to_cost_center_map ADD CONSTRAINT
	FK_business_unit_to_cost_center_map_cost_center FOREIGN KEY
	(
	CostCenter
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.business_unit_to_cost_center_map SET (LOCK_ESCALATION = TABLE)
GO

COMMIT

ALTER TABLE hfm.cost_center ADD CONSTRAINT
	FK_cost_center_cost_center1 FOREIGN KEY
	(
	CostCenterParent
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE hfm.object_to_account_map_rule ADD CONSTRAINT
	FK_object_map_rule_cost_center FOREIGN KEY
	(
	HFM_Account_TargetKey
	) REFERENCES [hfm].[account]
	(
	[HFM_Account]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 	
GO


ALTER TABLE hfm.account_master_F0901 ADD
	HFM_CostCenter nvarchar(30) NULL,
	HFM_Account nvarchar(30) NULL,
	LastUpdated date NULL
GO


ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	FK_account_master_F0901_cost_center FOREIGN KEY
	(
	HFM_CostCenter
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	FK_account_master_F0901_account FOREIGN KEY
	(
	[HFM_Account]
	) REFERENCES hfm.account
	(
	[HFM_Account]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE [dbo].[BRS_ItemHistory] ADD CONSTRAINT
	FK_BRS_ItemHistory_exclusive_product FOREIGN KEY
	(
	[Excl_Key]
	) REFERENCES [hfm].[exclusive_product]
	(
	[Excl_Key]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- add 204012 end date

INSERT INTO BRS_FiscalMonth
                         (FiscalMonth, BeginDt, EndDt, LastWorkingDt)
VALUES        (204012, CONVERT(DATETIME, '2040-12-01 00:00:00', 102), CONVERT(DATETIME, '2040-12-31 00:00:00', 102), CONVERT(DATETIME, '2040-12-31 00:00:00', 102))

ALTER TABLE hfm.object_to_account_map_rule ADD
	ActiveInd bit NOT NULL CONSTRAINT DF_object_to_account_map_rule_ActiveInd DEFAULT (1)
GO

ALTER TABLE hfm.account ADD
GLOBJ_Type nchar(1) NOT NULL CONSTRAINT DF_account_GLOBJ_Type DEFAULT ('')
GO

/*
SELECT        MinorProductClass
FROM            BRS_ItemCategory
WHERE MinorProductClass like '372-0[1 2 3]%'
*/

/*
-- test rule map for dups
SELECT 
(RTRIM([GMMCU__business_unit])+
RTRIM([GMOBJ__object_account])+
RTRIM([GMSUB__subsidiary])) as glbu
/*
,Rule_WhereClauseLike
,HFM_Account_TargetKey
,REPLACE(REPLACE(Rule_WhereClauseLike, '?', '_'), '*', '%') AS tn
*/
,COUNT(*)
,MIN([RuleName])
,MAX([RuleName])
,MIN(HFM_Account_TargetKey)
,MAX(HFM_Account_TargetKey)
,MIN(datakey)
,MAX(datakey)

FROM
	[hfm].[account_master_F0901] a

	INNER JOIN hfm.object_to_account_map_rule m
	ON (RTRIM([GMMCU__business_unit])+
		RTRIM([GMOBJ__object_account])+
		RTRIM([GMSUB__subsidiary])) like 
		REPLACE(REPLACE(Rule_WhereClauseLike, '?', '_'), '*', '%')
WHERE
	ActiveInd = 1
GROUP BY
(RTRIM([GMMCU__business_unit])+
RTRIM([GMOBJ__object_account])+
RTRIM([GMSUB__subsidiary])) 
HAVING 
COUNT(*) > 1
ORDER BY 7,8

*/

-- fix missing BU map
UPDATE       BRS_BusinessUnit
SET                GLBU_Class = 'PARTS'
WHERE        (BusinessUnit IN ('020022001101', '020022001102', '020022001104', '020022001113'))

-- update Obj map
UPDATE       hfm.account_master_F0901
SET                HFM_Account = [HFM_Account_TargetKey]
FROM            hfm.account_master_F0901 INNER JOIN
                         hfm.object_to_account_map_rule AS m ON 
                         hfm.account_master_F0901.GMMCU__business_unit + hfm.account_master_F0901.GMOBJ__object_account + hfm.account_master_F0901.GMSUB__subsidiary LIKE
                          REPLACE(REPLACE(m.Rule_WhereClauseLike, '?', '_'), '*', '%')
WHERE        (m.ActiveInd = 1)


/*
-- objects used
truncate table [dbo].[zzzItem]
INSERT INTO [zzzItem] (Item)
select distinct [GLAcctNumberObjSales] from [dbo].[BRS_Transaction]
UNION
select distinct [GLAcctNumberObjCost] from [dbo].[BRS_Transaction]
*/

/*
--find obj map gaps

SELECT        a.GMMCU__business_unit, a.GMOBJ__object_account, a.GMSUB__subsidiary, a.HFM_Account, o.GLOBJ_Name, o.GLOBJ_Type
FROM            hfm.account_master_F0901 AS a INNER JOIN
                         BRS_Object AS o ON a.GMOBJ__object_account = o.GLAcctNumberObj
WHERE        ((o.GLOBJ_Type <> '' )) AND (a.HFM_Account IS NULL) AND
EXISTS (SELECT * FROM zzzItem where Item = a.GMOBJ__object_account)

-- set object type sales or cost

UPDATE       hfm.account
SET                GLOBJ_Type = o.GLOBJ_Type
FROM            hfm.account_master_F0901 AS a INNER JOIN
                         BRS_Object AS o ON a.GMOBJ__object_account = o.GLAcctNumberObj INNER JOIN
                         hfm.account ON a.HFM_Account = hfm.account.HFM_Account
WHERE        (o.GLOBJ_Type <> '')

*/

/*
-- objects used
CREATE TABLE dbo.#bu 
   ( 
   bu varchar(20)
   ) 

INSERT INTO [#bu] (bu)
select distinct [BusinessUnitSales] from [dbo].[BRS_Transaction]
UNION
select distinct [BusinessUnitCost] from [dbo].[BRS_Transaction]
Where [BusinessUnitSales] <> ''


SELECT        a.GMMCU__business_unit, a.GMOBJ__object_account, a.GMSUB__subsidiary, a.HFM_Account, a.HFM_CostCenter, b.GLBU_Class
FROM            hfm.account_master_F0901 AS a INNER JOIN
                         BRS_BusinessUnit AS b ON a.GMMCU__business_unit = b.BusinessUnit
WHERE        
EXISTS (SELECT * FROM #bu where bu = a.GMMCU__business_unit) AND

-- b.GLBU_Class = '' AND 
a.HFM_Account is not null and
--((o.GLOBJ_Type <> '' )) AND (a.HFM_Account IS NULL) AND
1=1
ORDER BY 5

-- DROP TABLE dbo.[#bu]
*/

SELECT        
	a.GMDL01_description, 
	a.GMMCU__business_unit, 
	a.GMOBJ__object_account, 
	a.GMSUB__subsidiary, 
	a.HFM_Account, 
	b.GLBU_Class, 
	aa.GLOBJ_Type, 
	a.HFM_CostCenter
FROM            
	hfm.account_master_F0901 AS a 
	INNER JOIN BRS_BusinessUnit AS b 

	ON a.GMMCU__business_unit = b.BusinessUnit 
	INNER JOIN hfm.account AS aa 
	ON a.HFM_Account = aa.HFM_Account AND a.HFM_Account = aa.HFM_Account
WHERE        
	a.HFM_Account <>'' AND
	GLBU_Class <>'' AND
	(1 = 1)
ORDER BY 
	aa.GLOBJ_Type

-- test exclusive map

SELECT       
	r.Excl_Code_TargKey
	,i.ItemDescription
	,i.Supplier
	,i.Brand
	,i.Item
	,i.Label
	,i.Est12MoSales
FROM            
	BRS_Item AS i 

	INNER JOIN hfm.exclusive_product_rule AS r 
	ON 
		i.Supplier				like RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand					like RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass		like RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item					like RTRIM(r.Item_WhereClauseLike) AND
		1=1
WHERE
	r.StatusCd = 1 AND
	label = 'p' AND
--	Excl_Code_TargKey like 'CAO%' AND
--	item in ('5848072'   , '5950085'   ) AND
	1=1

-- test bu map vs glbu actual consistency
SELECT        t.SalesOrderNumberKEY, t.DocType, t.LineNumber, t.BusinessUnitSales, t.GLBU_Class, b.GLBU_Class
FROM            BRS_Transaction AS t INNER JOIN
                         BRS_BusinessUnit AS b ON t.BusinessUnitSales = b.BusinessUnit
WHERE        
	DocType <>'AA' AND
	t.GLBU_Class <> 'SMEQU' AND
	(t.GLBU_Class <> b.GLBU_Class)

CREATE TABLE [hfm].[business_unit_hfm_account_to_cost_center_map](
	[business_unit] [char](12) NOT NULL,
	[HFM_Account] [nvarchar](30) NOT NULL,
	[CostCenter] [nvarchar](30) NOT NULL,

	Note nvarchar(50) NULL

 CONSTRAINT [business_unit_hfm_account_to_cost_center_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[business_unit] ASC,
	[HFM_Account]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

-- add ri
ALTER TABLE hfm.business_unit_hfm_account_to_cost_center_map ADD CONSTRAINT
	FK_business_unit_hfm_account_to_cost_center_map_BRS_BusinessUnit FOREIGN KEY
	(
	business_unit
	) REFERENCES dbo.BRS_BusinessUnit
	(
	BusinessUnit
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.business_unit_hfm_account_to_cost_center_map ADD CONSTRAINT
	FK_business_unit_hfm_account_to_cost_center_map_account FOREIGN KEY
	(
	HFM_Account
	) REFERENCES hfm.account
	(
	HFM_Account
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.business_unit_hfm_account_to_cost_center_map ADD CONSTRAINT
	FK_business_unit_hfm_account_to_cost_center_map_cost_center FOREIGN KEY
	(
	CostCenter
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- mapping - fix this
UPDATE       hfm.account_master_F0901
SET                HFM_CostCenter = m.CostCenter, [LastUpdated]  = getdate()

FROM            
hfm.business_unit_hfm_account_to_cost_center_map m 
INNER JOIN hfm.account_master_F0901 

ON hfm.account_master_F0901.[GMMCU__business_unit] = m.business_unit AND 
	hfm.account_master_F0901.HFM_Account = m.[HFM_Account]

