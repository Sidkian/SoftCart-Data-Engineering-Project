# Extract Transform Load

Python script is used to the extract incremental data from staging data warehouse and load it into production data warehouse. We will:

* Prepare a MySQL database that will act as the staging data warehouse using [sales.sql](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/sales.sql) and [mysqlconnect.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/mysqlconnect.py)
* Prepare a IBM DB2 database that will act as the staging data warehouse using [db2connect.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/db2connect.py)
* Create a python script to extract incremental data from staging data warehouse and load it into production data warehouse

NOTE: This part of the project uses Cloud IDE based on Theia, MySQL database running in a Docker container and an instance of DB2 running in IBM Cloud.

## Prepare Staging Data Warehouse

* Create a database named sales:

    ```sql
    CREATE DATABASE sales;
    ```

* Run the [sales.sql](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/sales.sql) script in the sales database to create a table named sales_data and load sample data into it. The sales_data table has the following columns:

    * rowid (PK) (AI)
    * product_id
    * customer_id
    * quantity

* Install the connector mysql-connector-python by using the command:

    ```
    python3 -mpip install mysql-connector-python==8.0.31
    ```

* Execute the [mysqlconnect.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/mysqlconnect.py) script that does the following:

    * Connects to the MySQL sales database using mysql.connector
    * Creates products table if it doesn't exits with fields:
        * rowid (PK) (AI)
        * product
        * category
    * Loads data into products table
    * Outputs rows in the product table

    ```
    python3 mysqlconnect.py
    ```

## Prepare Production Data Warehouse

* Create an instance of IBM DB2 and setup a table named sales_data with the following fields:

    * rowid
    * product_id
    * customer_id
    * price
    * quantity
    * timestamp

    Load [sales.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/sales.csv) data into sales_data table.

* Since the sales_data table in the production data warehouse has price and timestamp columns that are not present in sales_data table in the staging data warehouse, we must ensure that for any new values, the price column will be updated to 0 by default, and the timestamp will be updated with the current timestamp. We can do this by running the following:

    ```sql
    ALTER TABLE sales_data ALTER COLUMN timestamp SET data type timestamp;
    ALTER TABLE sales_data ALTER COLUMN timestamp SET NOT NULL;
    ALTER TABLE sales_data ALTER COLUMN timestamp SET DEFAULT CURRENT_TIMESTAMP;

    ALTER TABLE sales_data ALTER COLUMN price SET data type decimal;
    ALTER TABLE sales_data ALTER COLUMN price SET DEFAULT 0;
    ```

* Install the connector ibm-db by using the command:

    ```
    python3 -mpip install ibm-db
    ``` 

* Execute the [db2connect.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/db2connect.py) script that does the following:

    * Connects to DB2 using ibm-db
    * Creates products table if it doesn't exits with fields:
        * rowid (PK)
        * product
        * category
    * Loads data into products table
    * Outputs rows in the product table

    ```
    python3 db2connect.py
    ```

## Create Python Script

With the staging and production data warehouses prepared, we can create [automation.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/ETL/automation.py) script that does the following:

* Connect to MySQL using mysql.connector and IBM DB2 using ibm_db
* Retrieve the row id of the last row in the sales_data table in DB2 and store it in last_row_id
* Retrieve a list of all records in sales_data table in MySQL with row id greater that last_row_id and store it in new_records
* Insert all new_records into sales_data table in DB2

To execute the python script:

```
python3 automation.py
```