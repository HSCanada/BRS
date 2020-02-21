SELECT        PJAN8__billto, PJASN__adjustment_schedule
FROM            Pricing.price_adjustment_enroll_F40314
GROUP BY PJAN8__billto, PJASN__adjustment_schedule

UNION

SELECT        ADAN8__billto, ADAST__adjustment_name
FROM            Integration.F4072_price_adjustment_detail_Staging
WHERE	ADAN8__billto > 0 AND
	ADAST__adjustment_name not in('USENDDCC', 'USEND123', 'ADC02ALT', 'USENDALT', 'USENDJAF') AND
	(1=1)
GROUP BY ADAST__adjustment_name, ADAN8__billto

/* 
SELECT        distinct SNAST__adjustment_name, PJASN__adjustment_schedule
FROM            Pricing.price_adjustment_enroll

*/
