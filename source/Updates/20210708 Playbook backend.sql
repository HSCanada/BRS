-- Playbook backend, tmc, 8 Jul 21

------------------------------------------------------------
-- set rollups - START
------------------------------------------------------------

-- UPDATE       comm.[group] SET comm_group_scorecard_cd =''

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='DIGIMP'
WHERE        comm_group_cd in (
'DIGCIM'
,'DIGIMP'
,'DIGLAB'
,'DIGOTH'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='DIGMAT'
WHERE        comm_group_cd in (
'DIGMAT'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMEQ0'
WHERE        comm_group_cd in (
'ITMEQ0'
,'ITMPAR'

)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMFO2'
WHERE        comm_group_cd in (
'FRESEQ'
,'ITMCPU'
,'ITMFO1'
,'ITMFO2'
,'ITMFO3'
,'ITMFRT'
,'ITMISC'
,'ITMSOF'
,'SAFCOM'
,'SPMFGE'
,'SPMFO1'
,'SPMFO2'
,'SPMFO3'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMSER'
WHERE        comm_group_cd in (
'ITMSER'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMSND'
WHERE        comm_group_cd in (
'FRESND'
,'ITMCAM'
,'ITMEPS'
,'ITMPVT'
,'ITMSND'
,'ITMTEE'
,'REBSND'
,'REBTEE'
,'SPMFGS'
,'SPMPVT'
,'SPMREB'
,'SPMSND'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ZZZZZZ'
WHERE        comm_group_cd in (
'      '
,'BONCCS'
,'BONIMP'
,'CPSCNV'
,'CPSCOR'
,'CPSOTH'
,'CPSPOW'
,'CPSSUP'
,'CPSTRA'
,'CPSVCP'
,'CPSZHW'
,'DIGCCC'
,'DIGCCS'
,'EPSBAI'
,'EPSCAO'
,'EPSCHA'
,'EPSDEN'
,'EPSEDG'
,'EPSMIL'
,'EPSORT'
,'EPSOST'
,'EPSREV'
,'SALD30'
,'SCRCRD'
,'SFFFIN'
,'SPMALL'
,'SPMEQU'
,'STMPBA'
,'ZZZZZZ'
)

-- test, this must be Zero
SELECT Count(*) FROM  comm.[group] WHERE comm_group_scorecard_cd = ''

SELECT distinct comm_group_scorecard_cd FROM  comm.[group]
------------------------------------------------------------
-- set rollups - STOP
------------------------------------------------------------

