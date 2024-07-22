# Data Warehouse Reporting

IBM DB2 is used the Production Data Warehouse. By adjusting the schema generated to production needs, we will:

* Create & load data into IBM DB2 database
* Generate queries and MQT for data analysis

NOTE: This part of the project uses Cloud IDE based on Theia and an instance of DB2 running in IBM Cloud.

# Prepare IBM DB2 Database

* Create IBM DB2 database using [sql file](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/data-warehouse-schema-adjusted.sql) which will create the following tables:

    * DimDate
    * DimCategory
    * DimCountry
    * FactSales

* Load data from the following files into the tables:

    * [DimDate.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimDate.csv)
    * [DimCategory.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimCategory.csv)
    * [DimCountry.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimCountry.csv)
    * [FactSales.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/FactSales.csv)

## Queries for Data Analysis

* Create a grouping sets query using the columns country, category and totalsales.

    ```sql
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
    ```

* Create a rollup query using the columns year, country, and totalsales.

    ```sql
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
    ```

* Create a cube query using the columns year, country, and average sales.

    ```sql
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
    ```

* Create an MQT named total_sales_per_country that has the columns country and total_sales.

    ```sql
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
    ```
    To populate the MQT with data, run:

    ```sql
    REFRESH TABLE total_sales_per_country;
    ```
