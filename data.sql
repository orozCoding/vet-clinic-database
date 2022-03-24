/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', Feb 3, 2020', 10.23, true, 0),
('Gabumon', 'Nov 15, 2018', 8.00, true, 2),
('Pikachu', 'Jan 7, 2021', 15.04, false, 1),
('Devimon', 'May 12, 2017', 11.00, true, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', 'Feb 8, 2020', -11.00, false, 0),
('Plantmon', 'Nov 15, 2021', -5.70, true, 2),
('Squirtle', 'Apr 2, 1993', -12.13, false, 3),
('Angemon', 'Jun 12, 2005', -45.00, true, 1),
('Boarmon', 'Jun 7, 2005', 20.40, true, 7),
('Blossom', 'Oct 13, 1998', 17.00, true, 3),
('Ditto', 'May 14, 2022', 22.00, true, 4);

        
BEGIN;

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

SELECT * FROM owners;

COMMIT;

BEGIN;

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

SELECT * FROM species;

COMMIT;

BEGIN;

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

SELECT * FROM animals;


COMMIT;

BEGIN;

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

SELECT * FROM animals;

SAVEPOINT SP1;

UPDATE animals
SET owner_id = 2
WHERE (name = 'Gabumon')
OR (name = 'Pikachu');

SELECT * FROM animals;

SAVEPOINT SP2;

UPDATE animals
SET owner_id = 3
WHERE (name = 'Devimon')
OR (name = 'Plantmon');

SELECT * FROM animals;


SAVEPOINT SP3;

UPDATE animals
SET owner_id = 4
WHERE (name = 'Charmander')
OR (name = 'Squirtle')
OR (name = 'Blossom');

SAVEPOINT SP4;

UPDATE animals
SET owner_id = 5
WHERE (name = 'Angemon')
OR (name = 'Boarmon');

SELECT * FROM animals;
        
COMMIT;
        
        
        
/* Inserting Vets, specializations and visits data */

BEGIN;
        
INSERT INTO vets(name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

SELECT * FROM vets;
COMMIT;

BEGIN;        
INSERT INTO specializations(vet_id, species_id)
VALUES 
    (1, 1),
    (3, 2),
    (3, 1),
    (4, 2);

SELECT * FROM specializations;
COMMIT;        
 
        
BEGIN;
INSERT INTO visits(animals_id, vet_id, date_visited)
VALUES 
    (1, 1, '2020-05-24'),
    (1, 3, '2020-07-22'),
    (2, 4, '2021-02-02'),
    (3, 2, '2020-01-05'),
    (3, 2, '2020-03-08'),
    (3, 2, '2020-05-14'),
    (4, 3, '2021-05-04'),
    (6, 4, '2021-02-24'),
    (7, 2, '2019-12-21'),
    (7, 1, '2020-08-10'),
    (7, 2, '2021-04-07'),
    (8, 3, '2019-09-29'),
    (9, 4, '2020-10-03'),
    (9, 4, '2020-11-04'),
    (10, 2, '2019-01-24'),
    (10, 2, '2019-05-15'),
    (10, 2, '2020-02-27'),
    (10, 2, '2020-08-03'),
    (11, 3, '2020-05-24'),
    (11, 1, '2021-01-11');
SELECT * FROM visits;
COMMIT;       
