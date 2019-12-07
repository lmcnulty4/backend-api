#!/bin/bash

# Exit if any variables not set, or anything called errors
set -eu

# Create a new user and new database
psql -v ON_ERROR_STOP=1 <<-EOSQL
CREATE USER $PG_USER WITH PASSWORD '$PG_PASS';
CREATE DATABASE $PG_DB;
EOSQL

# Create the schema - we need to reconnect to the just created database so that
# the schema we're creating is in the database we just created
psql -v ON_ERROR_STOP=1 --dbname "$PG_DB" <<-EOSQL
CREATE SCHEMA boi;
EOSQL

# Create tables
psql -v ON_ERROR_STOP=1 --dbname "$PG_DB" --file /schema-scripts/tables.sql

# ... other things (views, stored procedures, types, etc) to follow, placed here

# After all things are created, grant CONNECT and SELECT to all tables in PG_DB
# to PG_USER, allowing the user which the web app uses to connect and run
# SELECT queries but nothing more
psql -v ON_ERROR_STOP=1 --dbname "$PG_DB" <<-EOSQL
GRANT CONNECT ON DATABASE $PG_DB TO $PG_USER;
GRANT USAGE ON SCHEMA boi TO $PG_USER;
GRANT SELECT ON ALL TABLES IN SCHEMA boi TO $PG_USER;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA boi TO $PG_USER;
EOSQL

