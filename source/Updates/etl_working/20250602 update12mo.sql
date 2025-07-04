SELECT   TOP (10) ShipTo, Est12MoMerch, Est12MoTotal
FROM     BRS_Customer
order by 3 desc

UPDATE   BRS_Customer
SET        Est12MoMerch = 0, Est12MoTotal = 0

UPDATE   BRS_Customer
SET        Est12MoMerch = [val1], Est12MoTotal = [val2]
FROM     BRS_Customer INNER JOIN
             zzzShipto2 ON BRS_Customer.ShipTo = zzzShipto2.ST