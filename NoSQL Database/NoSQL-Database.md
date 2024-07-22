# NoSQL Database

MongoDB is used as the NoSQL Database. We will:

* Install MongoDB database tools
* Create database and collection and import [catalog data](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/catalog.json) into the collection using mongoimport
* Query MongoDB Database
* Create index
* Query the data in MongoDB Database
* Export data into [electronics.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/electronics.csv) using mongoimport

NOTE: This part of the project uses Cloud IDE based on Theia and MongoDB running in a Docker container.

## Install MongoDB database tools

We need the ‘mongoimport’ and ‘mongoexport’ tools to move data in and out of the mongodb database.

* Download the tar file for you distribution:

    ```
    wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
    ```

* Extract the file:

    ```
    tar -xf mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
    ```

* Add binary to PATH:

    ```
    export PATH=$PATH/:home/project/mongodb-database-tools-ubuntu1804-x86_64-100.3.1/bin
    ```

* Verify the tools were installed:

    ```
    mongoimport --version
    ```

    This should display the version number, verfiying the install

## Create the Database and Import Data

Using MongDB CLI or mongo-express UI:

* Create a database named catalog:

    ```
    use catalog
    ```

* Create a collection name electronics in the catalog database:

    ```
    db.createCollection("electronics")
    ```
    
* From the terminal, import [catalog.json](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/catalog.json) using mongoimport:

    ```
    mongoimport -u root -p PASSWORD --authenticationDatabase admin --db catalog --collection electronics --file catalog.json
    ```

## Query the Database

* Display all database by running the following command in MongoDB CLI:

    ```
    show dbs
    ```

    ![List DBS](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/list-dbs.JPG)

* Display all collections in the catalog database by running the following command in MongoDB CLI:

    ```
    show collections
    ```

    ![List Collections](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/list-collections.JPG)

## Create Index

* Create an index on field "type":

    ```
    db.electronics.createIndex({"type" : 1})
    ```

    ![Create Index](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/create-index.JPG)

## Query the Data

* Query the count of laptops:

    ```
    db.electronics.count({"type":"laptop"})
    ```

    ![Laptop Query](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/laptop-query.JPG)

* Query the number of smart phones with screen size of 6 inches:

    ```
    db.electronics.count({"type":"smart phone","screen size":6})
    ```

    ![Smart Phone Query 1](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/smart-phone-query-1.JPG)

* Query the average screen size of smart phones:

    ```
    db.electronics.aggregate([{$match: {"type": "smart phone"}},{$group: {_id:"$type", avg_val:{$avg:"$screen size"}}}])
    ```

    ![Smart Phone Query 2](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/Images/smart-phone-query-2.JPG)

## Export the Data

Create an export file named [electronics.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/NoSQL%20Database/electronics.csv) that contains fields _id, “type”, “model”, from the ‘electronics’ collection:

```
mongoexport -u root -p PASSWORD --authenticationDatabase admin --db catalog --collection electronics --fields _id,type,model --out electronics.csv
```



