
-- cleanup FSC groups

-- EST
UPDATE 
[dbo].[BRS_FSC_Rollup]
SET group_type = 'DEST'
WHERE FSCStatusCode = 'S' AND group_type = ''

-- TS
UPDATE 
[dbo].[BRS_FSC_Rollup]
SET group_type = 'DDTS'
WHERE FSCStatusCode = 'T' AND group_type = ''

-- ESS
UPDATE 
[dbo].[BRS_FSC_Rollup]
SET group_type = 'AAES'
WHERE TerritoryCd = 'ESS84'

-- FSC
UPDATE 
[dbo].[BRS_FSC_Rollup]
SET group_type = 'AAFS'
WHERE TerritoryCd in('CZ1MS', 'CZ1RM', 'CZ2JS', 'WZ1JV')

	
/*
SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE FSCStatusCode = 'c'
SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE group_type = ''
*/



