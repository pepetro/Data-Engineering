from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyTableOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyDatasetOperator

# Define GCP variables
GCS_BUCKET = 'andela-data-lake-composer-pep-dev-composer-bucket'
GCS_OBJECT_PATH = 'data/withdrawals_sample_data.csv'  # Path to the CSV file
BQ_PROJECT_ID = 'andela-data-lake-dev'
BQ_DATASET_NAME = 'demo'
BQ_TABLE_NAME = 'withdrawals'

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}

# Define the DAG
with DAG(
    'gcs_to_bigquery_withdrawals',
    default_args=default_args,
    description='Load CSV from GCS to BigQuery',
    schedule_interval=None,  # Set to None for manual run, or use a cron schedule
    start_date=days_ago(1),
    catchup=False,
) as dag:

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
            {"name": "id", "type": "INTEGER", "mode": "REQUIRED"},
            {"name": "event_timestamp", "type": "TIMESTAMP", "mode": "REQUIRED"},
            {"name": "user_id", "type": "STRING", "mode": "REQUIRED"},
            {"name": "amount", "type": "NUMERIC", "mode": "REQUIRED"},
            {"name": "interface", "type": "STRING", "mode": "NULLABLE"},
            {"name": "currency", "type": "STRING", "mode": "REQUIRED"},
            {"name": "tx_status", "type": "STRING", "mode": "REQUIRED"}
        ],
    )

    # Task to load data from GCS to BigQuery
    load_csv_to_bq = GCSToBigQueryOperator(
        task_id='load_csv_to_bq',
        bucket=GCS_BUCKET,
        source_objects=[GCS_OBJECT_PATH],
        destination_project_dataset_table=f'{BQ_PROJECT_ID}:{BQ_DATASET_NAME}.{BQ_TABLE_NAME}',
        schema_fields=[
            {"name": "id", "type": "INTEGER", "mode": "REQUIRED"},
            {"name": "event_timestamp", "type": "TIMESTAMP", "mode": "REQUIRED"},
            {"name": "user_id", "type": "STRING", "mode": "REQUIRED"},
            {"name": "amount", "type": "NUMERIC", "mode": "REQUIRED"},
            {"name": "interface", "type": "STRING", "mode": "NULLABLE"},
            {"name": "currency", "type": "STRING", "mode": "REQUIRED"},
            {"name": "tx_status", "type": "STRING", "mode": "REQUIRED"}
        ],
        write_disposition='WRITE_TRUNCATE',  # Overwrite table data if exists
        skip_leading_rows=1,  # Skip header row in the CSV
        source_format='CSV',
    )

    # Task dependencies
    create_bq_dataset >> create_bq_table >> load_csv_to_bq
