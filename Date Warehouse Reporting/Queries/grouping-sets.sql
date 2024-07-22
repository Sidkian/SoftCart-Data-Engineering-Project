SELECT
	category,
	country,
	sum(amount) as totalsales

FROM
    FactSales as fsales
	
LEFT JOIN 
    DimCategory as dcat
ON 
    fsales.categoryid = dcat.categoryid

LEFT JOIN 
    DimCountry as dcountry
ON 
    fsales.countryid = dcountry.countryid

GROUP BY
    GROUPING SETS (country,category)

ORDER BY
    country,category