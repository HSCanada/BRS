
-- look around in JDE metadata to find useful information

SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT 
		TABLE_NAME  
		,TABLE_TYPE
		,COLUMN_COUNT
		,ROW_LENGTH
		,TABLE_TEXT
		,TABLE_SCHEMA
		,LAST_ALTERED_TIMESTAMP

	FROM
		QSYS2.SYSTABLES
	WHERE
--		TABLE_SCHEMA in(''ARCPDTA71'', ''ARCPCORDTA'') AND
--		TABLE_NAME like (''W564101Z'') AND
		TABLE_NAME in(''NPFIMS'') AND
--		TABLE_TYPE = ''P'' AND
--		TABLE_TEXT LIKE (''%CAT%'')
--		TABLE_SCHEMA = ''ARCPTEL'' AND
--		TABLE_SCHEMA = ''ARCPCORDTA'' AND
--		TABLE_NAME in(''F060116'') AND
		(1=1)

	ORDER BY 1 DESC
--	ORDER BY 7 DESC
')

-- A system tables
SELECT * from OPENQUERY (ASYS_PROD, '	
	SELECT 
		TABLE_NAME  
		,TABLE_TYPE
		,COLUMN_COUNT
		,ROW_LENGTH
		,TABLE_TEXT
		,TABLE_SCHEMA
		,LAST_ALTERED_TIMESTAMP

	FROM
		QSYS2.SYSTABLES
	WHERE
--		TABLE_SCHEMA like ''ARCPCORDTA%'' AND
		TABLE_NAME like (''NOTWOT'') AND
--		TABLE_NAME like (''D1ICMTPF%'') AND
--		TABLE_NAME in(''E3ITMS'', ''E3PRFL'') AND
--		TABLE_TYPE = ''P'' AND
--		TABLE_TEXT LIKE (''%CAT%'')
--		TABLE_SCHEMA = ''ARCPTEL'' AND
--		TABLE_SCHEMA = ''ARCPCORDTA'' AND
--		TABLE_NAME in(''F060116'') AND
		(1=1)

	ORDER BY 1 ASC
--	ORDER BY 7 DESC
')

SELECT * from OPENQUERY (ASYS_PROD, '	
	SELECT 
		TABLE_NAME  
		,TABLE_TYPE
		,COLUMN_COUNT
		,ROW_LENGTH
		,TABLE_TEXT
		,TABLE_SCHEMA
		,LAST_ALTERED_TIMESTAMP

	FROM
		QSYS2.SYSTABLES
	WHERE
--		TABLE_SCHEMA like ''ARCPDTA71'' AND
--		TABLE_SCHEMA like ''E3TARC'' AND
		TABLE_NAME like (''F9202%'') AND
--		TABLE_NAME in(''E3ITMS'', ''E3PRFL'') AND
--		TABLE_TYPE = ''P'' AND
--		TABLE_NAME like (''F4101'') AND
--		TABLE_NAME in(''F0013'', ''F0014'', ''F0015'', ''F0111'', ''F0115'', ''F0301'', ''F0401'', ''F40205'', ''F4102'', ''F4104'', ''F4105'', ''F5501'', ''F550101'', ''F5503'', ''F55384'', ''F55385'', ''F55386'', ''F554012'', ''F5540122'', ''F554070'', ''F55510'', ''F55512'', ''F55520'', ''F5602'', ''F5604'', ''F5611'', ''F5614'', ''F5640314'', ''F5641'', ''F56416'', ''F564209'', ''F56961'', ''F5698'', ''F5830'', ''F5831'', ''F5832'', ''F5833'', ''F5834'', ''F5840122'', ''F5840123'', ''F5840124'', ''F5844'', ''F5865'', ''F660102'', ''F0005'', ''F0101'', ''F0150'', ''F4070'', ''F4072'', ''F4094'', ''F4101'', ''F41061'', ''F5613'', ''F5656'') AND
--		TABLE_TYPE = ''P'' AND
--		TABLE_TEXT LIKE (''%CAT%'')
--		TABLE_SCHEMA = ''ARCPTEL'' AND
--		TABLE_SCHEMA = ''ARCPDTA71'' AND
--		TABLE_NAME in(''F060116'') AND
		(1=1)

	ORDER BY 1 ASC
--	ORDER BY 7 DESC
')



SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT 
		TABLE_NAME  
		,TABLE_TYPE
		,COLUMN_COUNT
		,ROW_LENGTH
		,TABLE_TEXT
		,TABLE_SCHEMA
		,LAST_ALTERED_TIMESTAMP

	FROM
		QSYS2.SYSTABLES
	WHERE
		TABLE_SCHEMA like ''ARCPDTA71'' AND
		TABLE_NAME like (''F55520'') AND
--		TABLE_NAME in(''F0013'', ''F0014'', ''F0015'', ''F0111'', ''F0115'', ''F0301'', ''F0401'', ''F40205'', ''F4102'', ''F4104'', ''F4105'', ''F5501'', ''F550101'', ''F5503'', ''F55384'', ''F55385'', ''F55386'', ''F554012'', ''F5540122'', ''F554070'', ''F55510'', ''F55512'', ''F55520'', ''F5602'', ''F5604'', ''F5611'', ''F5614'', ''F5640314'', ''F5641'', ''F56416'', ''F564209'', ''F56961'', ''F5698'', ''F5830'', ''F5831'', ''F5832'', ''F5833'', ''F5834'', ''F5840122'', ''F5840123'', ''F5840124'', ''F5844'', ''F5865'', ''F660102'', ''F0005'', ''F0101'', ''F0150'', ''F4070'', ''F4072'', ''F4094'', ''F4101'', ''F41061'', ''F5613'', ''F5656'') AND
--		TABLE_TYPE = ''P'' AND
--		TABLE_TEXT LIKE (''%CAT%'')
--		TABLE_SCHEMA = ''ARCPTEL'' AND
--		TABLE_SCHEMA = ''ARCPDTA71'' AND
--		TABLE_NAME in(''F060116'') AND
		(1=1)

	ORDER BY 1 ASC
--	ORDER BY 7 DESC
')

PRINT ('Columns, E system')
SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT
		COLUMN_NAME 
		,TABLE_NAME
		,TABLE_SCHEMA
		,ORDINAL_POSITION
		,DATA_TYPE
		,LENGTH
		, NUMERIC_PRECISION
		,NUMERIC_PRECISION_RADIX
		,COLUMN_TEXT
	FROM
		QSYS2.SYSCOLUMNS
	WHERE
--		COLUMN_NAME = ''F4073'' AND
--		TABLE_SCHEMA=''ARCPCORDTA''  
		TABLE_SCHEMA like ''ARCPDTA71%''   AND
		TABLE_NAME in( ''F55520'')
--		TABLE_NAME IN(''PDFSPLDB'', ''PDFSPLF'', ''RPTRULES'', ''RPTRULESH'', ''ESNDCPF'', ''ESNDDSTP'', ''ESNDJRNP'', ''ESNDPF'', ''ESNDSGNP'', ''ESPLFWD'', ''EFTPDEPF'', ''EFTPSECP'', ''ESNDABUP'', ''ESNDADRP'', ''DSPSPLPF'', ''MNUCMDE'', ''OPTFILEE'', ''QTXTSRC'')
    ORDER BY 
        TABLE_NAME, ORDINAL_POSITION
')

-- A-system Table Fields
SELECT * from OPENQUERY (ASYS_PROD, '	
	SELECT
		COLUMN_NAME 
		,TABLE_NAME
		,TABLE_SCHEMA
		,ORDINAL_POSITION
		,DATA_TYPE
		,LENGTH
		, NUMERIC_PRECISION
		,NUMERIC_PRECISION_RADIX
		,COLUMN_TEXT
	FROM
		QSYS2.SYSCOLUMNS
	WHERE
--		TABLE_SCHEMA like ''ARCPCORDTA'' AND
--		TABLE_NAME like (''D1ETSDPF%'') 
--		TABLE_NAME in(''E3ITMS'', ''E3PRFL'') 
--		TABLE_TYPE = ''P'' AND
		COLUMN_NAME = ''QI$ACC'' 
--		TABLE_SCHEMA=''HSIPDTA71'' 
--		TABLE_NAME in( ''F4101'')
--		TABLE_NAME IN(''PDFSPLDB'', ''PDFSPLF'', ''RPTRULES'', ''RPTRULESH'', ''ESNDCPF'', ''ESNDDSTP'', ''ESNDJRNP'', ''ESNDPF'', ''ESNDSGNP'', ''ESPLFWD'', ''EFTPDEPF'', ''EFTPSECP'', ''ESNDABUP'', ''ESNDADRP'', ''DSPSPLPF'', ''MNUCMDE'', ''OPTFILEE'', ''QTXTSRC'')
--    ORDER BY 
--        TABLE_NAME, ORDINAL_POSITION
')

-- A system - data
SELECT top 10 * from OPENQUERY (ASYS_PROD, '	
	SELECT
		*
 	FROM
		ARCPTEL.NPFIMS
	WHERE
	EHORDR = ''R93535''
')

SELECT top 10 * from OPENQUERY (ASYS_PROD, '	
	SELECT
		*
 	FROM
		ARCPCORDTA.D1ETSDPF
	WHERE
	edordr = ''R93535''
')



SELECT * from OPENQUERY (ESYS_QA, '	
	SELECT
		*
 	FROM
		ARCPDTA71.F5552018 
	WHERE 
	VA$EON like ''FG%''
	-- VA$CN2 = 1732065
')

SELECT * from OPENQUERY (ESYS_PROD, '	
	SELECT
		count(*) as count
 	FROM
		TELFLE.NPFIMS 
	-- WHERE 
	-- VA$EON like ''FG%''
	-- VA$CN2 = 1732065
--	order by FGUPMJ desc
')

-- PROD 1691
-- QA 1673


-- The icmord field will have the sales order number 
-- you can disregard the icmtyp2 records where the value = "D". Those are detail comments for the line items of the order. You are only interested in the "H" comments which are the header comments. 


---

-- meta
SELECT 
	RTRIM("FRDTAI")				AS data_item
	,"FRDTAT"					AS data_item_type
	,"FROWTP"					AS data_type
	,"FRDTAS"					AS data_item_size
	,ISNULL("FRCDEC", 0)		AS display_decimals
	,ISNULL("FRDSCR", 'zNA')	AS row_description 
    
FROM 

    OPENQUERY (ASYS_PROD, '

	SELECT
		t.FRDTAI
		,FRDTAT
		,FROWTP
		,FRDTAS
		,FRCDEC
		,FRDSCR
	FROM
		ARCPCOM71.F9210 t
		LEFT JOIN ARCPCOM71.F9202 d
		ON t.FRDTAI = d.FRDTAI AND
			d.FRLNGP = '' '' AND
			d.FRSYR = '' ''  
')

-- table

SELECT top 10 * from OPENQUERY (ASYS_PROD, '
	SELECT
		*
	FROM
		QSYS2.SYSCOLUMNS
	WHERE
        TABLE_SCHEMA = ''ARCPCORDTA'' AND
		TABLE_NAME in( ''D1ICMTPF'')
    ORDER BY 
        ORDINAL_POSITION
')

-- TABLE_NAME in(''E3ITMS'', ''E3PRFL'') 
