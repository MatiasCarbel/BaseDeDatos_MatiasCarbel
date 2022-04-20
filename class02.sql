DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;

USE imdb;

DROP TABLE IF EXISTS film;
CREATE TABLE film(
    film_id INT AUTO_INCREMENT,
    description VARCHAR(255),
    release_year DATE,
    PRIMARY KEY(film_id)
);


DROP TABLE IF EXISTS actor;
CREATE TABLE actor(
    actor_id INT AUTO_INCREMENT, 
    first_name VARCHAR(255), 
    last_name VARCHAR(255),
    PRIMARY KEY(actor_id)
);

DROP TABLE IF EXISTS film_actor;
CREATE TABLE film_actor(
    actor_id INT, 
    film_id INT,
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);


