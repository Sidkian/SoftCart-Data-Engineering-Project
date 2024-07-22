SELECT
	year,
	country,
	avg(amount) as averagesales

FROM
	FactSales as fsales
	
LEFT JOIN 
    DimCountry as dcountry
ON 
    fsales.countryid = dcountry.countryid

LEFT JOIN
    DimDate as ddate
ON
    fsales.dateid = ddate.dateid

GROUP BY
    CUBE ( year, country)

ORDER BY
    year, country