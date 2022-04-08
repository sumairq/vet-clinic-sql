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
