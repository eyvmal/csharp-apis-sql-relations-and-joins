-- Create tables
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS MovieRoles;

CREATE TABLE People (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100),
    birth DATE,
    email VARCHAR(100)
);

CREATE TABLE Movies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    year INT,
    genre VARCHAR(100),
    score DECIMAL(3, 1)
);

CREATE TABLE MovieRoles (
    id SERIAL PRIMARY KEY,
    movie INT REFERENCES Movies(Id),
    director INT REFERENCES People(Id),
    star INT REFERENCES People(Id),
    writer INT REFERENCES People(Id)
);

-- Populate the database 
INSERT INTO People (name, country, birth, email) VALUES
    ('Stanley Kubrick', 'USA', NULL, NULL),
    ('Keir Dullea', 'USA', '1936-05-30', NULL),
    ('Arthur C Clarke', 'UK', NULL, 'arthur@clarke.com'),
    ('George Lucas', 'USA', NULL, 'george@email.com'),
    ('Mark Hamill', 'USA', '1951-09-25', NULL),
    ('Robert Mulligan', 'USA', NULL, NULL),
    ('Gregory Peck', 'USA', '1916-04-05', NULL),
    ('Harper Lee', 'USA', NULL, 'harper@lee.com'),
    ('James Cameron', 'Canada', NULL, 'james@cameron.com'),
    ('Leonardo DiCaprio', 'USA', '1974-11-11', NULL),
    ('David Lean', 'UK', NULL, NULL),
    ('Julie Christie', 'UK', '1940-04-14', NULL),
    ('Boris Pasternak', 'Russia', NULL, 'boris@boris.com'),
    ('Anthony Mann', 'USA', NULL, NULL),
    ('Charlton Heston', 'USA', '1923-10-04', NULL),
    ('Frederick Frank', 'USA', NULL, 'fred@frank.com'),
    ('Theodoros Angelopoulos', 'Greece', NULL, 'theo@angelopoulos.com'),
    ('Manos Katrakis', 'Greece', '1908-08-14', NULL),
    ('Paul Verhoeven', 'Netherlands', NULL, NULL),
    ('Rutger Hauer', 'Netherlands', '1944-01-23', NULL),
    ('Erik Hazelhoff Roelfzema', 'Netherlands', NULL, 'erik@roelfzema.com'),
    ('Krzysztof Kieslowski', 'Poland', NULL, 'email@email.com'),
    ('Juliette Binoche', 'France', '1964-03-09', NULL),
    ('Jean-Paul Rappeneau', 'France', NULL, NULL),
    ('Gerard Depardieu', 'France', '1948-12-27', NULL),
    ('Edmond Rostand', 'France', NULL, 'edmond@rostand.com');

INSERT INTO Movies (name, year, genre, score) VALUES
    ('2001: A Space Odyssey', 1968, 'Science Fiction', 10.0),
    ('Star Wars: A New Hope', 1977, 'Science Fiction', 7.0),
    ('To Kill A Mockingbird', 1962, 'Drama', 10.0),
    ('Titanic', 1997, 'Romance', 5.0),
    ('Dr Zhivago', 1965, 'Historical', 8.0),
    ('El Cid', 1961, 'Historical', 6.0),
    ('Voyage to Cythera', 1984, 'Drama', 8.0),
    ('Soldier of Orange', 1977, 'Thriller', 8.0),
    ('Three Colours: Blue', 1993, 'Drama', 8.0),
    ('Cyrano de Bergerac', 1990, 'Historical', 9.0);

-- Insert roles into the MovieRoles table
INSERT INTO MovieRoles (movie, director, star, writer) VALUES
    ((SELECT id FROM Movies WHERE name = '2001: A Space Odyssey'),
    (SELECT id FROM People WHERE name = 'Stanley Kubrick'),
    (SELECT id FROM People WHERE name = 'Keir Dullea'),
    (SELECT id FROM People WHERE name = 'Arthur C Clarke')),
    
    ((SELECT id FROM Movies WHERE name = 'Star Wars: A New Hope'),
    (SELECT id FROM People WHERE name = 'George Lucas'),
    (SELECT id FROM People WHERE name = 'Mark Hamill'),
    (SELECT id FROM People WHERE name = 'George Lucas')),
    
    ((SELECT id FROM Movies WHERE name = 'To Kill A Mockingbird'),
    (SELECT id FROM People WHERE name = 'Robert Mulligan'),
    (SELECT id FROM People WHERE name = 'Gregory Peck'),
    (SELECT id FROM People WHERE name = 'Harper Lee')),
    
    ((SELECT id FROM Movies WHERE name = 'Titanic'),
    (SELECT id FROM People WHERE name = 'James Cameron'),
    (SELECT id FROM People WHERE name = 'Leonardo DiCaprio'),
    (SELECT id FROM People WHERE name = 'James Cameron')),
    
    ((SELECT id FROM Movies WHERE name = 'Dr Zhivago'),
    (SELECT id FROM People WHERE name = 'David Lean'),
    (SELECT id FROM People WHERE name = 'Julie Christie'),
    (SELECT id FROM People WHERE name = 'Boris Pasternak')),
    
    ((SELECT id FROM Movies WHERE name = 'El Cid'),
    (SELECT id FROM People WHERE name = 'Anthony Mann'),
    (SELECT id FROM People WHERE name = 'Charlton Heston'),
    (SELECT id FROM People WHERE name = 'Frederick Frank')),
    
    ((SELECT id FROM Movies WHERE name = 'Voyage to Cythera'),
    (SELECT id FROM People WHERE name = 'Theodoros Angelopoulos'),
    (SELECT id FROM People WHERE name = 'Manos Katrakis'),
    (SELECT id FROM People WHERE name = 'Theodoros Angelopoulos')),
    
    ((SELECT id FROM Movies WHERE name = 'Soldier of Orange'),
    (SELECT id FROM People WHERE name = 'Paul Verhoeven'),
    (SELECT id FROM People WHERE name = 'Rutger Hauer'),
    (SELECT id FROM People WHERE name = 'Erik Hazelhoff Roelfzema')),
    
    ((SELECT id FROM Movies WHERE name = 'Three Colours: Blue'),
    (SELECT id FROM People WHERE name = 'Krzysztof Kieslowski'),
    (SELECT id FROM People WHERE name = 'Juliette Binoche'),
    (SELECT id FROM People WHERE name = 'Krzysztof Kieslowski')),
    
    ((SELECT id FROM Movies WHERE name = 'Cyrano de Bergerac'),
    (SELECT id FROM People WHERE name = 'Jean-Paul Rappeneau'),
    (SELECT id FROM People WHERE name = 'Gerard Depardieu'),
    (SELECT id FROM People WHERE name = 'Edmond Rostand'));

-- Queries
SELECT m.name, m.year, m.genre, m.score, d.name "Director", s.name "Star", w.name "Writer"
FROM MovieRoles mr
INNER JOIN Movies m ON mr.movie = m.id
INNER JOIN People d ON mr.director = d.id
INNER JOIN People s ON mr.star = s.id
INNER JOIN People w ON mr.writer = w.id;

-- Extension 2
CREATE TABLE Cast (
    id SERIAL PRIMARY KEY,
    movie INT REFERENCES Movies(Id),
    actor INT REFERENCES People(Id)
)
