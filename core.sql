-- Create tables
CREATE TABLE directors(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE stars(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    birth DATE
);

CREATE TABLE writers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
    
CREATE TABLE films(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    year INTEGER,
    genre VARCHAR(100),
    score INTEGER,
    director_id INTEGER,
    star_id INTEGER,
    writer_id INTEGER,
    CONSTRAINT director_fk FOREIGN KEY(director_id) REFERENCES directors(id),
    CONSTRAINT star_fk FOREIGN KEY(star_id) REFERENCES stars(id),
    CONSTRAINT writer_fk FOREIGN KEY(writer_id) REFERENCES writers(id)
);

-- Inserts

INSERT INTO directors (name, country) VALUES
    ('Stanley Kubrick', 'USA'),
    ('George Lucas', 'USA'),
    ('Robert Mulligan', 'USA'),
    ('James Cameron', 'Canada'),
    ('David Lean', 'UK'),
    ('Anthony Mann', 'USA'),
    ('Theodoros Angelopoulos', 'Greece'),
    ('Paul Verhoeven', 'Netherlands'),
    ('Krzysztof Kieslowski', 'Poland'),
    ('Jean-Paul Rappeneau', 'France');

INSERT INTO stars (name, birth) VALUES
    ('Keir Dullea', '1936-05-30'),
    ('Mark Hamill', '1951-09-25'),
    ('Gregory Peck', '1916-04-05'),
    ('Leonardo DiCaprio', '1974-11-11'),
    ('Julie Christie', '1940-04-14'),
    ('Charlton Heston', '1923-10-04'),
    ('Manos Katrakis', '1908-08-14'),
    ('Rutger Hauer', '1944-01-23'),
    ('Juliette Binoche', '1964-03-09'),
    ('Gerard Depardieu', '1948-12-27');

INSERT INTO writers (name, email) VALUES
    ('Arthur C Clarke', 'arthur@clarke.com'),
    ('George Lucas', 'george@email.com'),
    ('Harper Lee', 'harper@lee.com'),
    ('James Cameron', 'james@cameron.com'),
    ('Boris Pasternak', 'boris@boris.com'),
    ('Frederick Frank', 'fred@frank.com'),
    ('Theodoros Angelopoulos', 'theo@angelopoulos.com'),
    ('Erik Hazelhoff Roelfzema', 'erik@roelfzema.com'),
    ('Krzysztof Kieslowsk', 'email@email.com'),
    ('Edmond Rostand', 'edmond@rostand.com');

INSERT INTO films (title, year, genre, score, director_id, star_id, writer_id) VALUES
   ('2001: A Space Odyssey', 1968, 'Science Fiction', 10, 1, 1, 1),
   ('Star Wars: A New Hope', 1977, 'Science Fiction', 7, 2, 2, 2),
   ('To Kill A Mockingbird', 1962, 'Drama', 10, 3, 3, 3),
   ('Titanic', 1997, 'Romance', 5, 4, 4, 4),
   ('Dr Zhivago', 1965, 'Historical', 8, 5, 5, 5),
   ('El Cid', 1961, 'Historical', 6, 6, 6, 6),
   ('Voyage to Cythera', 1984, 'Drama', 8, 7, 7, 7),
   ('Soldier of Orange', 1977, 'Thriller', 8, 8, 8, 8),
   ('Three Colours: Blue', 1993, 'Drama', 8, 9, 9, 9),
   ('Cyrano de Bergerac', 1990, 'Historical', 9, 10, 10, 10);

-- Show the title and director name for all films
SELECT films.title, directors.name
FROM films
INNER JOIN directors ON films.director_id = directors.id;

-- Show the title, director and star name for all films
SELECT f.title, d.name, s.name
FROM films f
INNER JOIN directors d ON f.director_id = d.id
INNER JOIN stars s ON f.director_id = s.id;

-- Show the title of films where the director is from the USA
SELECT f.title, d.name, d.country
FROM films f
INNER JOIN directors d ON f.director_id = d.id
WHERE d.country = 'USA';
    
-- Show only those films where the writer and the director are the same person
SELECT f.title, d.name, w.name
FROM films f
INNER JOIN directors d on d.id = f.director_id
INNER JOIN writers w on f.writer_id = w.id
WHERE d.name LIKE w.name;
    
-- Show directors and film titles for films with a score of 8 or higher
SELECT f.title, d.name, f.score
FROM films f 
INNER JOIN directors d on d.id = f.director_id
WHERE f.score >= 8
ORDER BY f.score DESC;
    
-- Make at least 5 more queries to demonstrate your understanding of joins, and other relationships between tables.
-- 1 Add all tables to one
SELECT f.title, d.name "director", s.name "star", w.name "writer"
FROM films f
INNER JOIN directors d on d.id = f.director_id
INNER JOIN stars s on s.id = f.star_id
INNER JOIN writers w on w.id = f.writer_id;

-- 2 Sort table on director names
SELECT f.title, d.name "director"
FROM films f
INNER JOIN directors d on d.id = f.director_id
ORDER BY d.name;

-- 3 Find all movies with a star over 100 years old
SELECT f.title, s.name, EXTRACT(YEAR FROM s.birth) AS BirthYear
FROM films f
INNER JOIN stars s on f.star_id = s.id
WHERE EXTRACT(YEAR FROM s.birth) < 1924;

-- 4 Sort table based on how many movies theyve stared in
SELECT s.name, COUNT(f.id)
FROM films f
INNER JOIN stars s on s.id = f.star_id
GROUP BY s.name;
    
-- 5 Find all movies not directed by an american
SELECT f.title, d.name, d.country
FROM films f 
INNER JOIN directors d on d.id = f.director_id
WHERE d.country != 'USA';

-- Extension 1
