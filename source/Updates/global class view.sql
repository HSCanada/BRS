/*
SELECT [global_product_class]
      ,[global_product_class_descr]
      ,[parent]
      ,[level_num]
      ,[counting_sku_ind]
  FROM [hfm].[global_product]
*/
  -- ORG 3085

SELECT 
g1.[global_product_class]
,g1.[global_product_class_descr]
,g1.global_product_class_key
-- LEVEL 1
,CASE
    WHEN g1.[level_num] = 1 THEN RTRIM(g1.[global_product_class]) + ' | ' + RTRIM(g1.[global_product_class_descr])
    WHEN g2.[level_num] = 1 THEN RTRIM(g2.[global_product_class]) + ' | ' + RTRIM(g2.[global_product_class_descr])
    WHEN g3.[level_num] = 1 THEN RTRIM(g3.[global_product_class]) + ' | ' + RTRIM(g3.[global_product_class_descr])
    WHEN g4.[level_num] = 1 THEN RTRIM(g4.[global_product_class]) + ' | ' + RTRIM(g4.[global_product_class_descr])
    ELSE '.'
END AS glob_prod_level1

-- LEVEL 2
,CASE
    WHEN g1.[level_num] = 2 THEN RTRIM(g1.[global_product_class]) + ' | ' + RTRIM(g1.[global_product_class_descr])
    WHEN g2.[level_num] = 2 THEN RTRIM(g2.[global_product_class]) + ' | ' + RTRIM(g2.[global_product_class_descr])
    WHEN g3.[level_num] = 2 THEN RTRIM(g3.[global_product_class]) + ' | ' + RTRIM(g3.[global_product_class_descr])
    WHEN g4.[level_num] = 2 THEN RTRIM(g4.[global_product_class]) + ' | ' + RTRIM(g4.[global_product_class_descr])
    ELSE '.'
END AS glob_prod_level2

-- LEVEL 3
,CASE
    WHEN g1.[level_num] = 3 THEN RTRIM(g1.[global_product_class]) + ' | ' + RTRIM(g1.[global_product_class_descr])
    WHEN g2.[level_num] = 3 THEN RTRIM(g2.[global_product_class]) + ' | ' + RTRIM(g2.[global_product_class_descr])
    WHEN g3.[level_num] = 3 THEN RTRIM(g3.[global_product_class]) + ' | ' + RTRIM(g3.[global_product_class_descr])
    WHEN g4.[level_num] = 3 THEN RTRIM(g4.[global_product_class]) + ' | ' + RTRIM(g4.[global_product_class_descr])
    ELSE '.'
END AS glob_prod_level3


-- LEVEL 4
,CASE
    WHEN g1.[level_num] = 4 THEN RTRIM(g1.[global_product_class]) + ' | ' + RTRIM(g1.[global_product_class_descr])
    WHEN g2.[level_num] = 4 THEN RTRIM(g2.[global_product_class]) + ' | ' + RTRIM(g2.[global_product_class_descr])
    WHEN g3.[level_num] = 4 THEN RTRIM(g3.[global_product_class]) + ' | ' + RTRIM(g3.[global_product_class_descr])
    WHEN g4.[level_num] = 4 THEN RTRIM(g4.[global_product_class]) + ' | ' + RTRIM(g4.[global_product_class_descr])
    ELSE '.'
END AS glob_prod_level4

-- LEVEL 4
,CASE
    WHEN g1.[level_num] = 4 THEN g1.counting_sku_ind
    WHEN g2.[level_num] = 4 THEN g2.counting_sku_ind
    WHEN g3.[level_num] = 4 THEN g3.counting_sku_ind
    WHEN g4.[level_num] = 4 THEN g4.counting_sku_ind
    ELSE 0
END AS counting_sku_ind


--      ,g1.[counting_sku_ind]

  FROM [hfm].[global_product] g1

  INNER JOIN [hfm].[global_product] g2
  on g1.parent = g2.global_product_class

  INNER JOIN [hfm].[global_product] g3
  on g2.parent = g3.global_product_class

  INNER JOIN [hfm].[global_product] g4
  on g3.parent = g4.global_product_class




