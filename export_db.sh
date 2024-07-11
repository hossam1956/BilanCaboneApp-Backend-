#!/bin/bash

# Load environment variables from .env file
set -o allexport
source .env
set +o allexport

# Export the PostgreSQL password
export PGPASSWORD=${POSTGRES_PASSWORD}

# Create the initdb directory if it doesn't exist
mkdir -p initdb

# Export the database from the running postgresContainer
docker exec -t postgresContainer pg_dump -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f /docker-entrypoint-initdb.d/init.sql

# Copy the exported SQL file to the host's initdb directory
docker cp postgresContainer:/docker-entrypoint-initdb.d/init.sql ./initdb/init.sql

echo "Database export completed."
