

--------------------------------------------------------------------------------
-- DROP TABLE Integration.E3TARC_E3ITEMA_<instert_friendly_name_here>
--------------------------------------------------------------------------------
-- truncate table Integration.E3ITEMA_trim

INSERT INTO Integration.E3ITEMA_trim
(
	IITEM__item_id
	,IWHSE__warehouse_id
	,IVNDR__vendor_id
	,ISUBV__subvendor_id
	,IBUYR__buyer_id
	,IDEM52_demand_forecast_weekly
	,IDMPRF_item_demand_profile_id 
)
SELECT 
--    Top 5 
	"IITEM" AS IITEM__item_id
    ,"IWHSE" AS IWHSE__warehouse_id

	,"IVNDR" AS IVNDR__vendor_id
	,"ISUBV" AS ISUBV__subvendor_id
	,"IBUYR" AS IBUYR__buyer_id
	,"IDEM52" AS IDEM52_demand_forecast_weekly
	,"IDMPRF" AS IDMPRF_item_demand_profile_id 

--INTO Integration.E3ITEMA_trim

FROM 
    OPENQUERY (ASYS_PROD
,'

	SELECT
		IITEM
		,IWHSE
		,IVNDR
		,ISUBV
		,IBUYR
		,IDEM52
		,IDMPRF

	FROM
		E3TARC.E3ITEMA
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.E3TARC_E3PRFL_<instert_friendly_name_here>
--------------------------------------------------------------------------------

SELECT 
    Top 5 
    "PBIRDT" AS PBIRDT_birth_date
	,"PPRFL" AS PPRFL__profile_id
	,"PPTYPE" AS PPTYPE_profile_type
	,"PNAME" AS PNAME__profile_name
	,"PPERD" AS PPERD__periodicity
	,"PMESG" AS PMESG__message_switch
	,"PUSEDT" AS PUSEDT_use_date
	,"PIX01" AS PIX01__seasonal_index
	,"PIX02" AS PIX02__seasonal_index
	,"PIX03" AS PIX03__seasonal_index
	,"PIX04" AS PIX04__seasonal_index
	,"PIX05" AS PIX05__seasonal_index
	,"PIX06" AS PIX06__seasonal_index
	,"PIX07" AS PIX07__seasonal_index
	,"PIX08" AS PIX08__seasonal_index
	,"PIX09" AS PIX09__seasonal_index
	,"PIX10" AS PIX10__seasonal_index
	,"PIX11" AS PIX11__seasonal_index
	,"PIX12" AS PIX12__seasonal_index
	,"PIX13" AS PIX13__seasonal_index
	,"PIX14" AS PIX14__seasonal_index
	,"PIX15" AS PIX15__seasonal_index
	,"PIX16" AS PIX16__seasonal_index
	,"PIX17" AS PIX17__seasonal_index
	,"PIX18" AS PIX18__seasonal_index
	,"PIX19" AS PIX19__seasonal_index
	,"PIX20" AS PIX20__seasonal_index
	,"PIX21" AS PIX21__seasonal_index
	,"PIX22" AS PIX22__seasonal_index
	,"PIX23" AS PIX23__seasonal_index
	,"PIX24" AS PIX24__seasonal_index
	,"PIX25" AS PIX25__seasonal_index
	,"PIX26" AS PIX26__seasonal_index
	,"PIX27" AS PIX27__seasonal_index
	,"PIX28" AS PIX28__seasonal_index
	,"PIX29" AS PIX29__seasonal_index
	,"PIX30" AS PIX30__seasonal_index
	,"PIX31" AS PIX31__seasonal_index
	,"PIX32" AS PIX32__seasonal_index
	,"PIX33" AS PIX33__seasonal_index
	,"PIX34" AS PIX34__seasonal_index
	,"PIX35" AS PIX35__seasonal_index
	,"PIX36" AS PIX36__seasonal_index
	,"PIX37" AS PIX37__seasonal_index
	,"PIX38" AS PIX38__seasonal_index
	,"PIX39" AS PIX39__seasonal_index
	,"PIX40" AS PIX40__seasonal_index
	,"PIX41" AS PIX41__seasonal_index
	,"PIX42" AS PIX42__seasonal_index
	,"PIX43" AS PIX43__seasonal_index
	,"PIX44" AS PIX44__seasonal_index
	,"PIX45" AS PIX45__seasonal_index
	,"PIX46" AS PIX46__seasonal_index
	,"PIX47" AS PIX47__seasonal_index
	,"PIX48" AS PIX48__seasonal_index
	,"PIX49" AS PIX49__seasonal_index
	,"PIX50" AS PIX50__seasonal_index
	,"PIX51" AS PIX51__seasonal_index
	,"PIX52" AS PIX52__seasonal_index
	,"PMSGSW" AS PMSGSW_message_switch 

INTO Integration.E3PRFL_profile

FROM 
    OPENQUERY (ASYS_PROD, '

	SELECT
		PBIRDT
		,PPRFL
		,PPTYPE
		,PNAME
		,PPERD
		,PMESG
		,PUSEDT
		,PIX01
		,PIX02
		,PIX03
		,PIX04
		,PIX05
		,PIX06
		,PIX07
		,PIX08
		,PIX09
		,PIX10
		,PIX11
		,PIX12
		,PIX13
		,PIX14
		,PIX15
		,PIX16
		,PIX17
		,PIX18
		,PIX19
		,PIX20
		,PIX21
		,PIX22
		,PIX23
		,PIX24
		,PIX25
		,PIX26
		,PIX27
		,PIX28
		,PIX29
		,PIX30
		,PIX31
		,PIX32
		,PIX33
		,PIX34
		,PIX35
		,PIX36
		,PIX37
		,PIX38
		,PIX39
		,PIX40
		,PIX41
		,PIX42
		,PIX43
		,PIX44
		,PIX45
		,PIX46
		,PIX47
		,PIX48
		,PIX49
		,PIX50
		,PIX51
		,PIX52
		,PMSGSW

	FROM
		E3TARC.E3PRFL
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------