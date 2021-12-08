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


-- -----------------------------------
INSERT INTO vets (name,age,date_of_graduation)
VALUES  ('William Tatcher',45,'2000-04-23');
        
INSERT INTO vets (name,age,date_of_graduation)
VALUES  ('Maisy Smith',26,'2019-01-17');
        
INSERT INTO vets (name,age,date_of_graduation)
VALUES  ('Stephanie Mendez',64,'1981-05-04');
        
INSERT INTO vets (name,age,date_of_graduation)
VALUES  ('Jack Harkness',38,'2008-06-08');

------------------------------------------
INSERT INTO specializations (vets_id,species_id) VALUES  (1,1);
INSERT INTO specializations (vets_id,species_id) VALUES  (2,2);
INSERT INTO specializations (vets_id,species_id) VALUES  (2,1);
INSERT INTO specializations (vets_id,species_id) VALUES  (3,2);
------------------------------------------------

INSERT INTO visits (vets_id,animals_id,visit_date)
VALUES 
    (1,(SELECT id from animals where name = 'Agumon'),'2020-05-24'),
    (3,(SELECT id from animals where name = 'Agumon'),'2020-07-22'),
    (4,(SELECT id from animals where name = 'Gabumon'),'2021-02-02'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-01-05'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-03-08'),
    (2,(SELECT id from animals where name = 'Pikachu'),'2020-05-14'),
    (3,(SELECT id from animals where name = 'Devimon'),'2021-05-04'),
    (4,(SELECT id from animals where name = 'Charmander'),'2021-02-24'),
    (2,(SELECT id from animals where name = 'Plantmon'),'2019-12-21'),
    (1,(SELECT id from animals where name = 'Plantmon'),'2020-08-10'),
    (2,(SELECT id from animals where name = 'Plantmon'),'2021-04-07'),
    (3,(SELECT id from animals where name = 'Squirtle'),'2019-09-29'),
    (4,(SELECT id from animals where name = 'Angemon'),'2020-10-03'),
    (4,(SELECT id from animals where name = 'Angemon'),'2020-11-04'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2019-01-24'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2019-05-15'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2020-02-27'),
    (2,(SELECT id from animals where name = 'Boarmon'),'2020-08-03'),
    (3,(SELECT id from animals where name = 'Blossom'),'2020-05-24'),
    (1,(SELECT id from animals where name = 'Blossom'),'2021-01-11');



-----------------------------------------

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
