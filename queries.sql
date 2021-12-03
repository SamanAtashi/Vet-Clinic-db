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
