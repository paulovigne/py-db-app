CREATE DATABASE pyapp;
CREATE ROLE pyapp WITH LOGIN PASSWORD 'pyapppyapp';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pyapp;
#GRANT ALL PRIVILEGES ON DATABASE pyapp TO pyapp;
\c pyapp
CREATE TABLE movies (id serial PRIMARY KEY,year integer,name text);
INSERT INTO movies (year, name) VALUES (1994, 'The Shawshank Redemption'),(1972, 'The Godfather'),(2008, 'The Dark Knight');