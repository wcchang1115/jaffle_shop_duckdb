#! /bin/bash

# Install dbt dependencies
dbt deps

# Download duckdb file
gh repo set-default DataRecce/jaffle_shop_duckdb
branch=$(git branch --show-current)
run_id=$(gh run list --workflow "Jaffle Shop Recce CI" --branch $branch --status success --limit 1 --json databaseId --jq '.[0].databaseId')
gh run download $run_id -n duckdb

# Exec Recce
recce server --cloud --review
