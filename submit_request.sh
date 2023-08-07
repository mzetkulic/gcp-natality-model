PROJECT=''
FUNCTION_URL=''
for GCS_PATH in $( gsutil ls gs://$PROJECT/input_data)
do
    curl -X POST $FUNCTION_URL -H "Authorization: bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json" -d '{"input_file": "'$GCS_PATH'"}'
done