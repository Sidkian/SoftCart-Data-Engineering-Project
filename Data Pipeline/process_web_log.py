# import the libraries

from datetime import timedelta

# The DAG object; we'll need this to instantiate a DAG

from airflow import DAG

# Operators; we need this to write tasks!

from airflow.operators.bash_operator import BashOperator

# This makes scheduling easy

from airflow.utils.dates import days_ago


#defining DAG arguments

default_args = { 
	'owner':'Me',
	'start_date': days_ago(0),
	'email':['testemail@somemail.com'],
	'email_on_failure': False,
	'email_on_retry': False,
	'retries': 1,
	'retry_delay': timedelta(minutes=5)
}


# defining the DAG


dag = DAG(
	'process_web_log',
	default_args=default_args,
	description='Analyze the web server log file',
	schedule_interval=timedelta(days=1),
)


# define the first task : extract the ipaddress field from the web server log file and save it into a file named extracted_data.txt

extract_data = BashOperator(
	task_id = 'extract_data',
	bash_command='grep -oE "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}" /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted_data.txt',
	dag=dag
)


# define the second task : filter out all the occurrences of ipaddress “198.46.149.143” from extracted_data.txt and save the output to a file named transformed_data.txt

transform_data = BashOperator(
	task_id = 'transform_data',
	bash_command='grep "198\.46\.149\.143" /home/project/airflow/dags/capstone/extracted_data.txt > /home/project/airflow/dags/capstone/transformed_data.txt',
	dag=dag
)

# define the third task : archive the file transformed_data.txt into a tar file named weblog.tar

load_data = BashOperator(
	task_id = 'load_data',
	bash_command='tar -czvf /home/project/airflow/dags/capstone/weblog.tar.gz /home/project/airflow/dags/capstone/transformed_data.txt',
	dag=dag
)


# task pipeline

extract_data >> transform_data >> load_data