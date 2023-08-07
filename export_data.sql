EXPORT DATA
    OPTIONS(
             uri='gs://{INSERT PROJET HERE}/input_data/*.parquet',
             format='PARQUET',
             overwrite=true
            )
  AS SELECT plurality,mother_age,father_age,ever_born,cigarettes_per_day,drinks_per_week,weight_gain_pounds FROM `bigquery-public-data.samples.natality`;