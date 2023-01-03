# Installation Script

## Enterprise Linux
```
curl -sfL https://raw.githubusercontent.com/paulovigne/py-db-app/main/install_el.sh | sh -
```

## Ubuntu / Debian
```
Comming Soon!
```

# Application Prerequisites

## Packages

- git
- python3
- python3-pip
- libpqxx-devel
- docker (only if postgresql will be running containerized)

## Application Configuration

All configurations are made under the environment variables. Make sure these variables are properly exported:

```
FLASK_APP="/opt/py-db-app/app.py"
PG_HOST="127.0.0.1"
PG_PORT="5432"
PG_DBNAME="pyapp"
PG_USER="pyapp"
PG_PASS="pyapppyapp"
```

## Database Configuration

The following script are the inital database payload, it contains database connection user/pass and the application table data.

```
CREATE DATABASE pyapp;
CREATE ROLE pyapp WITH LOGIN PASSWORD 'pyapppyapp';
\c pyapp
CREATE TABLE movies (id serial PRIMARY KEY,year integer,name text);
INSERT INTO movies (year, name) VALUES (1994, 'The Shawshank Redemption'),(1972, 'The Godfather'),(2008, 'The Dark Knight');
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pyapp;
```

# Docker Setup

## Repo Cloning
```
cd /opt
git clone https://github.com/paulovigne/py-db-app.git
```
## Install PostgreSQL

```
docker run \
      --name postgres \
      --env POSTGRES_USER=root \
      --env POSTGRES_PASSWORD=rootpassword \
      --detach \
      --publish 5432:5432 \
      -v /opt/py-db-app/sql:/docker-entrypoint-initdb.d \
      postgres
```

## Install PyApp

```
docker build /opt/py-db-app -t py-db-app

docker run \
    --name pyapp \
    --env PG_HOST=$HOSTNAME \
    --env PG_PORT=5432 \
    --env PG_DBNAME=pyapp \
    --env PG_USER=pyapp \
    --env PG_PASS=pyapppyapp \
    --detach \
    --publish 8080:8080 \
    py-db-app
```