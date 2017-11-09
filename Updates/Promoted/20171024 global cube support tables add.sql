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

-- test comp

select  distinct FiscalMonth, Item
from BRS_Transaction t
where 
	t.FiscalMonth < 201711 AND
NOT exists (

SELECT        *
FROM            BRS_ItemHistory h
where h.FiscalMonth = t.FiscalMonth and h.Item = t.Item
)

-- 30 sec
UPDATE       BRS_ItemHistory
SET                
MinorProductClass = BRS_Item.MinorProductClass , 
Label = BRS_Item.Label, 
Brand = BRS_Item.Brand

FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item ON BRS_ItemHistory.Item = BRS_Item.Item
/*


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

---

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
SELECT        DEV_BRSales.Integration.F0901_account_master.*
FROM            DEV_BRSales.Integration.F0901_account_master

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

-- pop rules here

INSERT INTO hfm.exclusive_product
                         (Excl_Code, Excl_Name, BrandEquityCategory, ProductCategory, Owner, DataContact, DataSourceCode, Note, LastReviewed, EffectivePeriod, ExpiredPeriod )
SELECT        Excl_Code, Excl_Name, BrandEquityCategory, ProductCategory, Owner, DataContact, DataSourceCode, Note, LastReviewed, EffectivePeriod, ExpiredPeriod 
FROM            DEV_BRSales.hfm.exclusive_product AS exclusive_product_1 WHERE Excl_kEY > 2


INSERT INTO hfm.exclusive_product_rule
                         (Supplier_WhereClauseLike, Brand_WhereClauseLike, MinorProductClass_WhereClauseLike, Item_WhereClauseLike, Excl_Code_TargKey, Sequence, RuleName, 
                         LastReviewed, Note, StatusCd)
SELECT        Supplier_WhereClauseLike, Brand_WhereClauseLike, MinorProductClass_WhereClauseLike, Item_WhereClauseLike, Excl_Code_TargKey, Sequence, RuleName, 
                         LastReviewed, Note, StatusCd
FROM            DEV_BRSales.hfm.exclusive_product_rule AS exclusive_product_rule_1

-- hfm account add

INSERT INTO hfm.account
                         (HFM_Account, Note, GLOBJ_Type)
SELECT        HFM_Account, Note, GLOBJ_Type
FROM            DEV_BRSales.hfm.account AS account_1


INSERT INTO hfm.object_to_account_map_rule
                         (DataKey, RuleName, RuleCategory, Rule_WhereClauseLike, HFM_Account_TargetKey, ActiveInd)
SELECT        DataKey, RuleName, RuleCategory, Rule_WhereClauseLike, HFM_Account_TargetKey, ActiveInd
FROM            DEV_BRSales.hfm.object_to_account_map_rule AS object_to_account_map_rule_1


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

-- test exclusive map overlap with private

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

-- update exec (rough , working)

-- update Branded
UPDATE
	BRS_ItemHistory
SET
	Excl_key = Null
FROM
	BRS_ItemHistory 

UPDATE       
	BRS_ItemHistory
SET
	Excl_key = p.[Excl_Key]
FROM
	BRS_ItemHistory 
	INNER JOIN hfm.exclusive_product_rule AS r 
	ON BRS_ItemHistory.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		BRS_ItemHistory.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		BRS_ItemHistory.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		BRS_ItemHistory.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  
WHERE        
	(r.StatusCd = 1) AND 
	(BRS_ItemHistory.FiscalMonth BETWEEN p.EffectivePeriod AND p.ExpiredPeriod)

-- update private
UPDATE
	BRS_ItemHistory
SET
	Excl_key = 1
FROM
	BRS_ItemHistory 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON mpc.MajorProductClass = LEFT(BRS_ItemHistory.MinorProductClass, 3)

WHERE
	(BRS_ItemHistory.Label = 'P') AND 
	(mpc.PrivateLabelScopeInd = 1) AND 
	(BRS_ItemHistory.Excl_key IS NULL)

-- update Branded
UPDATE
	BRS_ItemHistory
SET
	Excl_key = 2
FROM
	BRS_ItemHistory 
WHERE Excl_key IS NULL

-- update Corp and Branch names manually

-- test bu map vs glbu actual consistency
/*
SELECT        t.SalesOrderNumberKEY, t.DocType, t.LineNumber, t.BusinessUnitSales, t.GLBU_Class, b.GLBU_Class
FROM            BRS_Transaction AS t INNER JOIN
                         BRS_BusinessUnit AS b ON t.BusinessUnitSales = b.BusinessUnit
WHERE        
	DocType <>'AA' AND
	t.GLBU_Class <> 'SMEQU' AND
	(t.GLBU_Class <> b.GLBU_Class)
*/

-- Add Cost Center to BU
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnit ADD
	CostCenter nvarchar(30) NOT NULL CONSTRAINT DF_BRS_BusinessUnit_CostCenter DEFAULT (''),
	Note nvarchar(50) NULL
GO
--- pull ccs.

INSERT INTO hfm.cost_center
                         (CostCenter, CostCenterDescr, CostCenterParent, LevelNum, ActiveInd, Note)
SELECT        CostCenter, CostCenterDescr, CostCenterParent, LevelNum, ActiveInd, Note
FROM            DEV_BRSales.hfm.cost_center AS cost_center_1


ALTER TABLE dbo.BRS_BusinessUnit ADD CONSTRAINT
	FK_BRS_BusinessUnit_cost_center FOREIGN KEY
	(
	CostCenter
	) REFERENCES hfm.cost_center
	(
	CostCenter
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_BusinessUnit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update cost center map with BU -> 'CC' + BU

UPDATE       BRS_BusinessUnit
SET                CostCenter = 'CC' + [BusinessUnit]
WHERE        (BusinessUnit <> '') AND EXISTS 
(SELECT * FROM [hfm].[cost_center] c WHERE c.CostCenter = ('CC' + [BusinessUnit]))


select top 10 [BusinessUnit], 'CC' + [BusinessUnit] from [dbo].[BRS_BusinessUnit]
WHERE [BusinessUnit] <>'' 
/*

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

*/

-- mapping - fix this
UPDATE       hfm.account_master_F0901
SET                HFM_CostCenter = b.CostCenter, [LastUpdated]  = getdate()

FROM            
[dbo].[BRS_BusinessUnit] b 
INNER JOIN hfm.account_master_F0901 m

ON m.[GMMCU__business_unit] = b.BusinessUnit 
WHERE b.CostCenter <>''


ALTER TABLE dbo.BRS_Transaction
	DROP CONSTRAINT DF_BRS_Transaction_GLAcctNumberSales
GO
ALTER TABLE dbo.BRS_Transaction
	DROP CONSTRAINT DF_BRS_Transaction_GLAcctNumberCost
GO
ALTER TABLE dbo.BRS_Transaction
	DROP COLUMN GLAcctNumberSales, GLAcctNumberCost
GO

ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_SalesDivision char(3) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_SalesDivision DEFAULT ('')
GO

-- ri
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_SalesDivision FOREIGN KEY
	(
	HIST_SalesDivision
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- update

UPDATE       BRS_CustomerFSC_History
SET                HIST_SalesDivision = SalesDivision
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_Customer ON BRS_CustomerFSC_History.Shipto = BRS_Customer.ShipTo

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD

	GL_Subsidiary_Sales char(8) NOT NULL CONSTRAINT DF_BRS_Transaction_GL_Subsidiary_Sales DEFAULT (''),
	GL_Subsidiary_Cost char(8) NOT NULL CONSTRAINT DF_BRS_Transaction_GL_Subsidiary_Cost DEFAULT (''),
	GL_Subsidiary_ChargeBack char(8) NOT NULL CONSTRAINT DF_BRS_Transaction_GL_Subsidiary_ChargeBack DEFAULT (''),
	GL_Object_ChargeBack char(10) NOT NULL CONSTRAINT DF_BRS_Transaction_GL_Object_ChargeBack DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.BusinessUnitSales', N'Tmp_GL_BusinessUnit_Sales', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.BusinessUnitCost', N'Tmp_GL_BusinessUnit_Cost_1', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.GLAcctNumberObjSales', N'Tmp_GL_Object_Sales_2', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.GLAcctNumberObjCost', N'Tmp_GL_Object_Cost_3', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.Tmp_GL_BusinessUnit_Sales', N'GL_BusinessUnit', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.Tmp_GL_BusinessUnit_Cost_1', N'GL_BusinessUnit_Cost', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.Tmp_GL_Object_Sales_2', N'GL_Object_Sales', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Transaction.Tmp_GL_Object_Cost_3', N'GL_Object_Cost', 'COLUMN' 
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--- out with the old!  1 min per month
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201401
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201402
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201403
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201404
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201405
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201406
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201407
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201408
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201409
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201410
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201411
GO
DELETE FROM [dbo].[BRS_Transaction] WHERE [FiscalMonth] = 201412
GO



-- check sales
SELECT        TOP (10) FiscalMonth, SalesOrderNumberKEY, DocType, LineNumber, GL_BusinessUnit_Sales, GL_Object_Sales, GL_Subsidiary_Sales
FROM            BRS_Transaction AS t
WHERE        (FiscalMonth >= 201501) AND  DocType <>'AA' AND
NOT EXISTS (
SELECT * FROM [hfm].[account_master_F0901] 
WHERE [GMMCU__business_unit]= GL_BusinessUnit_Sales AND
[GMOBJ__object_account] = GL_Object_Sales AND 
[GMSUB__subsidiary] = GL_Subsidiary_Sales
)


-- check costs
SELECT         FiscalMonth, SalesOrderNumberKEY, DocType, LineNumber, GL_BusinessUnit_Cost, GL_Object_Cost, GL_Subsidiary_Cost,
LEFT(GL_Object_Cost,4), SUBSTRING(GL_Object_Cost,6,4) s
FROM            BRS_Transaction AS t
WHERE        (FiscalMonth >= 201501) AND  DocType <>'AA' AND
NOT EXISTS (
SELECT * FROM [hfm].[account_master_F0901] 
WHERE [GMMCU__business_unit]= GL_BusinessUnit_Cost AND
[GMOBJ__object_account] = GL_Object_Cost AND 
[GMSUB__subsidiary] = GL_Subsidiary_Cost
)

-- fix costs - split subobj
UPDATE       BRS_Transaction
SET                GL_Object_Cost = LEFT(GL_Object_Cost,4), GL_Subsidiary_Cost = SUBSTRING(GL_Object_Cost,6,4)
WHERE        (FiscalMonth >= 201501) AND (DocType <> 'AA') AND (NOT EXISTS
                             (SELECT        *
                               FROM            hfm.account_master_F0901
                               WHERE        (GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit_Cost) AND (GMOBJ__object_account = BRS_Transaction.GL_Object_Cost) AND 
                                                         (GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_Cost)))


-- test BU S & C sym

SELECT        FiscalMonth, SalesOrderNumberKEY, DocType, GLBU_Class, LineNumber, GL_BusinessUnit_Sales, GL_BusinessUnit_Cost, GL_Object_Sales, 
                         GL_Object_Cost, [NetSalesAmt], [ExtendedCostAmt]
FROM            BRS_Transaction
WHERE        (DocType <> 'AA') AND (GL_BusinessUnit_Sales <> GL_BusinessUnit_Cost) 

AND SalesOrderNumberKEY = 8320759

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction
	DROP CONSTRAINT FK_BRS_Transaction_BRS_BusinessUnit
GO
ALTER TABLE dbo.BRS_Transaction
	DROP CONSTRAINT FK_BRS_Transaction_BRS_BusinessUnit1
GO
ALTER TABLE dbo.BRS_BusinessUnit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE [dbo].[BRS_Transaction] DROP CONSTRAINT [DF_BRS_Transaction_BusinessUnitCost]
GO
ALTER TABLE [dbo].[BRS_Transaction] DROP COLUMN [GL_BusinessUnit_Cost]
GO



UPDATE       BRS_Branch
SET                AccountingCode = '11'
WHERE        (Branch = 'NWFLD')

UPDATE       BRS_Branch
SET                AccountingCode = '00'
WHERE        (Branch = 'CORP')

UPDATE       BRS_Branch
SET                AccountingCode = '00'
WHERE        (Branch = 'ZCORP')

UPDATE       BRS_Branch
SET                AccountingCode = '00'
WHERE        (Branch = 'MEDIC')

-- setup map table
UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '', GL_Object_Cost = '', GL_Object_Sales = ''

-- drop table Integration.ajustment_glbu_map

SELECT        GLBU_Class, Branch, SalesDivision, space(12) AS GL_BusinessUnit, space(4) AS GL_Object_Cost, space(4) AS GL_Object_Sales
INTO              Integration.ajustment_glbu_map
FROM            BRS_Transaction
WHERE        (DocType = 'AA')
GROUP BY GLBU_Class, Branch, SalesDivision

ALTER TABLE Integration.ajustment_glbu_map ADD CONSTRAINT
	PK_ajustment_glbu_map PRIMARY KEY CLUSTERED 
	(
	GLBU_Class,
	Branch,
	SalesDivision
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO



UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = zzzItem.Note1
FROM            Integration.ajustment_glbu_map INNER JOIN
                         zzzItem ON Integration.ajustment_glbu_map.GLBU_Class = zzzItem.Item

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020017000000'
WHERE        (GLBU_Class = 'MERCH') AND (SalesDivision = 'AAL')

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020017000000'
WHERE        (GLBU_Class = 'REBAT') AND (SalesDivision = 'AAL')

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020017000500'
WHERE        (GLBU_Class = 'PROME') AND (SalesDivision = 'AAL')

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '0200010010'
WHERE        (GLBU_Class = 'PROMC') AND (SalesDivision <> 'AAL')

UPDATE       Integration.ajustment_glbu_map
SET                 GL_BusinessUnit = RTRIM(m.GL_BusinessUnit)+b.AccountingCode
FROM            Integration.ajustment_glbu_map m INNER JOIN
                         BRS_Branch AS b ON m.Branch = b.Branch
WHERE        (LEN(m.GL_BusinessUnit) = 10)


UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Cost] = '4515'


UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Sales] = '4320'
WHERE        (GLBU_Class LIKE 'PROM%')

UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Sales] = '4300'
WHERE        (GLBU_Class = 'REBAT')

UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Sales] = '4200'
WHERE        (GLBU_Class IN ('FREIG', 'FRTEQ'))

UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Sales] = '4147'
WHERE        (GLBU_Class IN ('ALLOM', 'ALLOT', 'ALLOE'))

UPDATE       Integration.ajustment_glbu_map
SET                [GL_Object_Sales] = '4130'
WHERE        ([GL_Object_Sales] ='')



SELECT        Integration.ajustment_glbu_map.GLBU_Class, Integration.ajustment_glbu_map.Branch, Integration.ajustment_glbu_map.SalesDivision, 
                         Integration.ajustment_glbu_map.GL_BusinessUnit
FROM            Integration.ajustment_glbu_map LEFT OUTER JOIN
                         BRS_BusinessUnit ON Integration.ajustment_glbu_map.GL_BusinessUnit = BRS_BusinessUnit.BusinessUnit
WHERE        (BRS_BusinessUnit.BusinessUnit IS NULL)
order by 4

SELECT        Integration.ajustment_glbu_map.GLBU_Class, Integration.ajustment_glbu_map.Branch, Integration.ajustment_glbu_map.SalesDivision, 
                         Integration.ajustment_glbu_map.GL_BusinessUnit, Integration.ajustment_glbu_map.GL_Object_Sales
FROM            Integration.ajustment_glbu_map LEFT OUTER JOIN
                         BRS_Object ON Integration.ajustment_glbu_map.GL_Object_Sales = BRS_Object.GLAcctNumberObj
WHERE        (BRS_Object.GLAcctNumberObj IS NULL)
ORDER BY Integration.ajustment_glbu_map.GL_BusinessUnit

-- fix inconsistent corp mapping

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020009000100'
WHERE        (GL_BusinessUnit = '020009001000') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020009000000'
WHERE        (GL_BusinessUnit = '020009001100') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020020001016'
WHERE        (GL_BusinessUnit = '020020001000') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020051001017'
WHERE        (GL_BusinessUnit = '020051001000') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020060001017'
WHERE        (GL_BusinessUnit = '020060001000') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020061001017'
WHERE        (GL_BusinessUnit = '020061001000') 



UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020062001017'
WHERE        (GL_BusinessUnit = '020062001000') 



UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020063001017'
WHERE        (GL_BusinessUnit = '020063001000') 

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020001000000'
WHERE        (GL_BusinessUnit = '020001001000') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020020001007'
WHERE        (GL_BusinessUnit = '020001001007') 

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020020001010'
WHERE        (GL_BusinessUnit = '020001001010') 

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020020001011'
WHERE        (GL_BusinessUnit = '020001001011') 

---

UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020001001007'
WHERE        (GL_BusinessUnit = '020020001007') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020001001010'
WHERE        (GL_BusinessUnit = '020020001010') 


UPDATE       Integration.ajustment_glbu_map
SET                GL_BusinessUnit = '020001001011'
WHERE        (GL_BusinessUnit = '020020001011') 

SELECT * FROM [dbo].[BRS_BusinessUnit]
WHERE [BusinessUnit] = '020001001007' OR  GLBU_CLASS = 'MERCH'

SELECT [GMMCU__business_unit],[GMOBJ__object_account],[GMSUB__subsidiary],[GMDL01_description]    
FROM [hfm].[account_master_F0901]
WHERE [GMOBJ__object_account] = '4320' AND [GMMCU__business_unit] LIKE '%10'


 
/*

GLBU_Class Branch SalesDivision GL_BusinessUnit GL_Object_Sales
---------- ------ ------------- --------------- ---------------
PROMM      LONDN  AAD           020001001007    4320
PROME      LONDN  AAD           020001001007    4320
PROMM      HALFX  AAD           020001001010    4320
PROME      HALFX  AAD           020001001010    4320

GLBU_Class Branch SalesDivision GL_BusinessUnit GL_Object_Sales
---------- ------ ------------- --------------- ---------------
REBAT      LONDN  AAD           020020001007    4300 to 020001001007
REBAT      HALFX  AAD           020020001010    4300 to 020001001010
REBAT      NWFLD  AAD           020020001011    4300 to 020001001011
GLBU_Class Branch SalesDivision GL_BusinessUnit GL_Object_Sales
---------- ------ ------------- --------------- ---------------
PROMM      LONDN  AAD           020001001007    4320  TO 020020001007
PROME      LONDN  AAD           020001001007    4320  TO 020020001007
PROMM      HALFX  AAD           020001001010    4320  to 020020001010
PROME      HALFX  AAD           020001001010    4320
PROMM      NWFLD  AAD           020001001011    4320  to 020020001011
PROMM      SJOHN  AAD           020001001011    4320
PROME      SJOHN  AAD           020001001011    4320
*/

-- update bu, obj, sales & costs

-- check

-- pull Integration.ajustment_glbu_map from dev


CREATE TABLE [Integration].[ajustment_glbu_map](
	[GLBU_Class] [char](5) NOT NULL,
	[Branch] [char](5) NOT NULL,
	[SalesDivision] [char](3) NOT NULL,
	[GL_BusinessUnit] [varchar](12) NULL,
	[GL_Object_Cost] [varchar](4) NULL,
	[GL_Object_Sales] [varchar](4) NULL,
	[GL_Subsidiary_Sales] [varchar](4) NULL,
 CONSTRAINT [PK_ajustment_glbu_map] PRIMARY KEY CLUSTERED 
(
	[GLBU_Class] ASC,
	[Branch] ASC,
	[SalesDivision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [Integration].[ajustment_glbu_map] ADD  CONSTRAINT [DF_ajustment_glbu_map_GL_Subsidiary_Sales]  DEFAULT ('') FOR [GL_Subsidiary_Sales]
GO


INSERT INTO Integration.adjustment_glbu_map
                         (GLBU_Class, Branch, SalesDivision, GL_BusinessUnit, GL_Object_Cost, GL_Object_Sales, GL_Subsidiary_Sales)
SELECT        GLBU_Class, Branch, SalesDivision, GL_BusinessUnit, GL_Object_Cost, GL_Object_Sales, GL_Subsidiary_Sales
FROM            DEV_BRSales.Integration.ajustment_glbu_map AS ajustment_glbu_map_1



-- these s/b zero


SELECT        top 10 t.fiscalmonth, t.branch, t.GLBU_Class, t.GL_BusinessUnit, t.GL_Object_Sales, t.GL_Object_Cost, m.GL_BusinessUnit AS new_bu, m.GL_Object_Cost AS new_obj_cost, m.GL_Object_Sales AS new_obj_sales, [GL_Object_ChargeBack] as new_obj_cb
FROM            Integration.adjustment_glbu_map AS m INNER JOIN
BRS_Transaction AS t 

ON m.GLBU_Class = t.GLBU_Class AND 
m.Branch = t.Branch AND 
m.SalesDivision = t.SalesDivision

WHERE        (t.DocType = 'AA') AND 
(
t.GL_BusinessUnit <> m.GL_BusinessUnit OR
t.GL_Object_Sales <> m.GL_Object_Sales OR
t.GL_Object_Cost <> m.GL_Object_Cost OR
t.[GL_Subsidiary_Sales] <> m.[GL_Subsidiary_Sales]
)

-- chargeback
SELECT        top 10 FiscalMonth, Branch, GLBU_Class, GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, ExtChargebackAmt, [GL_Object_ChargeBack] as new_obj_cb
FROM            BRS_Transaction AS t
WHERE        ( ExtChargebackAmt <> 0) and GL_Object_ChargeBack is null

-- do it!

UPDATE       BRS_Transaction
SET                
GL_BusinessUnit = m.GL_BusinessUnit, 
GL_Object_Sales = m.GL_Object_Sales, 
GL_Object_Cost = m.GL_Object_Cost,
[GL_Subsidiary_Sales] = m.[GL_Subsidiary_Sales]

FROM            Integration.adjustment_glbu_map AS m INNER JOIN
                         BRS_Transaction t ON m.GLBU_Class = t.GLBU_Class AND m.Branch = t.Branch AND 
                         m.SalesDivision = t.SalesDivision AND 
(
t.GL_BusinessUnit <> m.GL_BusinessUnit OR
t.GL_Object_Sales <> m.GL_Object_Sales OR
t.GL_Object_Cost <> m.GL_Object_Cost OR
t.[GL_Subsidiary_Sales] <> m.[GL_Subsidiary_Sales]
)
WHERE        (t.DocType = 'AA')

UPDATE       BRS_Transaction
SET                GL_Object_ChargeBack = '4730'
WHERE        (ExtChargebackAmt <> 0)


BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_Transaction_idx_17 ON dbo.BRS_Transaction
	(
	GL_BusinessUnit
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX BRS_Transaction_idx_18 ON dbo.BRS_Transaction
	(
	GL_Object_Sales
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- ri

-- rule exceptions

SELECT        FiscalMonth, SalesOrderNumberKEY, DocType, LineNumber, GL_BusinessUnit, GL_Object_Sales, GL_Subsidiary_Sales
FROM            BRS_Transaction AS t
WHERE DocType = 'aa' and
NOT EXISTS 
(SELECT * FROM [Integration].[adjustment_glbu_map] m 
where 
t.[GLBU_Class] = m.[GLBU_Class] AND
t.[Branch] =  m.[Branch] AND
t.[SalesDivision] = m.[SalesDivision]
)

-- RI test - transaction exceptions should be zero
SELECT        FiscalMonth, SalesOrderNumberKEY, DocType, LineNumber, Branch, SalesDivision, [GLBU_Class], GL_BusinessUnit, GL_Object_Sales, GL_Subsidiary_Sales
FROM            BRS_Transaction AS t
WHERE 
NOT EXISTS 
(SELECT * FROM hfm.account_master_F0901 h 
where GL_BusinessUnit = [GMMCU__business_unit] and  
GL_Object_Sales = [GMOBJ__object_account] and  
 GL_Subsidiary_Sales = [GMSUB__subsidiary] and
1=1
)

-- costs
SELECT        FiscalMonth, SalesOrderNumberKEY, DocType, LineNumber, Branch, SalesDivision, [GLBU_Class], GL_BusinessUnit, GL_Object_Sales, GL_Subsidiary_Sales, GL_Object_Cost, GL_Subsidiary_Cost, id
FROM            BRS_Transaction AS t
WHERE 
NOT EXISTS 
(SELECT * FROM hfm.account_master_F0901 h 
where GL_BusinessUnit = [GMMCU__business_unit] and  
GL_Object_Cost = [GMOBJ__object_account] and  
 GL_Subsidiary_Cost = [GMSUB__subsidiary] and
1=1
)



-- master account lookup
SELECT * FROM hfm.account_master_F0901 h 
where [GMMCU__business_unit] like '%' and  
[GMOBJ__object_account] = '4320' and  
-- [GMSUB__subsidiary] = '' and
 1=1

 -- rule lookup

SELECT        GLBU_Class, Branch, SalesDivision, GL_BusinessUnit, GL_Object_Cost, GL_Object_Sales, GL_Subsidiary_Sales, GL_Subsidiary_Cost
FROM            Integration.ajustment_glbu_map
WHERE        (Branch = 'CALGY') AND (SalesDivision = 'AAD') AND (GLBU_Class = 'PROME')

UPDATE       Integration.ajustment_glbu_map
SET                GL_Object_Sales = ''
WHERE        (GL_Object_Sales IS NULL)


-- add RI when data is good

ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_account_master_F0901_sales FOREIGN KEY
	(
	GL_BusinessUnit,
	GL_Object_Sales,
	GL_Subsidiary_Sales
	) REFERENCES hfm.account_master_F0901
	(
	GMMCU__business_unit,
	GMOBJ__object_account,
	GMSUB__subsidiary
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

--- fix xxx

ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_account_master_F0901_costs FOREIGN KEY
	(
	GL_BusinessUnit,
	GL_Object_Cost,
	GL_Subsidiary_Cost
	) REFERENCES hfm.account_master_F0901
	(
	GMMCU__business_unit,
	GMOBJ__object_account,
	GMSUB__subsidiary
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- add role


/****** Object:  DatabaseRole [hfm_operator]    Script Date: 11/7/2017 10:24:40 AM ******/

CREATE ROLE [hfm_operator]
GO
GRANT SELECT ON [hfm].[exclusive_product] TO [hfm_operator]
GO
GRANT EXECUTE ON [hfm].[BRS_global_cube_proc] TO [hfm_operator]
GO
GRANT SELECT ON [hfm].[object_to_account_map_rule] TO [hfm_operator]
GO
GRANT SELECT ON [hfm].[cost_center] TO [hfm_operator]
GO
GRANT SELECT ON [hfm].[account] TO [hfm_operator]
GO
GRANT SELECT ON [hfm].[account_master_F0901] TO [hfm_operator]
GO
GRANT SELECT ON [hfm].[exclusive_product_rule] TO [hfm_operator]
GO




