# Stage 1: Builder
FROM python:3.9-slim as builder

ENV DBT_DIR=/dbt

WORKDIR /app

# Copy the Python script
COPY invoke.py ./


# Stage 2: Final Image
FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.2
USER root
WORKDIR /dbt

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python script from the builder stage
COPY --from=builder /app/invoke.py ./

# Copy additional files
COPY dbt/run_dbt.sh ./
COPY dbt ./

RUN chmod +x /dbt/run_dbt.sh

RUN ls -l /dbt/

# Set the entry point to run the Python script
ENTRYPOINT ["python", "./invoke.py"]