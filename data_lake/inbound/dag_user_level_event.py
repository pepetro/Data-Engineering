import pandas as pd
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyTableOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyDatasetOperator

# Define GCP variables
GCS_BUCKET = 'andela-data-lake-composer-pep-dev-composer-bucket'
GCS_SOURCE_OBJECT_PATH = 'data/user_level_sample_data.csv'
GCS_OBJECT_PATH = 'data/user_level_sample_data_filtered.csv'
BQ_PROJECT_ID = 'andela-data-lake-dev'
BQ_DATASET_NAME = 'demo'
BQ_TABLE_NAME = 'user_level_event'

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}


# Dataset cleansing:
# 1) Remove duplicate records from source file
# 2) Remove records with nulls at any column
def clean_ds():
    df = pd.read_csv('gs://' + GCS_BUCKET + '/' + GCS_SOURCE_OBJECT_PATH,
                     usecols=['user_id', 'jurisdiction', 'level', 'event_timestamp']).drop_duplicates(keep='first')
    df_filtered = df[df.notnull().all(1)]
    df_filtered.to_csv('gs://' + GCS_BUCKET + '/' + GCS_OBJECT_PATH, index=False)


# Define the DAG
with DAG(
    'gcs_to_bigquery_users_level_events',
    default_args=default_args,
    description='Load CSV from GCS to BigQuery',
    schedule_interval=None,  # Set to None for manual run, or use a cron schedule
    start_date=days_ago(1),
    catchup=False,
) as dag:

    inbound_process = PythonOperator(
        task_id='inbound_process',
        provide_context=True,
        python_callable=clean_ds,
    )

    # Task to create the BigQuery dataset if it doesn't exist
    create_bq_dataset = BigQueryCreateEmptyDatasetOperator(
        task_id='create_bq_dataset',
        project_id=BQ_PROJECT_ID,
        dataset_id=BQ_DATASET_NAME,
        location='US',  # Set the region according to your need
    )

    # Task to create the BigQuery table if it doesn't exist
    create_bq_table = BigQueryCreateEmptyTableOperator(
        task_id='create_bq_table',
        project_id=BQ_PROJECT_ID,
        dataset_id=BQ_DATASET_NAME,
        table_id=BQ_TABLE_NAME,
        schema_fields=[
            {"name": "user_id", "type": "STRING", "mode": "REQUIRED"},
            {"name": "jurisdiction", "type": "STRING", "mode": "NULLABLE"},
            {"name": "level", "type": "STRING", "mode": "REQUIRED"},
            {"name": "event_timestamp", "type": "TIMESTAMP", "mode": "REQUIRED"}
        ],
    )

    # Task to load data from GCS to BigQuery
    load_csv_to_bq = GCSToBigQueryOperator(
        task_id='load_csv_to_bq',
        bucket=GCS_BUCKET,
        source_objects=[GCS_OBJECT_PATH],
        destination_project_dataset_table=f'{BQ_PROJECT_ID}:{BQ_DATASET_NAME}.{BQ_TABLE_NAME}',
        schema_fields=[
            {"name": "user_id", "type": "STRING", "mode": "REQUIRED"},
            {"name": "jurisdiction", "type": "STRING", "mode": "NULLABLE"},
            {"name": "level", "type": "STRING", "mode": "REQUIRED"},
            {"name": "event_timestamp", "type": "TIMESTAMP", "mode": "REQUIRED"}
        ],
        write_disposition='WRITE_TRUNCATE',  # Overwrite table data if exists
        skip_leading_rows=1,  # Skip header row in the CSV
        source_format='CSV',
    )

    # Task dependencies
    inbound_process >> create_bq_dataset >> create_bq_table >> load_csv_to_bq
