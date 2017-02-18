select  TOP 10 * from openquery(ESYS_PROD, 'select 

* 

FROM 
ARCPDTA71.F4072'

)


-- from
ARCPDTA71.F4101, ARCPDTA71.F41061,ARCPDTA71.F5613

-- join
imprgr = cblitm AND imlitm = qnlitm AND substr(cbcatn,1,1) = 'P' AND cbeftj <= CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) AND 		cbexdj >= CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3))

-- select
imlitm as Item, 	imprgr as FamilySet, 	qn$spc as Supplier, 	cbcrcd as Currency, 	decimal(cbprrc/10000,10,4) as SupplierCost, 	cbuorg as CostQtyBreak, '' as ROW_ID

-- order by
imlitm, cbuorg, CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) DESC

-- combine

SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT 
		imlitm as Item, 	
		imprgr as FamilySet, 	
		qn$spc as Supplier, 	
		cbcrcd as Currency, 	
		decimal(cbprrc/10000,10,4) as SupplierCost, 	
		cbuorg as CostQtyBreak, '''' as ROW_ID
	FROM
		ARCPDTA71.F4101, 
		ARCPDTA71.F41061,
		ARCPDTA71.F5613
	WHERE
		imprgr = cblitm AND 
		imlitm = qnlitm AND 
		substr(cbcatn,1,1) = ''P'' AND 
		cbeftj <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) AND 		
		cbexdj >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3))
	ORDER BY 
		imlitm, 
		cbuorg, 
		CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), 
		SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) DESC
' )

 -- from
  ARCPDTA71.F4101,ARCPDTA71.F5613,ARCPDTA71.F4072,ARCPDTA71.F4094

  -- join
  	imprgr = kiprgr and 		kiicid = adicid and 		adast = 'CORPRICE' and 		adeftj <= CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) and 		adexdj >= CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) and 		imlitm = qnlitm

-- select
	imlitm as Item, 	decimal(adfvtr/10000,10,4) as CorporatePrice, 	admnq as SellQtyBreak, '' as ROW_ID

-- order by
imlitm, admnq, CONCAT(CONCAT('1',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT_DATE))),8,3)) DESC

-- combine
SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT
		imlitm as Item,
		decimal(adfvtr/10000,10,4) as CorporatePrice,
		admnq as SellQtyBreak,
		'''' as ROW_ID
	FROM
		ARCPDTA71.F4101,
		ARCPDTA71.F5613,
		ARCPDTA71.F4072,
		ARCPDTA71.F4094
	WHERE
		imprgr = kiprgr AND
		kiicid = adicid AND	
		imlitm = qnlitm AND
		adast = ''CORPRICE'' AND
		adeftj <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND
		adexdj >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
')


SELECT TOP 10000 * from OPENQUERY (ESYS_PROD, '	
	SELECT
		*
	FROM
		ARCPDTA71.F4072
	WHERE
		adast = ''CORPRICE'' AND
		adeftj <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND
		adexdj >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
')


SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT
		*
	FROM
		QSYS2.SYSCOLUMNS
	WHERE
		TABLE_NAME = ''F4072''
')

SELECT  * from OPENQUERY (ESYS_PROD, '	
	SELECT
		*
	FROM
		QSYS2.SYSTABLES
		WHERE SYSTEM_TABLE_SCHEMA = ''ARCPDTA71''
')



--

SELECT TOP 10 "ADAST" AS adjustment_name, "ADITM" AS item_number_short, "ADLITM" AS _2nd_item_number, "ADAITM" AS _3rd_item_number, "ADAN8" AS address_number, "ADICID" AS itemcustomer_key_id, "ADSDGR" AS order_detail_group, "ADSDV1" AS sales_detail_value_01, "ADSDV2" AS sales_detail_value_02, "ADSDV3" AS sales_detail_value_03, "ADCRCD" AS currency_code, "ADUOM" AS um, "ADMNQ" AS quantity_from, "ADEFTJ" AS effective_date, "ADEXDJ" AS expired_date, "ADBSCD" AS basis, "ADLEDG" AS cost_method, "ADFRMN" AS formula_name, "ADFVTR" AS factor_value, "ADFGY" AS free_goods_yn, "ADATID" AS price_adjustment_key_id, "ADURCD" AS user_reserved_code, "ADURDT" AS user_reserved_date, "ADURAT" AS user_reserved_amount, "ADURAB" AS user_reserved_number, "ADURRF" AS user_reserved_reference, "ADUSER" AS user_id, "ADPID" AS program_id, "ADJOBN" AS work_station_id, "ADUPMJ" AS date_updated, "ADTDAY" AS time_of_day from OPENQUERY (ESYS_PROD, '	
	SELECT
		ADAST, ADITM, ADLITM, ADAITM, ADAN8, ADICID, ADSDGR, ADSDV1, ADSDV2, ADSDV3, ADCRCD, ADUOM, ADMNQ, ADEFTJ, ADEXDJ, ADBSCD, ADLEDG, ADFRMN, ADFVTR, ADFGY, ADATID, ADURCD, ADURDT, ADURAT, ADURAB, ADURRF, ADUSER, ADPID, ADJOBN, ADUPMJ, ADTDAY
	FROM
		ARCPDTA71.F4072
')

SELECT top 10 * from OPENQUERY (ESYS_PROD, '	
	SELECT
		imlitm as Item,
		decimal(adfvtr/10000,10,4) as adfvtr,
		admnq as SellQtyBreak,
		'''' as ROW_ID
	FROM
		ARCPDTA71.F4101,
		ARCPDTA71.F5613,
		ARCPDTA71.F4072,
		ARCPDTA71.F4094
	WHERE
		imprgr = kiprgr AND
		kiicid = adicid AND	
		imlitm = qnlitm AND
		adast = ''CORPRICE'' AND
		adeftj <= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND
		adexdj >= CONCAT(CONCAT(''1'',SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
')
