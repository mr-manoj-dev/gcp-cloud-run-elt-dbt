# gcp-cloud-run-elt-dbt-v1

This is a simple use case using DBT, BigQuery, GCP cloud build and cloud run.
The raw table as input data for DBT is a source for the models where 
DBT shall run transformation and aggregation over raw data and create and materialize into table.




## Publish the Docker image to Artifact Registry and deploy the Cloud Run job with Cloud Build

```bash
export PROJECT_ID=$(gcloud projects list --format="value(projectId)" | grep burner-mankumar24-02)
export LOCATION="us-central1"
export REPO_NAME="internal-images"
export SERVICE_NAME="gcp-cloud-run-elt-dbt-svc-v1"
export IMAGE_TAG="latest"
export SERVICE_ACCOUNT="sa-cloud-run-dev@$PROJECT_ID.iam.gserviceaccount.com"

echo "PROJECT_ID :" $PROJECT_ID
echo "LOCATION :" $LOCATION
echo "REPO_NAME :" $REPO_NAME
echo "SERVICE_NAME :" $SERVICE_NAME
echo "IMAGE_TAG :" $IMAGE_TAG
echo "SERVICE_ACCOUNT :" $SERVICE_ACCOUNT

```

```bash
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config deploy-dbt-app-cloud-run-job.yaml \
    --substitutions _REPO_NAME="$REPO_NAME",_JOB_NAME="$JOB_NAME",_IMAGE_TAG="$IMAGE_TAG",_SERVICE_ACCOUNT="$SERVICE_ACCOUNT" \
    --verbosity="debug" .
```


## Deploy the Cloud Run Service with Cloud Build

```bash
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config deploy-dbt-app-cloud-run-service.yaml \
    --substitutions _REPO_NAME="$REPO_NAME",_SERVICE_NAME="$SERVICE_NAME",_IMAGE_TAG="$IMAGE_TAG",_SERVICE_ACCOUNT="$SERVICE_ACCOUNT" \
    --verbosity="debug" .
```