CREATE TABLE total_sales_per_country (total_sales, country) AS (
    SELECT sum(amount), country
    FROM FactSales
    LEFT JOIN DimCountry
    ON FactSales.countryid = DimCountry.countryid
    GROUP BY country
)
DATA INITIALLY DEFERRED
REFRESH DEFERRED
MAINTAINED BY SYSTEM;