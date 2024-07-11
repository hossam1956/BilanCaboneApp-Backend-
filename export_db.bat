@echo off
REM Load environment variables from .env file
FOR /F "tokens=1,2 delims==" %%G IN ('.env') DO (
    SET %%G=%%H
)

REM Set PostgreSQL password
SET PGPASSWORD=%POSTGRES_PASSWORD%

REM Create the initdb directory if it doesn't exist
IF NOT EXIST initdb (
    mkdir initdb
)

REM Export the database from the running postgresContainer
docker exec -t postgresContainer pg_dump -U %POSTGRES_USER% -d %POSTGRES_DB% -f /docker-entrypoint-initdb.d/init.sql

REM Copy the exported SQL file to the host's initdb directory
docker cp postgresContainer:/docker-entrypoint-initdb.d/init.sql initdb\init.sql

echo Database export completed.
