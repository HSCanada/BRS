/****** Script for SelectTopNRows command from SSMS  ******/
INSERT INTO hfm.global_product
(global_product_class
,global_product_class_descr
,parent
,level_num
,active_ind
,note
,GLBU_Class_map)
SELECT
'930-99' AS global_product_class
,'bus soln other' AS global_product_class_descr
,parent
,level_num
,active_ind
,note
,GLBU_Class_map
FROM            hfm.global_product AS global_product_1
WHERE        (global_product_class = '930-30      ')
GO

SELECT
*
FROM            hfm.global_product AS global_product_1
WHERE        (global_product_class = '930-99      ')
