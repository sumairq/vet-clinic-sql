/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS (
    id INT GENERATED ALWAYS AS IDENTITY ,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALERT TABLE ANIMALS
ADD species_id INT;
ALERT TABLE ANIMALS
ADD owner_id INT;
ALERT TABLE ANIMALS
ADD CONSTRAINT species_key
FOREIGN KEY (species_id) REFERENCES species(id);
ALERT TABLE ANIMALS
ADD CONSTRAINT owner_key
FOREIGN KEY (owner_id) REFERENCES owners(id);


CREATE TABLE OWNERS (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE SPECIES (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);


CREATE TABLE VETS (
    id INT GENERATED ALWAYS as IDENTITY NOT NULL,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE SPECIALIZATION (
    species_id INT,
    vets_id INT,
    CONSTRAINT species_key
        FOREIGN KEY (species_id) 
            REFERENCES species(id),
    CONSTRAINT vets_key
        FOREIGN KEY (vets_id)
            REFERENCES vets(id)
                ON DELETE CASCADE
);

CREATE TABLE VISITS (
    animal_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT animal_key
        FOREIGN KEY (animal_id)
            REFERENCES animals(id),
    CONSTRAINT vets_key
        FOREIGN KEY (vets_id)
            REFERENCES vets(id)
);


-- project 1 week 2

CREATE INDEX animal_id_asc ON visits(animal_id ASC);
CREATE INDEX vet_id_asc ON visits(vet_id DESC);
CREATE INDEX owners_email_asc ON owners(email ASC);
