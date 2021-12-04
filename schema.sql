/* Database schema to keep the structure of entire database. */

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name varchar(100),
  age INT
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name varchar(100)
);
