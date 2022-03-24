/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(20),
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
full_name VARCHAR(50),
age INT
);

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(50)
);

\dt

BEGIN;
ALTER TABLE animals
ADD PRIMARY KEY (ID);

ALTER TABLE animals
DROP COLUMN species;

SELECT * from animals;

SAVEPOINT SP1;

ALTER TABLE animals
ADD COLUMN species_id INT references animals(id),
ADD COLUMN owner_id INT references owners(id);

SELECT * from animals;

COMMIT;

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT NOT NULL,
    species_id INT NOT NULL,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_Vets  
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_Species  
    FOREIGN KEY(species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vet_id INT NOT NULL,
    animals_id INT NOT NULL,
    date_visited DATE,
    PRIMARY KEY (vet_id, animals_id, date_visited),
    CONSTRAINT fk_Vets  
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals  
    FOREIGN KEY(animals_id) REFERENCES animals(id)
);
