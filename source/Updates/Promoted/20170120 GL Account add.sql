--------------------------------------------------------------------------------
-- DROP TABLE Integration.F0901_account_master
--------------------------------------------------------------------------------

SELECT 
    Top 5 
    "GMCO" AS GMCO___company,
	"GMAID" AS GMAID__account_id,
	"GMMCU" AS GMMCU__business_unit,
	"GMOBJ" AS GMOBJ__object_account,
	"GMSUB" AS GMSUB__subsidiary,
	"GMANS" AS GMANS__free_form_3rd_acct_no,
	"GMDL01" AS GMDL01_description,
	"GMLDA" AS GMLDA__account_level_of_detail,
	"GMBPC" AS GMBPC__budget_pattern_code,
	"GMPEC" AS GMPEC__posting_edit,
	"GMSTPC" AS GMSTPC_type_code,
	"GMFPEC" AS GMFPEC_fixed_asset_posting_edit_code,
	"GMBILL" AS GMBILL_billable_yn,
	"GMCRCD" AS GMCRCD_currency_code,
	"GMUM" AS GMUM___unit_of_measure,
	"GMR001" AS GMR001_bill_item_code,
	"GMR002" AS GMR002_category_code_002,
	"GMR003" AS GMR003_location,
	"GMR004" AS GMR004_floor,
	"GMR005" AS GMR005_category_code_005,
	"GMR006" AS GMR006_category_code_006,
	"GMR007" AS GMR007_category_code_007,
	"GMR008" AS GMR008_category_code_008,
	"GMR009" AS GMR009_category_code_009,
	"GMR010" AS GMR010_category_code_010,
	"GMR011" AS GMR011_category_code_011,
	"GMR012" AS GMR012_category_code_012,
	"GMR013" AS GMR013_category_code_013,
	"GMR014" AS GMR014_category_code_014,
	"GMR015" AS GMR015_category_code_015,
	"GMR016" AS GMR016_category_code_016,
	"GMR017" AS GMR017_category_code_017,
	"GMR018" AS GMR018_category_code_018,
	"GMR019" AS GMR019_category_code_019,
	"GMR020" AS GMR020_pl_cde_planning,
	"GMR021" AS GMR021_category_code_021,
	"GMR022" AS GMR022_category_code_022,
	"GMR023" AS GMR023_category_code_023,
	"GMOBJA" AS GMOBJA_alternate_object_account,
	"GMSUBA" AS GMSUBA_alternate_subsidiary,
	"GMWCMP" AS GMWCMP_workers_comp,
	"GMCCT" AS GMCCT__method_of_computation,
	"GMERC" AS GMERC__equipment_rate_code,
	"GMHTC" AS GMHTC__header_type_code,
	"GMQLDA" AS GMQLDA_quantity_rollup_level,
	"GMCCC" AS GMCCC__cost_code_complete_yn,
	"GMFMOD" AS GMFMOD_model_accountconsolidations,
	"GMDTFR" AS GMDTFR_date_from_JDT,
	"GMDTTO" AS GMDTTO_date_thru_JDT,
	"GMCEDF" AS GMCEDF_current_effective_date_flag,
	"GMTOBJ" AS GMTOBJ_target_object_account,
	"GMTSUB" AS GMTSUB_target_subsidiary,
	"GMTXA1" AS GMTXA1_tax_ratearea,
	"GMEXR1" AS GMEXR1_tax_expl_code,
	"GMTXA2" AS GMTXA2_tax_area_2,
	"GMEXR2" AS GMEXR2_tax_expl_code_2,
	"GMTXGL" AS GMTXGL_gl_account_taxable_flag,
	"GMUSER" AS GMUSER_user_id,
	"GMPID" AS GMPID__program_id,
	"GMJOBN" AS GMJOBN_work_station_id,
	"GMUPMJ" AS GMUPMJ_date_updated_JDT,
	"GMUPMT" AS GMUPMT_time_last_updated 

-- INTO Integration.F0901_account_master

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GMCO,
		GMAID,
		GMMCU,
		GMOBJ,
		GMSUB,
		GMANS,
		GMDL01,
		GMLDA,
		GMBPC,
		GMPEC,
		GMSTPC,
		GMFPEC,
		GMBILL,
		GMCRCD,
		GMUM,
		GMR001,
		GMR002,
		GMR003,
		GMR004,
		GMR005,
		GMR006,
		GMR007,
		GMR008,
		GMR009,
		GMR010,
		GMR011,
		GMR012,
		GMR013,
		GMR014,
		GMR015,
		GMR016,
		GMR017,
		GMR018,
		GMR019,
		GMR020,
		GMR021,
		GMR022,
		GMR023,
		GMOBJA,
		GMSUBA,
		GMWCMP,
		GMCCT,
		GMERC,
		GMHTC,
		GMQLDA,
		GMCCC,
		GMFMOD,
		GMDTFR AS GMDTFR,
		GMDTTO AS GMDTTO,
		GMCEDF,
		GMTOBJ,
		GMTSUB,
		GMTXA1,
		GMEXR1,
		GMTXA2,
		GMEXR2,
		GMTXGL,
		GMUSER,
		GMPID,
		GMJOBN,
		GMUPMJ  AS GMUPMJ,
		GMUPMT

	FROM
		ARCPDTA71.F0901
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

ALTER TABLE Integration.F0901_account_master ADD CONSTRAINT
	idx_F0901_account_master_c_pk PRIMARY KEY CLUSTERED 
	(
	GMMCU__business_unit,
	GMOBJ__object_account,
	GMSUB__subsidiary
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

