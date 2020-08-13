-- cost
/*
select top 10 *
FROM 
    OPENQUERY (ESYS_PROD, '

SELECT
imlitm as Item,
imprgr as FamilySet,
qn$spc as Supplier,
cbcrcd as Currency,
decimal(cbprrc/10000,10,4) as SupplierCost,
cbuorg as CostQtyBreak,
'''' as ROW_ID

FROM
ARCPDTA71.F4101, 
ARCPDTA71.F41061, 
ARCPDTA71.F5613
WHERE
imprgr = cblitm AND
imlitm = qnlitm AND
substr(cbcatn,1,1) = ''P'' AND
cbeftj <= CONCAT(CONCAT(1,SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) AND 	
cbexdj >= CONCAT(CONCAT(1,SUBSTR(CHAR(YEAR(CURRENT DATE)),3,2)),SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 

')
*/

-- price

select top 10 *
FROM 
    OPENQUERY (ESYS_PROD, '

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
imprgr = kiprgr and
kiicid = adicid and
imlitm = qnlitm and
adast = ''CORPRICE'' and
adeftj <= CONCAT(CONCAT(1,SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) and
adexdj >= CONCAT(CONCAT(1,SUBSTR(CHAR(YEAR(CURRENT_DATE)),3,2)), SUBSTR(CHAR(DIGITS(DAYOFYEAR(CURRENT DATE))),8,3)) 
')
