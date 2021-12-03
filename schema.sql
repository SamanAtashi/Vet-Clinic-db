/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id BIGSERIAL,    
  name varchar(100),
  date_of_birth date,
  escape_attempts int,
  neutered bool,
  weight_kg decimal,
  species varchar(100)
);
