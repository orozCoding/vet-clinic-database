/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true
AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.30;




BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;


BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;



SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, sum(escape_attempts) FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-31-12'
GROUP BY species;


/* multiple-tables-queries */

/*What animals belong to Melody Pond?*/

SELECT owners.full_name AS owner, animals.name AS animal FROM owners
JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name LIKE 'Melody%';

/*List of all animals that are pokemon (their type is Pokemon).*/

SELECT species.name as specie, animals.name as animal
FROM species
JOIN animals
ON animals.species_id = species.id
WHERE species.id = 1;

/*List all owners and their animals, remember to include those that don't own any animal.*/

SELECT full_name AS owners, animals.name FROM owners
LEFT JOIN animals
ON animals.owner_id = owners.id;

/*How many animals are there per species?*/

SELECT species.name AS specie, COUNT(animals.id) AS count FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.id;

/*List all Digimon owned by Jennifer Orwell.*/

SELECT
animals.name as animal,
owners.full_name as owner,
species.name as specie
FROM animals
JOIN owners
ON animals.owner_id = owners.id
JOIN species
ON animals.species_id = species.id
WHERE species.name LIKE 'Digimon'
AND owners.full_name LIKE 'Jennifer%';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT
animals.name as animal,
owners.full_name as owner
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name LIKE 'Dean%'
AND animals.escape_attempts = 0;

/* Who owns the most animals? */

SELECT
owners.full_name AS owner,
COUNT(*) AS owned_count FROM owners 
JOIN animals
ON animals.owner_id = owners.id
GROUP BY owner
ORDER BY owned_count DESC
LIMIT 1;


/* More queries */

/* Last animal seen by William Tatcher: */
SELECT animals.name, vets.name, date_visited FROM visits
JOIN vets 
  ON visits.vet_id = vets.id 
JOIN animals
  ON visits.animals_id = animals.id 
WHERE vets.name LIKE 'William Tatcher'
ORDER BY visits.date_visited DESC
LIMIT (1);

/* Animals that Stephanie Mendez saw: */
SELECT DISTINCT COUNT(*) FROM visits 
JOIN vets 
  ON visits.vet_id = vets.id 
JOIN animals 
  ON visits.animals_id = animals.id 
WHERE vets.name LIKE 'Stephanie Mendez'
GROUP BY vets.name;

/* Vets and their specialties */ 
SELECT vets.name, species.name FROM vets 
LEFT JOIN specializations 
  ON vets.id = specializations.vet_id
LEFT JOIN species 
  ON species.id = specializations.species_id;

/* Animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */ 
SELECT animals.name, visits.date_visited, vets.name FROM animals 
JOIN visits 
  ON animals.id = visits.animals_id
JOIN vets
  ON vets.id = visits.vet_id
WHERE visits.date_visited > ('2020-04-01')
AND visits.date_visited < ('2020-08-30')
AND vets.name LIKE 'Stephanie Mendez';


/* Animal that has the most visits to vets */
SELECT animals.name, COUNT(*) AS visits FROM visits 
JOIN animals
  ON visits.animals_id = animals.id 
GROUP BY animals.name
ORDER BY visits DESC
LIMIT (1);

/* Maisy Smith's first visit */
SELECT animals.name, vets.name, visits.date_visited FROM visits 
JOIN vets 
  ON visits.vet_id = vets.id 
JOIN animals 
  ON visits.animals_id = animals.id 
WHERE vets.name LIKE 'Maisy Smith'
ORDER BY visits.date_visited
LIMIT (1);

/* Details for most recent visit: 
animal information, vet information, and date of visit */
SELECT animals.name, vets.name, visits.date_visited FROM visits 
JOIN vets
  ON visits.vet_id = vets.id 
JOIN animals 
  ON visits.animals_id = animals.id 
ORDER BY visits.date_visited DESC
LIMIT (1);

/* Visits that were with a vet that did not specialize in the animal's specie */
SELECT COUNT(*) AS wrong_visits FROM visits 
JOIN vets
  ON visits.vet_id = vets.id 
JOIN animals
  ON visits.animals_id = animals.id
LEFT JOIN specializations
  ON vets.id = specializations.vet_id
LEFT JOIN species
  ON species.id = specializations.species_id
WHERE specializations.species_id != animals.species_id OR species.name IS NULL;

/* Specialty that Maisy Smith should  consider */
SELECT species.name, COUNT(*) AS visits_count FROM visits 
JOIN animals 
  ON visits.animals_id = animals.id
JOIN species 
  ON species.id = animals.species_id
JOIN vets 
  ON visits.vet_id = vets.id 
LEFT JOIN specializations
  ON vets.id = specializations.vet_id
WHERE specializations.vet_id IS NULL AND vets.name LIKE 'Maisy Smith'
GROUP BY species.name
ORDER BY visits_count DESC;
