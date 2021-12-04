/* Populate database with sample data. */

INSERT INTO owners (full_name,age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name,age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name,age) VALUES ('Bob', 45);
INSERT INTO owners (full_name,age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name,age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name,age) VALUES ('Jodie Whittaker', 38);


INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');


INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES  ('Agumon','2020-02-03',0,true,10.23),
        ('Gabumon','2018-09-15',2,true,8.00),
        ('Pikachu','2021-01-07',1,false,15.04),
        ('Devimon','2017-05-12',5,true,11.00),
        ('Charmander','2022-02-02',0,false,-11.00),
        ('Plantmon','2022-09-15',2,true,-5.70),
        ('Squirtle','1993-04-02',3,false,-12.13),
        ('Angemon','2005-06-12',1,true,-45.00),
        ('Boarmon','2005-06-07',7,true,20.40),
        ('Blossom','1998-10-13',3,true,17.00);

UPDATE animals SET species_id = 2;
UPDATE animals SET species_id = 1 WHERE name ILIKE '%mon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')  WHERE name='Angemon' OR name='Boarmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')  WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')  WHERE name='Devimon' OR name='Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')  WHERE name='Gabumon' OR name='Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')  WHERE name='Agumon';
