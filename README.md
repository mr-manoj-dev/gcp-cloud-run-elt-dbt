# gcp-cloud-run-elt-dbt

This is a simple use case using DBT, BigQuery, GCP cloud build and cloud run.
The raw table as input data for DBT is a source for the models where 
DBT shall run transformation and aggregation over raw data and create and materialize into table.




## Publish the Docker image to Artifact Registry and deploy the Cloud Run job with Cloud Build

```bash
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config deploy-dbt-app-cloud-run-job.yaml \
    --substitutions _REPO_NAME="$REPO_NAME",_JOB_NAME="$JOB_NAME",_IMAGE_TAG="$IMAGE_TAG",_SERVICE_ACCOUNT="$SERVICE_ACCOUNT" \
    --verbosity="debug" .
```