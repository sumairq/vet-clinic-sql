/* Populate database with sample data. */
INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Agumon', '3-FEB-2020', 0, true, 10.23);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Gabumon', '15-NOV-2018', 2, true, 8);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Pikachu', '7-JAN-2021', 1, false, 15.04);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Devimon', '12-MAY-2017', 5, true, 11);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Devimon', '12-MAY-2017', 5, true, 11);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Charmander', '8-FEB-2020', 0, false, -11);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES( 'Plantmon', '15-NOV-2021', 2, true, -5.7);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Squirtle', '2-APR-1993', 3, false, -12.13);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Angemon', '12-JUN-2005', 1, true, -45);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Boarmon', '7-JUN-2005', 7, true, 20.4);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Blossom', '13-OCT-1998', 3, true, 17);

INSERT INTO ANIMALS(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Ditto', '14-MAY-2022', 4, true, 22);


INSERT INTO owners(full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE ANIMALS
SET species_id = 1;
UPDATE ANIMALS
SET species_id = 2
WHERE name LIKE '%mon%';


UPDATE ANIMALS
SET owner_id = 1
WHERE name = 'Agumon';
SAVEPOINT OWNER_1;
UPDATE ANIMALS
SET owner_id = 2
WHERE name IN ('Gabumon', 'Pikachu');
SAVEPOINT OWNER_2;
UPDATE ANIMALS
SET owner_id = 3
WHERE name IN ('Devimon', 'Plantmon');
SAVEPOINT OWNER_3;
UPDATE ANIMALS
SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
SAVEPOINT OWNER_4;
UPDATE ANIMALS
SET owner_id = 5
WHERE name IN ('Angemon', 'Boarmon');
SAVEPOINT OWNER_5;


INSERT INTO VETS (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '23-APR-2000'),
  ('Maisy Smith', 26, '17-JAN-2019'),
  ('Stephanie Mendez', 64, '4-MAY-1981'),
  ('Jack Harkness', 38, '8-JUN-2008');
INSERT INTO SPECIALIZATION (species_id, vets_id)
VALUES
  (1, 1),
  (1, 3),
  (2, 3),
  (2, 4);
INSERT INTO VISITS (animal_id, vets_id, date_of_visit)
VALUES
  (1, 1, '24-MAY-2020'),
  (1, 3, '22-JUL-2020'),
  (2, 4, '2-FEB-2021'),
  (3, 2, '5-JAN-2020'),
  (3, 2, '8-MAR-2020'),
  (3, 2, '14-MAY-2020'),
  (4, 3, '4-MAY-2021'),
  (5, 4, '24-FEB-2021'),
  (6, 2, '21-DEC-2019'),
  (6, 1, '10-AUG-2020'),
  (6, 2, '7-APR-2021'),
  (7, 3, '29-SEP-2019'),
  (8, 4, '3-OCT-2020'),
  (8, 4, '4-NOV-2020'),
  (9, 2, '24-JAN-2019'),
  (9, 2, '15-MAY-2019'),
  (9, 2, '27-FEB-2020'),
  (9, 2, '3-AUG-2020'),
  (10, 3, '24-MAY-2020'),
  (10, 1, '11-JAN-2021');


INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

INSERT INTO owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
