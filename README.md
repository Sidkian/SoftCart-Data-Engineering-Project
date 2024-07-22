# IBM Data Engineering Capstone Project

Technology used: MySQL, MongoDB, PostgreSQL, DB2 on Cloud, IBM Cognos Analytics, Python, Apache Airflow, Hadoop, Spark

## Abstract

This captsone project is part of the IBM Data Engineering Professional Certificate.

The task is to build a data platform for retailer data analytics by assuming the role of an Associate Data Engineer who has recently joined an e-commerce organization called SoftCart.

## Objective

* Design a data platform that uses MySQL as an OLTP database and MongoDB as a NoSQL database. 
* Design and implement a data warehouse and generate reports from the data. 
* Design a reporting dashboard that reflects the key metrics of the business. 
* Extract data from OLTP and NoSQL databases, transform it and load it into the data warehouse, and then create an ETL pipeline. 
* Create a Spark connection to the data warehouse, and then deploy a machine learning model

## About the Company

* SoftCart, an e-commerce company, uses a hybrid architecture with some of its databases on premises and some on cloud
* SoftCart's online presence is primarily through its website, which customers access using a variety of devices like laptops, mobiles and tablets.
* All catalog data of the products is stored in the MongoDB NoSQL server and all transactional data like inventory and sales are stored in the MySQL database server. SoftCart's webserver is driven entirely by these two databases.
* Data is periodically extracted from these two databases and put into the staging data warehouse running on PostgreSQL.
* The production data warehouse is on the cloud instance of IBM DB2 server.
* BI teams connect to the IBM DB2 for operational dashboard creation. IBM Cognos Analytics is used to createdashboards.
* SoftCart uses Hadoop cluster as its big data platform where all the data is collected for analytics purposes.
* Spark is used to analyse the data on the Hadoop cluster.
* To move data between OLTP, NoSQL and the data warehouse, ETL pipelines are used and these run on Apache Airflow.

# Project Assignment Outputs

## OLTP Database: MySQL

Documentation: [OLTP Database](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/OLTP-Database.md)

MySQL is used to design the OLTP database for the E-Commerce website. The `sales` OLTP Database design is based on the [oltp data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/oltpdata.csv) provided. The data is loaded into `sales_data` table, and a [datadump.sh](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/datadump.sh) bash script is created to take backups using mysqldump.

## NoSQL Database: MongoDB

Documentation: [NoSQL Database](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/NoSQL-Database.md)

MongoDB is used to set up a NoSQL database for the E-Commerce website. The `catalog` NoSQL database is created and [catalog data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/catalog.json) is loaded into `electronics` collection using mongoimport. Also, [electronics.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/electronics.csv) containing a subset of fields is exported from the `electronics` collection using mongoexport

## Data Warehouse: PostgreSQL

Documentation: [Data Warehouse](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/Data-Warehouse.md)

PostgreSQL is used to design and create the [data warehouse schema](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/data-warehouse-schema.sql) using pgAdmin's ERD Design Tool. The star schema design is based on the [sample order data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/Images/sample-order-data.JPG) provided.

![Data Warehouse ERD](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/Images/data-warehouse-ERD.JPG)

Fact Table: `softcartFactSales`

Dimension Tables: `softcartDimDate` , `softcartDimCategory` , `softcartDimCountry` , `softcartDimItem`

## Data Warehouse Reporting: IBM DB2

Documentation: [Data Warehouse Reporting](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data-Warehouse-Reporting.md)

IBM DB2 is used to generate reports out of the data in the data warehouse. [Data warehouse schema](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/data-warehouse-schema-adjusted.sql) is used to create the data warehouse and the following data is loaded:

* [DimDate.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimDate.csv)
* [DimCategory.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimCategory.csv)
* [DimCountry.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/DimCountry.csv)
* [FactSales.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Data/FactSales.csv)

The following queries and MQT are created for data analytics:

* [Total Sales by Country & Category Grouping Sets](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Queries/grouping-sets.sql)
* [Total Sales by Year & Country Rollup](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Queries/rollup.sql)
* [Average Sales by Year & Country Cube](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Queries/cube.sql)
* [Materialized Query Table for Total Sales per Country](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Date%20Warehouse%20Reporting/Queries/mqt.sql)

## Reporting Dashboard: IBM Cognos Analytics

IBM Cognos Analytics is used to design a reporting dashboard that reflects the key metrics of the business. [Ecommerce.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Reporting%20Dashboard/ecommerce.csv) is load into `sales_history` table in the DB2 warehouse and used to generate the following reports:

* Month wise total sales for the year 2020

    ![Line Chart](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Reporting%20Dashboard/Images/linechart.JPG)

* Category wise total sales

    ![Pie Chart](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Reporting%20Dashboard/Images/piechart.JPG)

* Quarterly sales of mobile phones

    ![Bar Chart](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Reporting%20Dashboard/Images/barchart.JPG)

## ETL: Python

Documentation: [ETL](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/ETL.md)

Python is used to perform incremental data load from staging data warehouse to production data warehouse and sync up the databases. [automation.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/automation.py) python script connects to the staging and production data warehouses and loads all new records since last load from staging to production.

## Data Pipeline: Apache Airflow

Documentation: [Data Pipeline](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Pipeline/Data-Pipeline.md)

Airflow is used to create a data pipeline that analyzes the [web server log](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Pipeline/accesslog.txt). The [process_web_log](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Pipeline/process_web_log.py) dag:

* Extracts the ipaddress field from the web server log file and saves it into text file
* Filters out all the occurrences of ipaddress “198.46.149.143” from the text file and saves the output to a new text file
* Load the data by archiving the transformed text file into a TAR file

# Big Data Analytics: Spark

Documentation: [Big Data Analytics](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/Big-Data-Analytics.md)

Spark is used to analyze search terms on the e-commerce web server provided in [searchterms.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/searchterms.csv). [Spark.ipynb](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/Spark.ipynb) loads data into a spark dataframe and queries it to answer questions like the number of times the term `gaming laptop` was searched or what are the top 5 most frequently used search terms. Also, a pre-trained sales forecasting model is used this to predict the sales for 2023.








