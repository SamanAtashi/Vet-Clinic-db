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

---------------------------------------

-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON owners.id=animals.owner_id
WHERE full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
select animals.name from animals
JOIN species on animals.species_id = species.id
WHERE species.name = 'Pokemon';


-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;


-- How many animals are there per species?
SELECT species.name, count( animals.species_id ) FROM species
join animals on animals.species_id = species.id
GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM species
JOIN animals ON animals.species_id = species.id
JOIN owners ON owners.id = animals.owner_id
where owners.full_name='Jennifer Orwell' AND species.name='Pokemon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name='Dean Winchester' AND  animals.escape_attempts=0;



-- Who owns the most animals?
SELECT owners.full_name FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY count(name) desc
limit 1;

------------------------------------------------

-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='William Tatcher'
ORDER BY visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT count(animals.name) FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_name , species.name AS speciality FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON species.id=specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name FROM animals
JOIN visits ON animals.id=visits.animals_id
GROUP BY animals.name
ORDER BY count( animals.name ) DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?
SELECT animals.name /*,visits.visit_date*/ FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
WHERE vets.name='Maisy Smith'
ORDER BY visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.visit_date AS latest_visit_date,
animals.*,
vets.name, vets.age, vets.date_of_graduation FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
ORDER BY visit_date DESC
LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT count(animals.name) as no_spec_visit_count /* , vets.name*/ FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
LEFT JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id IS NULL
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM vets
JOIN visits ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id=animals.id
JOIN species ON animals.species_id=species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;
