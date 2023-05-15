-- Add the below logic to a post ETL load proc
-- 17 Dec 17, tmc
-- AFTER data flow doc, est *** 5m ***

-- RUN THIS MANUALY UNTIL in proc

-------------------------------------------------------------------------------
-- Part 1 - HFM update, run any time
-------------------------------------------------------------------------------

--- update F0901 from ETL - run package to update F0901, F0909
-- Doc this in Wiki -- DO IT! 31 May 22

--> START to STOP *** Manually ****

-- moved to weekly proc
-- Prod
-- EXECUTE pricing.order_note_post_proc @bDebug=0

--> Part 1: STOP

-------------------------------------------------------------------------------
-- Part 2 - HSB update, run after ME snapshot (comm, Monday tasks)
-- http://wiki.br.hsa.ca/wiki/Commission_Backend_BR_Docs_384#Monthend_snapshot
-------------------------------------------------------------------------------

-- moved to monthly proc
-- Prod
-- EXEC dbo.monthend_snapshot_proc @bDebug=0

--> STOP (part 2)

-------------------------------------------------------------------------------
-- Part 3 - Global update that is consistent with finacial
--				run after ME adjustment loaded (day 7+)
-------------------------------------------------------------------------------

-- moved to monthly proc
-- Prod
-- EXEC dbo.monthend_finalize_proc @bDebug=0

-- Prod
-- EXEC hfm.global_cube_update_proc @bDebug=0

-- Debug, 1m
-- EXEC hfm.global_cube_update_proc @bDebug=1



-------------------------------------------------------------------------------
-- Part 5 - export file
-------------------------------------------------------------------------------

--
-- 1. set results to file, CSV format
-- 2. copy below
-- a_CAN_May-22_RA.csv
-- TEMP use Access to fix source
-- 3. select & run below
-- [hfm].global_cube_new_proc  202212

-------------------------------------------------------------------------------

