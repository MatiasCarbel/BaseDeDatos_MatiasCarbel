DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;

USE imdb;

DROP TABLE IF EXISTS film;
CREATE TABLE film(
    film_id INT,
    description VARCHAR(255),
    release_year DATE
);


DROP TABLE IF EXISTS actor;
CREATE TABLE actor(
    actor_id INT, 
    first_name VARCHAR(255), 
    last_name VARCHAR(255)
);

DROP TABLE IF EXISTS film_actor;
CREATE TABLE film_actor(
    
);
