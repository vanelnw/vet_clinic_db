/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id INTEGER REFERENCES species (id),
    vet_id INTEGER REFERENCES vets (id),
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals (id),
    vet_id INTEGER REFERENCES vets (id),
    visit_date TIMESTAMP NOT NULL,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);
