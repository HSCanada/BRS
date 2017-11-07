
--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5550_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GACO" AS GACO___company, "GA$GTC" AS GA$GTC_group_type_category, "GA$GTY" AS GA$GTY_group_type, "GADSC1" AS GADSC1_description, "GA$SLO" AS GA$SLO_sales_organization, "GA$EXL" AS GA$EXL_exclusive, "GA$MBY" AS GA$MBY_maintained_by, "GAAC08" AS GAAC08_market_segment, "GA$CGN" AS GA$CGN_customer_group, "GA$SM" AS GA$SM__system_maintained_flag, "GAAC10" AS GAAC10_division_code, "GAUSER" AS GAUSER_user_id, "GAPID" AS GAPID__program_id, "GAJOBN" AS GAJOBN_work_station_id, "GAUPMJ" AS GAUPMJ_date_updated, "GAUPMT" AS GAUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5550_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GACO, GA$GTC, GA$GTY, GADSC1, GA$SLO, GA$EXL, GA$MBY, GAAC08, GA$CGN, GA$SM, GAAC10, GAUSER, GAPID, GAJOBN, CASE WHEN GAUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GAUPMJ+ 1900000,7,0))) ELSE NULL END AS GAUPMJ, GAUPMT

	FROM
		ARCPDTA71.F5550
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5551_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GBCO" AS GBCO___company, "GB$GTY" AS GB$GTY_group_type, "GB$QNO" AS GB$QNO_question_number, "GBYN1" AS GBYN1__yn_1 

-- INTO etl.ARCPDTA71_F5551_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GBCO, GB$GTY, GB$QNO, GBYN1

	FROM
		ARCPDTA71.F5551
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5552_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GCCO" AS GCCO___company, "GC$GTY" AS GC$GTY_group_type, "GC$VNO" AS GC$VNO_number_version, "GC$SNO" AS GC$SNO_sequence_number, "GC$LID" AS GC$LID_level_id, "GC$LCS" AS GC$LCS_level_code_security_flags, "GCUSER" AS GCUSER_user_id, "GCPID" AS GCPID__program_id, "GCJOBN" AS GCJOBN_work_station_id, "GCUPMJ" AS GCUPMJ_date_updated, "GCUPMT" AS GCUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5552_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GCCO, GC$GTY, GC$VNO, CAST((GC$SNO)/100.0 AS DEC(15,2)) AS GC$SNO, GC$LID, GC$LCS, GCUSER, GCPID, GCJOBN, CASE WHEN GCUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GCUPMJ+ 1900000,7,0))) ELSE NULL END AS GCUPMJ, GCUPMT

	FROM
		ARCPDTA71.F5552
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5553_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GDCO" AS GDCO___company,
	"GD$GTY" AS GD$GTY_group_type,
	"GD$VNO" AS GD$VNO_number_version,
	"GD$TER" AS GD$TER_territory_code,
	"GD$L01" AS GD$L01_level_code_01,
	"GD$L02" AS GD$L02_level_code_02,
	"GD$L03" AS GD$L03_level_code_03,
	"GD$L04" AS GD$L04_level_code_04,
	"GD$L05" AS GD$L05_level_code_05,
	"GD$L06" AS GD$L06_level_code_06,
	"GD$L07" AS GD$L07_level_code_07,
	"GD$L08" AS GD$L08_level_code_08,
	"GD$L09" AS GD$L09_level_code_09,
	"GD$L10" AS GD$L10_level_code_10,
	"GD$L11" AS GD$L11_level_code_11,
	"GD$L12" AS GD$L12_level_code_12,
	"GD$L13" AS GD$L13_level_code_13,
	"GD$L14" AS GD$L14_level_code_14,
	"GD$L15" AS GD$L15_level_code_15,
	"GD$L16" AS GD$L16_level_code_16,
	"GD$L17" AS GD$L17_level_code_17,
	"GD$L18" AS GD$L18_level_code_18,
	"GD$L19" AS GD$L19_level_code_19,
	"GD$L20" AS GD$L20_level_code_20,
	"GDCXPJ" AS GDCXPJ_expiration_date,
	"GD$RV4" AS GD$RV4_user_reserved_field,
	"GD$RV5" AS GD$RV5_user_reserved_field,
	"GDUSER" AS GDUSER_user_id,
	"GDPID" AS GDPID__program_id,
	"GDJOBN" AS GDJOBN_work_station_id,
	"GDUPMJ" AS GDUPMJ_date_updated,
	"GDUPMT" AS GDUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5553_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GDCO,
		GD$GTY,
		GD$VNO,
		GD$TER,
		GD$L01,
		GD$L02,
		GD$L03,
		GD$L04,
		GD$L05,
		GD$L06,
		GD$L07,
		GD$L08,
		GD$L09,
		GD$L10,
		GD$L11,
		GD$L12,
		GD$L13,
		GD$L14,
		GD$L15,
		GD$L16,
		GD$L17,
		GD$L18,
		GD$L19,
		GD$L20,
--		GDCXPJ AS GDCXPJ,
		CASE WHEN GDCXPJ >0 THEN DATE(DIGITS(DEC(GDCXPJ+ 1900000,7,0))) ELSE NULL END AS GDCXPJ,
		GD$RV4,
		GD$RV5,
		GDUSER,
		GDPID,
		GDJOBN,
		GDUPMJ AS GDUPMJ,
--		CASE WHEN GDUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GDUPMJ+ 1900000,7,0))) ELSE NULL END AS GDUPMJ,
		GDUPMT

	FROM
		ARCPDTA71.F5553
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5554_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GECO" AS GECO___company, "GE$GTY" AS GE$GTY_group_type, "GE$VNO" AS GE$VNO_number_version, "GE$LID" AS GE$LID_level_id, "GE$L01" AS GE$L01_level_code_01, "GEDSC1" AS GEDSC1_description, "GETKBY" AS GETKBY_order_taken_by, "GEUSER" AS GEUSER_user_id, "GEPID" AS GEPID__program_id, "GEJOBN" AS GEJOBN_work_station_id, "GEUPMJ" AS GEUPMJ_date_updated, "GEUPMT" AS GEUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5554_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GECO, GE$GTY, GE$VNO, GE$LID, GE$L01, GEDSC1, GETKBY, GEUSER, GEPID, GEJOBN, CASE WHEN GEUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GEUPMJ+ 1900000,7,0))) ELSE NULL END AS GEUPMJ, GEUPMT

	FROM
		ARCPDTA71.F5554
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5555_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GFCO" AS GFCO___company, "GF$GTY" AS GF$GTY_group_type, "GF$VNO" AS GF$VNO_number_version, "GFEFFF" AS GFEFFF_effective_from_date, "GFEFFT" AS GFEFFT_effective_thru_date, "GF$MBY" AS GF$MBY_maintained_by, "GFUSER" AS GFUSER_user_id, "GFPID" AS GFPID__program_id, "GFJOBN" AS GFJOBN_work_station_id, "GFUPMJ" AS GFUPMJ_date_updated, "GFUPMT" AS GFUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5555_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GFCO, GF$GTY, GF$VNO, CASE WHEN GFEFFF IS NOT NULL THEN DATE(DIGITS(DEC(GFEFFF+ 1900000,7,0))) ELSE NULL END AS GFEFFF, CASE WHEN GFEFFT IS NOT NULL THEN DATE(DIGITS(DEC(GFEFFT+ 1900000,7,0))) ELSE NULL END AS GFEFFT, GF$MBY, GFUSER, GFPID, GFJOBN, CASE WHEN GFUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GFUPMJ+ 1900000,7,0))) ELSE NULL END AS GFUPMJ, GFUPMT

	FROM
		ARCPDTA71.F5555
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5556_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

 --   Top 5 
    "GGCO" AS GGCO___company, "GG$GTY" AS GG$GTY_group_type, "GG$VNO" AS GG$VNO_number_version, "GG$L01" AS GG$L01_level_code_01, "GG$CGN" AS GG$CGN_customer_group, "GGUSER" AS GGUSER_user_id, "GGPID" AS GGPID__program_id, "GGJOBN" AS GGJOBN_work_station_id, "GGUPMJ" AS GGUPMJ_date_updated, "GGUPMT" AS GGUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5556_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GGCO, GG$GTY, GG$VNO, GG$L01, GG$CGN, GGUSER, GGPID, GGJOBN, CASE WHEN GGUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GGUPMJ+ 1900000,7,0))) ELSE NULL END AS GGUPMJ, GGUPMT

	FROM
		ARCPDTA71.F5556
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5557_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GKCO" AS GKCO___company,
"GK$GTC" AS GK$GTC_group_type_category,
"GK$GTY" AS GK$GTY_group_type,
"GK$CGN" AS GK$CGN_customer_group,
"GKDSC1" AS GKDSC1_description,
"GKAN8" AS GKAN8__billto,
"GKEFFF" AS GKEFFF_effective_from_date,
"GKEFFT" AS GKEFFT_effective_thru_date,
"GK$EXL" AS GK$EXL_exclusive,
"GKUNCD" AS GKUNCD_freeze_code,
"GKAC08" AS GKAC08_market_segment,
"GK$MBY" AS GK$MBY_maintained_by,
"GKVCD" AS GKVCD__last_changed_date,
"GK$SM" AS GK$SM__system_maintained_flag,
"GKAC10" AS GKAC10_division_code,
"GK$CLS" AS GK$CLS_classification_code,
"GK$RV1" AS GK$RV1_user_reserved_field,
"GK$RV2" AS GK$RV2_user_reserved_field,
"GK$RV3" AS GK$RV3_user_reserved_field,
"GKUSER" AS GKUSER_user_id,
"GKPID" AS GKPID__program_id,
"GKJOBN" AS GKJOBN_work_station_id,
"GKUPMJ" AS GKUPMJ_date_updated,
"GKUPMT" AS GKUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5557_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GKCO,
		GK$GTC,
		GK$GTY,
		GK$CGN,
		GKDSC1,
		GKAN8,
		CASE WHEN GKEFFF IS NOT NULL THEN DATE(DIGITS(DEC(GKEFFF+ 1900000,7,0))) ELSE NULL END AS GKEFFF,
		CASE WHEN GKEFFT IS NOT NULL THEN DATE(DIGITS(DEC(GKEFFT+ 1900000,7,0))) ELSE NULL END AS GKEFFT,
		GK$EXL,
		GKUNCD,
		GKAC08,
		GK$MBY,
		GKVCD  AS GKVCD,
--		CASE WHEN GKVCD IS NOT NULL THEN DATE(DIGITS(DEC(GKVCD+ 1900000,7,0))) ELSE NULL END AS GKVCD,
		GK$SM,
		GKAC10,
		GK$CLS,
		GK$RV1,
		GK$RV2,
		GK$RV3,
		GKUSER,
		GKPID,
		GKJOBN,
		CASE WHEN GKUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GKUPMJ+ 1900000,7,0))) ELSE NULL END AS GKUPMJ,
		GKUPMT

	FROM
		ARCPDTA71.F5557
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5558_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

    Top 5 
    "GLCO" AS GLCO___company, "GL$CGN" AS GL$CGN_customer_group, "GL$INX" AS GL$INX_includeexclude, "GL$SNU" AS GL$SNU_sequence_number, "GL$CGF" AS GL$CGF_field_name, "GLFILD" AS GLFILD_field_name, "GLFILE" AS GLFILE_file_id, "GL$AO" AS GL$AO__andor, "GL$OPR" AS GL$OPR_operator, "GL$VAL" AS GL$VAL_value, "GLEFFF" AS GLEFFF_effective_from_date, "GLEFFT" AS GLEFFT_effective_thru_date, "GLUSER" AS GLUSER_user_id, "GLPID" AS GLPID__program_id, "GLJOBN" AS GLJOBN_work_station_id, "GLUPMJ" AS GLUPMJ_date_updated, "GLUPMT" AS GLUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5558_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GLCO, GL$CGN, GL$INX, CAST((GL$SNU)/100.0 AS DEC(15,2)) AS GL$SNU, GL$CGF, GLFILD, GLFILE, GL$AO, GL$OPR, GL$VAL, CASE WHEN GLEFFF IS NOT NULL THEN DATE(DIGITS(DEC(GLEFFF+ 1900000,7,0))) ELSE NULL END AS GLEFFF, CASE WHEN GLEFFT IS NOT NULL THEN DATE(DIGITS(DEC(GLEFFT+ 1900000,7,0))) ELSE NULL END AS GLEFFT, GLUSER, GLPID, GLJOBN, CASE WHEN GLUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GLUPMJ+ 1900000,7,0))) ELSE NULL END AS GLUPMJ, GLUPMT

	FROM
		ARCPDTA71.F5558
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5559_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 

--    Top 5 
    "GMCO" AS GMCO___company, "GM$CGN" AS GM$CGN_customer_group, "GMSHAN" AS GMSHAN_shipto, "GMAN8" AS GMAN8__billto, "GMEFFF" AS GMEFFF_effective_from_date, "GMEFFT" AS GMEFFT_effective_thru_date, "GM$LDM" AS GM$LDM_load_method, "GM$EXL" AS GM$EXL_exclusive, "GM$CMP" AS GM$CMP_company_code, "GM$SYS" AS GM$SYS_system_code_msm, "GM$CUS" AS GM$CUS_customer_number_msm, "GMHRST" AS GMHRST_status_code, "GMOSTP" AS GMOSTP_structure_type, "GMPA8" AS GMPA8__parent_number, "GM$CLS" AS GM$CLS_classification_code, "GM$RV1" AS GM$RV1_user_reserved_field, "GM$RV2" AS GM$RV2_user_reserved_field, "GM$RV3" AS GM$RV3_user_reserved_field, "GMUSER" AS GMUSER_user_id, "GMPID" AS GMPID__program_id, "GMJOBN" AS GMJOBN_work_station_id, "GMUPMJ" AS GMUPMJ_date_updated, "GMUPMT" AS GMUPMT_time_last_updated 

-- INTO etl.ARCPDTA71_F5559_<instert_friendly_name_here>

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		GMCO, GM$CGN, GMSHAN, GMAN8, CASE WHEN GMEFFF IS NOT NULL THEN DATE(DIGITS(DEC(GMEFFF+ 1900000,7,0))) ELSE NULL END AS GMEFFF, CASE WHEN GMEFFT IS NOT NULL THEN DATE(DIGITS(DEC(GMEFFT+ 1900000,7,0))) ELSE NULL END AS GMEFFT, GM$LDM, GM$EXL, GM$CMP, GM$SYS, GM$CUS, GMHRST, GMOSTP, GMPA8, GM$CLS, GM$RV1, GM$RV2, GM$RV3, GMUSER, GMPID, GMJOBN, CASE WHEN GMUPMJ IS NOT NULL THEN DATE(DIGITS(DEC(GMUPMJ+ 1900000,7,0))) ELSE NULL END AS GMUPMJ, GMUPMT

	FROM
		ARCPDTA71.F5559
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------
