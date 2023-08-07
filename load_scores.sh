PROJECT=''
# To create scores dataset (can just use your own):
# bq --location=US mk -d --default_table_expiration 3600 --description "These are my scores." scores
bq load --source_format=PARQUET scores.natality "gs://$PROJECT/output_data/*.parquet"
