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
