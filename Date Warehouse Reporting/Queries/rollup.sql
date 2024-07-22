SELECT
    year,
    country,
    SUM(amount) as totalsales

FROM
    FactSales as fsales

LEFT JOIN
    Dimcountry as dcountry
ON
    fsales.countryid = dcountry.countryid
    
LEFT JOIN
    DimDate as ddate
ON
    fsales.dateid = ddate.dateid

GROUP BY
    ROLLUP (year, country)

ORDER BY 
    year, country