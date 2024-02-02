EXEC dbo.monthend_snapshot_proc @bDebug=1

select count (*) from [dbo].[BRS_Customer] where ShipTo = billto and shipto <>0 and TerritoryCd <>''

delete top (200) from [dbo].[BRS_Customer] where ShipTo = billto and shipto <>0

--100 @ 1.48
--100 @ 1.47
--200 @ 4.20

/*
select (60869 / 200 ) * 4.5 / 60

BT defaults, as delete is too long and removing RI too long for now
TerritoryCd	comm_salesperson_key_id
CORP 	HouseNCZE    


PostalCode	cps_code
T2C 5B1   	PMT28

*/

sp_who2

BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=1