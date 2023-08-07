FROM google/cloud-sdk

RUN apt-get update && apt-get install -y python3
RUN pip install catboost google-cloud gcloud \
    pandas google-cloud-storage gcsfs fastparquet \
    pyarrow

COPY score_model.py ./

ENTRYPOINT ["python3","score_model.py"]