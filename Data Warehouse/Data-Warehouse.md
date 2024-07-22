# Data Warehouse

PostgreSQL is used as the staging data warehouse. We will:

* Design a data warehouse using the pgAdmin ERD design tool
* Create the schema in the data warehouse

NOTE: This part of the project uses Cloud IDE based on Theia and PostgreSQL running in a Docker container.

## Design Data Warehouse Schema

![Sample Order Data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/Images/sample-order-data.JPG)

The following dimension tables can be derived from the above sample order data:
* `softcartDimDate`:
    * dateid (PK)
    * date
    * quarter
    * quartername
    * month
    * monthname
    * day
    * weekday
    * weekdayname

* `softcartDimCategory`
    * categoryid (PK)
    * category

* `softcartDimItem`
    * itemid (PK)
    * item

* `softcartDimCountry`
    * countryid (PK)
    * country

This will result in the following fact table:
* `softcartFactSakes`
    * orderid (PK)
    * dateid (FK)
    * categoryid (FK)
    * countryid (FK)
    * itemid (FK)
    * price

## Create Data Warehouse Schema

![Data Warehouse ERD](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/Images/data-warehouse-ERD.JPG)

The schema designed in the ERD tool can used to generated a [sql file](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Warehouse/data-warehouse-schema.sql).
This sql file can be then used to create the schema.



