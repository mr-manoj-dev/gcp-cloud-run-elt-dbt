#!/usr/bin/env bash

set -e
set -o pipefail
set -u

export PROJECT_ID=$(gcloud projects list --format="value(projectId)" | grep burner-mankumar24-02)
export LOCATION="us-central1"
export REPO_NAME="internal-images"
export JOB_NAME="gcp-cloud-run-elt-dbt-job-01"
export SERVICE_NAME="gcp-cloud-run-elt-dbt-svc-01"
export IMAGE_TAG="latest"
export SERVICE_ACCOUNT="sa-cloud-run-dev@$PROJECT_ID.iam.gserviceaccount.com"

echo "PROJECT_ID: $PROJECT_ID"
echo "LOCATION: $LOCATION"
echo "REPO_NAME: $REPO_NAME"
echo "JOB_NAME: $JOB_NAME"
echo "SERVICE_NAME: $SERVICE_NAME"
echo "IMAGE_TAG: $IMAGE_TAG"
echo "SERVICE_ACCOUNT: $SERVICE_ACCOUNT"

echo "############# Create raw table and load data"

bq load \
  --project_id=$PROJECT_ID \
  --location=$LOCATION \
  --source_format=NEWLINE_DELIMITED_JSON \
  --autodetect \
  qatar_fifa_world_cup.team_players_stat_raw \
  gs://ps_dev_01_us_central/world_cup_team_stats/input/world_cup_team_players_stats_raw_ndjson.json
