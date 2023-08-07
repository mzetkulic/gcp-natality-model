PROJECT=''
#authorize, will require you to follow link. This lets you push to GCR
#gcloud auth login --no-launch-browser

#Configures docker so that when building, you can push to GCR
#gcloud auth configure-docker us-docker.pkg.dev

#Build the docker container, might take a few minutes.
docker build -t natality-model .

#Tag the docker container as 'latest'. You'll need to create a repository in GCP's Artifact Registry.
docker tag natality-model:latest us-docker.pkg.dev/$PROJECT/natality-model/natality-model:latest

#Push your container
docker push us-docker.pkg.dev/$PROJECT/natality-model/natality-model:latest