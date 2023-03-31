--Archive data, tmc, 28 Mar 23

-- Daily Sales - Archive

-- find oldest month
SELECT top 10 * FROM      BRSales.dbo.BRS_Transaction where FiscalMonth < 201901 order by 1

-- from 1 year from prod to cold storage
SELECT *        
INTO              BRS_Transation_2015
FROM            BRSales.dbo.BRS_Transaction
WHERE        (FiscalMonth between 201501 and 201512)
GO

SELECT *        
INTO              BRS_Transation_2016
FROM            BRSales.dbo.BRS_Transaction
WHERE        (FiscalMonth between 201601 and 201612)
GO

SELECT *        
INTO              BRS_Transation_2017
FROM            BRSales.dbo.BRS_Transaction
WHERE        (FiscalMonth between 201701 and 201712)
GO


SELECT *        
INTO              BRS_Transation_2018
FROM            BRSales.dbo.BRS_Transaction
WHERE        (FiscalMonth between 201801 and 201812)
GO


-- Daily Sales - purge 2015
print '1 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201501)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201502)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201503)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201504)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201505)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201506)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201507)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201508)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201509)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201510)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201511)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201512)
GO

-- Daily Sales - purge 2016
print '1 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201601)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201602)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201603)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201604)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201605)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201606)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201607)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201608)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201609)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201610)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201611)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201612)
GO

-- Daily Sales - purge 2017
print '1 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201701)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201702)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201703)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201704)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201705)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201706)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201707)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201708)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201709)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201710)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201711)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201712)
GO

-- Daily Sales - purge 2018
print '1 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201801)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201802)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201803)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201804)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201805)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201806)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201807)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201808)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201809)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201810)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201811)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.BRS_Transaction WHERE        (FiscalMonth= 201812)
GO

-- XXX
-- DW purge 2013 - 2019
use BRSales_archive

-- find oldest month
SELECT top 10 * FROM      BRSales.dbo.[BRS_TransactionDW] where CalMonth < 201901 order by 1

-- from 1 year from prod to cold storage

print '2013'
SELECT *        
INTO              BRS_TransactionDW_2013
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201301 and 201312)
GO

print '2014'
SELECT *        
INTO              BRS_TransactionDW_2014
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201401 and 201412)
GO

print '2015'
SELECT *        
INTO              BRS_TransactionDW_2015
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201501 and 201512)
GO

print '2016'
SELECT *        
INTO              BRS_TransactionDW_2016
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201601 and 201612)
GO

print '2017'
SELECT *        
INTO              BRS_TransactionDW_2017
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201701 and 201712)
GO

print '2018'
SELECT *        
INTO              BRS_TransactionDW_2018
FROM            BRSales.dbo.[BRS_TransactionDW]
WHERE        (CalMonth between 201801 and 201812)
GO

print 'Daily Sales - purge 2013'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201301)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201302)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201303)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201304)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201305)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201306)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201307)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201308)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201309)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201310)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201311)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201312)
GO

print 'Daily Sales - purge 2014'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201401)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201402)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201403)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201404)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201405)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201406)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201407)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201408)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201409)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201410)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201411)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201412)
GO

print 'Daily Sales - purge 2015'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201501)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201502)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201503)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201504)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201505)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201506)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201507)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201508)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201509)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201510)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201511)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201512)
GO

print 'Daily Sales - purge 2016'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201601)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201602)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201603)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201604)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201605)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201606)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201607)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201608)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201609)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201610)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201611)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201612)
GO

print 'Daily Sales - purge 2017'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201701)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201702)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201703)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201704)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201705)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201706)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201707)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201708)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201709)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201710)
GO
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201711)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201712)
GO

print 'Daily Sales - purge 2018'
print '1 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201801)
GO
print '2 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201802)
GO
print '3 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201803)
GO
print '4 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201804)
GO
print '5 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201805)
GO
print '6 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201806)
GO
print '7 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201807)
GO
print '8 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201808)
GO
print '9 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201809)
GO
print '10 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201810)
GO
-- this left for FG xref
print '11 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201811)
GO
print '12 of 12'
DELETE FROM            BRSales.dbo.[BRS_TransactionDW] WHERE        (CalMonth= 201812)
GO

