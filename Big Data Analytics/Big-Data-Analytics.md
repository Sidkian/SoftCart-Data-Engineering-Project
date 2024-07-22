# Big Data Analytics

Spark is used to analyze search terms on the e-commerce web server provided in [searchterms.csv](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/searchterms.csv). We will:

* Load the data file into a Spark data frame and query it
* Load a pre-trained [sales forecasting model](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/model.tar.gz) and use this to predict the sales for 2023

NOTE: This part of the project uses Juptyer Notebook

## Setup Spark

* Install Spark

    ```python
    !pip install pyspark
    !pip install findspark
    ```

* Start Session

    ```python
    import findspark
    findspark.init()

    from pyspark import SparkContext, SparkConf
    from pyspark.sql import SparkSession
    ```

* Create Spark Context & Session

    ```python
    sc = SparkContext()

    # Creating a spark session
    spark = SparkSession \
    .builder \
    .appName("Capstone").getOrCreate()
    ```

## Spark Dataframe

* Create a Spark Dataframe

    ```python
    import pandas as pd

    sdf = spark.createDataFrame(pd.read_csv('searchterms.csv'))
    ```

* Query the dataframe:

    * Count of rows and columns:

        ```python
        print('Number of rows: '+str(sdf.count()))
        print('Number of columns: '+str(len(sdf.columns)))
        ```
        ```
        Number of rows: 10000
        Number of columns: 4
        ```

    * Top 5 rows of the dataframe:

        ```python
        sdf.show(5)
        ```
        ```
        +---+-----+----+--------------+
        |day|month|year|    searchterm|
        +---+-----+----+--------------+
        | 12|   11|2021| mobile 6 inch|
        | 12|   11|2021| mobile latest|
        | 12|   11|2021|   tablet wifi|
        | 12|   11|2021|laptop 14 inch|
        | 12|   11|2021|     mobile 5g|
        +---+-----+----+--------------+
        only showing top 5 rows
        ```

    * Datatype of 'searchterm' column:

        ```python
        sdf.dtypes[3]
        ```
        ```
        ('searchterm', 'string')
        ```

    * Number of times the term `gaming laptop` was searched:

        ```python
        sdf.filter(sdf['searchterm'] == 'gaming laptop').count()
        ```
        ```
        499
        ```
    
    * Top 5 most frequently used search terms:

        ```python
        sdf.groupby(['searchterm']).agg({'day':'count'}).sort('count(day)',ascending=False).show(5)
        ```
        ```
        +-------------+----------+
        |   searchterm|count(day)|
        +-------------+----------+
        |mobile 6 inch|      2312|
        |    mobile 5g|      2301|
        |mobile latest|      1327|
        |       laptop|       935|
        |  tablet wifi|       896|
        +-------------+----------+
        only showing top 5 rows
        ```

## Sales Forcasting Model

* Load the sales forecast model:

    ```python
    !tar -xzf model.tar.gz

    from pyspark.ml.regression import LinearRegressionModel
    model = LinearRegressionModel.load('sales_prediction.model')
    ```

* Predict the sales for the year of 2023:

    ```python
    from pyspark.ml.feature import VectorAssembler

    def predict(year):
        assembler = VectorAssembler(inputCols=["year"],outputCol="features")
        data = [[year,0]]
        columns = ["year", "sales"]
        _ = spark.createDataFrame(data, columns)
        __ = assembler.transform(_).select('features','sales')
        predictions = model.transform(__)
        predictions.select('prediction').show()

    predict(2023)
    ```
    ```
    +------------------+
    |        prediction|
    +------------------+
    |175.16564294006457|
    +------------------+
    ```

The jupyter notebook is: [Spark.ipynb](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Big%20Data%20Analytics/Spark.ipynb)