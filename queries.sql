/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* transactions */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT species FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* queries */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered ORDER BY COUNT(*) DESC LIMIT 1;
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* NEWS QUERIES*/

SELECT *
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT *
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.*
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT s.name, COUNT(a.species_id)
FROM species s
JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

SELECT a.*
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.*
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.owner_id) as count
FROM animals a
JOIN owners o ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY count DESC
LIMIT 1;

/*join table queries */

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT a.id)
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez';

SELECT ve.name, s.name
FROM vets ve
LEFT JOIN specializations sp ON ve.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(v.animal_id) AS visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visits DESC
LIMIT 1;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT a.name, ve.name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vet_id = ve.id
ORDER BY v.visit_date DESC
LIMIT 1;


