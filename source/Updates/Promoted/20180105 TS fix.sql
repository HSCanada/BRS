-- Fix TS names, tc, 5 Jan 18


Update BRS_FSC_Rollup 
	Set [FSCName] = 'Julie' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'ZTSJE')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Lina' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSLE')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Robyn' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSRP')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Nadia' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSNX')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Franca' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSFP')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Franca' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'MTSFP')
	
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Eric' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'ZTSED')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Amanda' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSAR')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Noah' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSNT')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Noah' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSN2')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Noah' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'DTSN3')

Update BRS_FSC_Rollup 
	Set [FSCName] = 'Kristina' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'MTSKF')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Madeleine' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'ZTSMK')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Shenila' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'MTSSJ')

Update BRS_FSC_Rollup 
	Set [FSCName] = 'Ann' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'ZTSAB')
Update BRS_FSC_Rollup 
	Set [FSCName] = 'Julie' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd = 'ZTSJ2')

Update BRS_FSC_Rollup 
	Set [FSCName] = '** DO NOT USE **' FROM 	BRS_FSC_Rollup WHERE (TerritoryCd LIKE '%TS%') and NOT TerritoryCd in ('WZ9TS', 'DTS01') and FSCName = ''
	
select TerritoryCd, FSCName from [dbo].[BRS_FSC_Rollup] WHERE (TerritoryCd LIKE '%TS%') and NOT TerritoryCd in ('WZ9TS', 'DTS01') 
