/* Database schema to keep the structure of entire database. */

CREATE TABLE owners (
  id BIGSERIAL PRIMARY KEY,
  full_name varchar(100),
  age INT
);

CREATE TABLE species (
  id BIGSERIAL PRIMARY KEY,
  name varchar(100)
);

CREATE TABLE animals (
  id BIGSERIAL PRIMARY KEY,
  name varchar(100),
  date_of_birth date,
  escape_attempts int,
  neutered bool,
  weight_kg decimal,
  owner_id BIGINT REFERENCES owners(id),
  species_id BIGINT REFERENCES species(id)
);

CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name varchar(100),
    age INT,
    date_of_graduation DATE 
);

CREATE TABLE specializations (
    vets_id BIGINT REFERENCES vets(id),
    species_id BIGINT REFERENCES species(id)
);

CREATE TABLE visits (
    visit_date DATE,
    vets_id BIGINT REFERENCES vets(id),
    animals_id BIGINT REFERENCES animals(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);