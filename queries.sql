/*Queries that provide answers to the questions from all projects.*/

BEGIN;

UPDATE animals 
SET species = 'unspecified'
WHERE species IS NULL;

ROLLBACK;

------------------------------
