SELECT
    i.Item,
    lym.CorporatePrice AS BaseCAD_LYM,
    pm.CorporatePrice AS BaseCAD_LM,
    tm.CorporatePrice AS BaseCAD_TM,
    lym.SupplierCostCAD AS FileCostCAD_LYM,
    pm.SupplierCostCAD AS FileCostCAD_LM,
    tm.SupplierCostCAD AS FileCostCAD_TM,
    tm.Currency,
    lym.SupplierCost AS FileCost_LYM,
    pm.SupplierCost AS FileCost_LM,
    tm.SupplierCost AS FileCost_TM,
    lym.CalMonth AS LYM,
    pm.CalMonth AS PM,
    tm.CalMonth AS TM
FROM
    zzzItem AS i
    LEFT OUTER JOIN BRS_ItemBaseHistory AS tm ON i.Item = tm.Item
    AND tm.CalMonth = 202511

    LEFT OUTER JOIN BRS_ItemBaseHistory AS pm ON i.Item = pm.Item
    AND pm.CalMonth = 202510

    LEFT OUTER JOIN BRS_ItemBaseHistory AS lym ON i.Item = lym.Item
    AND lym.CalMonth = 202510

WHERE
    --		(i.Item = '7770135') AND
    (1 = 1)