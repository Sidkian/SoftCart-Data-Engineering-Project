# Online Transactional Processing Database

MySQL is used as the Online Transactional Processing Database (OLTP) database. We will:

* Design the schema for the OLTP database based on the [oltp data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/oltpdata.csv) given
* Load the[oltp data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/oltpdata.csv) into the OLTP database
* Perfrom admin tasks such as creating index and a [datadump.sh](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/datadump.sh) bash script to backup the database using mysqldump

NOTE: This part of the project uses Cloud IDE based on Theia and MySQL running in a Docker container.

## Create MySQL Database

Using phpMyAdmin or MySQL CLI:

* Create a database named sales:

    ```sql
    CREATE DATABASE sales;
    ```

* Create a table called sales_data based on the sample data:

    ![Sample Data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/Images/sample-data.png)

    ```sql
    CREATE TABLE `sales`.`sales_data` (
        `product_id` BIGINT NOT NULL,
        `customer_id` BIGINT NOT NULL,
        `price` INT NOT NULL,
        `quantity` INT NOT NULL,
        `timestamp` DATETIME NOT NULL
    );
    ```

## Load Data

* Load the [oltpdata.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/oltpdata.csv) into the sales_data table using phpMyAdmin

    ![Import Data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/Images/import-data.jpg)

* Verify the table using:

    ```sql
    SHOW FULL TABLES WHERE table_type = 'BASE_TABLE';
    ```

    ![List Tables](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/Images/list-tables.jpg)

* Verify data load by running a query to count the records in sales_data:

    ```sql
    SELECT COUNT(*) FROM sales_data;
    ```

    ![sales_data Record Count](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/Images/sales-data-record-count.JPG)

    The record count matches the count on the import file

## Admin Tasks

* Create an index named ts on timestamp field:

    ```sql
    CREATE INDEX ts ON sales_data (timestamp);
    ```

* Verify index was created:

    ```sql
    SHOW INDEX FROM sales_data;
    ```

    ![List Indexes](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/Images/list-indexes.jpg)

* Create a bash script to export data from sales database:

    [datadump.sh](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/OLTP%20Database/datadump.sh)

    This script exports all data from the sales database using mysqldump and store in a .sql file with a timestamp

    Update the permissions on the script:

    ```
    sudo chmod u+x datadump.sh
    ```
    