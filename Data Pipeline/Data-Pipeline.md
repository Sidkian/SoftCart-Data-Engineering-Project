# Data Pipeline

Airflow is used to create a data pipeline that analyzes the [web server log](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Pipeline/accesslog.txt), extracts the required lines and fields, transforms and loads the data. We will:

* Create a dag that:
    * Extracts the ipaddress field from the web server log file and saves it into a file named extracted_data.txt
    * Filters out all the occurrences of ipaddress “198.46.149.143” from extracted_data.txt and saves the output to a file named transformed_data.txt
    * Archives the file transformed_data.txt into a tar file named weblog.tar
* Submit and run the created dag

NOTE: This part of the project uses Cloud IDE based on Theia and Apache Airflow running in a Docker container.

## Create Dag

Create a dag file named web_server_log.py

* Define Imports

    Define all imports at the start of the file. These include python libraries, DAG, airflow operators and airflow utitlies:

    ```python
    from datetime import timedelta

    from airflow import DAG
    # The DAG object; we'll need this to instantiate a DAG

    from airflow.operators.bash_operator import BashOperator
    # Operators; we need this to write tasks!

    from airflow.utils.dates import days_ago
    # This makes scheduling easy
    ```

* Define DAG arguments

    Define any DAG arguments in default_args:

    ```python
    default_args = { 
	    'owner':'Me',
	    'start_date': days_ago(0),
	    'email':['testemail@somemail.com'],
	    'email_on_failure': False,
	    'email_on_retry': False,
	    'retries': 1,
	    'retry_delay': timedelta(minutes=5)
    }
    ```

* Define the DAG

    Create a DAG named process_web_log that runs daily:

    ```python
    dag = DAG(
	    'process_web_log',
	    default_args=default_args,
	    description='Analyze the web server log file',
	    schedule_interval=timedelta(days=1),
    )
    ```

* Create extract task

    Create a task named extract_data that extracts the ipaddress field from the web server log file and saves it into a file named extracted_data.txt:

    ```python
    extract_data = BashOperator(
	    task_id = 'extract_data',
	    bash_command='grep -oE "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}" /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted_data.txt',
	    dag=dag
    )
    ```

    The Bash Operator searches for a ip address within accesslog.txt using regex and stores the results in extracted_data.txt

* Create transform task

    Create a task named transform_data that filters out all the occurrences of ipaddress “198.46.149.143” from extracted_data.txt and saves the output to a file named transformed_data.txt:

    ```python
    transform_data = BashOperator(
	    task_id = 'transform_data',
	    bash_command='grep "198\.46\.149\.143" /home/project/airflow/dags/capstone/extracted_data.txt > /home/project/airflow/dags/capstone/transformed_data.txt',
	    dag=dag
    )
    ```

    The Bash Operator looks for the given ip address within extracted_data.txt using grep and stores it in transformed_data.txt

* Create load task

    Create a task named load_data that archives the file transformed_data.txt into a tar file named weblog.tar:

    ```python
    load_data = BashOperator(
	    task_id = 'load_data',
	    bash_command='tar -czvf /home/project/airflow/dags/capstone/weblog.tar.gz /home/project/airflow/dags/capstone/transformed_data.txt',
	    dag=dag
    )
    ```

* Define the task pipeline

    Create a pipeline to perform the extract, transform and load tasks sequentially.

    ```python
    extract_data >> transform_data >> load_data
    ```

This gives us the dag: [process_web_log.py](https://github.com/Sidkian/SoftCart-Data-Engineering-Project/blob/master/Data%20Pipeline/process_web_log.py)

## Submit and run the dag

* Submit the dag:

    ```
    cp process_web_log.py $AIRFLOW_HOME/dags
    ```

* Unpause the DAG:

    ```
    airflow dags unpause process_web_log
    ```

* Run the DAG:

    ```
    airflow dags trigger process_web_log
    ```


