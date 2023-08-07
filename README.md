# Scoring a Natality Model using GCP Serverless Services

This page is an example of how to quickly turn arbitary model code into a production pipeline for scoring batch tabular data in GCP. It creates a model from a publicly available dataset on BigQuery, 'natality-data' to predict the weight of a baby from some clinical factors, then scores it using GCP resources.

This entire scoring pipeline runs in **less than ten minutes, scoring ~140M rows, and cost is on the order of cents**. The length of time to score could be further reduced to just a minute or two by using parallel calls to the Cloud Function.

Reaons to do this:
- you have data in a database and some model scoring code, and you want to quickly populate a table with scores
- you want to minimize costs by only paying for the compute you need
- you want to avoid configuring infrastructure

Requirements:
1. A GCP account
2. An environment with gcloud and Python.

Steps:
1. Build a model from a sample of a BigQuery table, and save the model in GCS (example in Natality Model.ipynb)
2. Export the features of your full dataset you want to score on to parquet files in GCS (example in export_data.sql)
3. Create a Cloud Function that scores each input parquet file on GCS and puts it out into an output file also on GCS (exampmle in cloud_function.py). Other options are discussed below.
4. Collect the output parquet files into a BigQuery table (example in load_scores.sh). There's a commented out line for creating the table. The schema is inferred from the parquet files.

![Architecture Diagram](Workflow.png)

Some other serverless options for scoring are Vertex AI, Cloud Run, or Batch. Cloud Run is better than Cloud Functions if scoring each file takes over 9-10 minutes or if your model is in a language not supported by Cloud Functions, like R. You'll have to Dockerize your scoring code- an example is in the cloud_run folder in this project. Vertex AI is a larger ML development platform by Google and includes lots of other features for ML development. Batch is currently in preview, and looks like it's similar to AWS Batch.