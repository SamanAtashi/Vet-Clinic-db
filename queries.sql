/*Queries that provide answers to the questions from all projects.*/

BEGIN;

UPDATE animals 
SET species = 'unspecified'
WHERE species IS NULL;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

------------------------------

BEGIN;

SELECT * FROM animals WHERE name ILIKE '%mon';

UPDATE animals 
SET species = 'digimon'
WHERE name ILIKE '%mon';

UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

------------------------------

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

------------------------------

BEGIN;

DELETE FROM animals WHERE date_of_birth>'2022-01-01';

SAVEPOINT temp;

UPDATE animals
SET weight_kg = weight_kg*(-1); 

ROLLBACK TO SAVEPOINT temp;

UPDATE animals
SET weight_kg = weight_kg*(-1)
WHERE weight_kg<0;

COMMIT;

------------------------------

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)::numeric(10,2) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered FROM animals WHERE escape_attempts=(
    SELECT MAX(escape_attempts)
    FROM animals
);

-- What is the minimum and maximum weight of each type of animal?
SELECT MAX(weight_kg) FROM animals;
SELECT MIN(weight_kg) FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts)::numeric(10,2) FROM animals 
WHERE date_of_birth>'1990-01-01' AND date_of_birth<'2000-12-31';