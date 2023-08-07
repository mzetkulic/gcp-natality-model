import functions_framework
import catboost
import pandas as pd
import gcsfs 
import pickle
from google.cloud import storage

project = ''
@functions_framework.http
def score_model(request):
    request_json = request.get_json()
    input_file = request_json['input_file']
    num = input_file.split('/')[-1][:-8]
    #Load in model
    storage_client = storage.Client()
    bucket = storage_client.bucket(project)
    blob = bucket.blob('catboost_model.pickle')
    pickle_in = blob.download_as_string()

    my_model = pickle.loads(pickle_in)

    #Read in data
    df = pd.read_parquet('gs://'+project+'/input_data/'+num+'.parquet')

    #score model
    scores = my_model.predict(df)
    scores = pd.DataFrame(scores)

    #write model to parquet
    scores.to_parquet('gs://'+project+'/output_data/'+num+'.parquet',index=False)
    return 'OK'