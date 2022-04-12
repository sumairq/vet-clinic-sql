/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM ANIMALS WHERE name LIKE '%mon%';
SELECT name FROM ANIMALS WHERE EXTRACT (YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM ANIMALS WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM ANIMALS WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM ANIMALS WHERE weight_kg > 10.5;
SELECT * FROM ANIMALS WHERE neutered = true;
SELECT * FROM ANIMALS WHERE name != 'Gabumon';
SELECT * FROM ANIMALS WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE ANIMALS
SET species = 'unspecified';
SELECT name, species FROM ANIMALS;
ROLLBACK;
SELECT name, species FROM ANIMALS;

BEGIN;
UPDATE ANIMALS
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE ANIMALS
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;
SELECT name, species FROM ANIMALS;


BEGIN;
DELETE FROM ANIMALS;
SELECT * FROM ANIMALS;
ROLLBACK;
SELECT * FROM ANIMALS;


BEGIN;
DELETE FROM ANIMALS
WHERE date_of_birth > '2022-01-01';
SELECT name, date_of_birth FROM ANIMALS;
SAVEPOINT DELETE_AFTER_1ST_DATE;
UPDATE ANIMALS
SET weight_kg = weight_kg * -1;
SELECT name, weight_kg FROM ANIMALS;
ROLLBACK TO DELETE_AFTER_1ST_DATE;
UPDATE ANIMALS
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;
SELECT name, weight_kg FROM ANIMALS;


SELECT COUNT(*) as number_of_animals FROM ANIMALS;

SELECT COUNT(*) as number_of_animals_without_scapes FROM ANIMALS
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) as average_weight FROM ANIMALS;

SELECT neutered, SUM(escape_attempts) as sum_of_escape_attempts FROM ANIMALS
GROUP BY neutered;

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM ANIMALS
GROUP BY species;

SELECT species, AVG(escape_attempts) as average_escape_attempts FROM ANIMALS
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

SELECT full_name as owner_name, name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
WHERE O.full_name = 'Melody Pond';
--
SELECT A.name, S.name as type
FROM species S
JOIN ANIMALS A ON S.id = A.species_id
WHERE S.name = 'Pokemon';
--
SELECT full_name as owner_name, name as animal_name
FROM OWNERS O
LEFT JOIN ANIMALS A ON O.id = A.owner_id;
--
SELECT S.name as type, COUNT(A.id)
FROM SPECIES S
JOIN ANIMALS A ON S.id = A.species_id
GROUP BY S.name;
--
SELECT O.full_name as owner_name, A.name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
JOIN SPECIES S ON S.id = A.species_id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';
--
SELECT O.full_name as owner_name, name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';
--
SELECT filtered.owner_name
FROM (
  SELECT O.full_name as owner_name, COUNT(A.id) as animal_owned
  FROM OWNERS O
  JOIN ANIMALS A ON O.id = A.owner_id
  GROUP BY O.full_name
) as filtered
WHERE filtered.animal_owned = (
  SELECT MAX (filtered.animal_owned)
  FROM (
    SELECT O.full_name as owner_name, COUNT(A.id) as animal_owned
    FROM OWNERS O
    JOIN ANIMALS A ON O.id = A.owner_id
    GROUP BY O.full_name
  ) as filtered 
);

SELECT VE.name, A.name, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'William Tatcher'
ORDER BY VI.date_of_visit DESC
LIMIT 1;

CREATE VIEW stephanie_visits as
  SELECT A.name, COUNT(A.name)
  FROM ANIMALS A
  JOIN VISITS VI ON VI.animal_id = A.id
  JOIN VETS VE ON VI.vets_id = VE.id
  WHERE VE.name = 'Stephanie Mendez'
  GROUP BY A.name;

SELECT COUNT(name) FROM stephanie_visits;

SELECT VE.name as VET, S.name as Speciality
FROM VETS VE
LEFT JOIN SPECIALIZATION ON VE.id = SPECIALIZATION.vets_id
LEFT JOIN SPECIES S ON S.id = SPECIALIZATION.species_id;

SELECT A.NAME as animal, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'Stephanie Mendez' AND VI.date_of_visit BETWEEN '1-4-2020' AND '30-8-2020';

SELECT A.name, COUNT(A.name) as number_of_visits
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
GROUP BY A.name
ORDER BY number_of_visits DESC
LIMIT 1;

SELECT A.name as animal, VI. date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'Maisy Smith'
ORDER BY VI.date_of_visit
LIMIT 1;

SELECT A.name AS animal, S.name as type, A.date_of_birth as birth_date,
A.escape_attempts, A.weight_kg, A.neutered, O.full_name as owner,
VE.name as vet, VE.age as vet_age, VE.date_of_graduation, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
JOIN SPECIES S ON A.species_id = S.id
JOIN OWNERS O ON A.owner_id = O.id
ORDER BY VI.date_of_visit DESC
LIMIT 1;

CREATE VIEW Speciality as
  SELECT innerVe.name as VET
  FROM VETS innerVe
  LEFT JOIN SPECIALIZATION ON innerVe.id = SPECIALIZATION.vets_id
  LEFT JOIN SPECIES innerS ON innerS.id = SPECIALIZATION.species_id;

SELECT COUNT(VI.date_of_visit)
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VE.id = VI.vets_id
LEFT JOIN SPECIALIZATION SPE ON VE.id = SPE.vets_id
WHERE (A.species_id != SPE.species_id OR SPE.species_id IS NULL) AND 2 != (
  SELECT COUNT(Speciality.vet)
  FROM Speciality
  WHERE Speciality.vet = VE.name
);

SELECT S.name, COUNT(S.name) as VISITS
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
JOIN SPECIES S ON S.id = A.species_id
WHERE VE.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY VISITS DESC
LIMIT 1;

