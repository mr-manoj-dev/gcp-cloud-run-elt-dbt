#!/bin/sh
echo "PWD: $(pwd)"

echo "PWD: $(ls -ltr)"

dbt run --profiles-dir .
