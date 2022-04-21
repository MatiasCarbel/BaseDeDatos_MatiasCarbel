USE sakila;

SELECT title, special_features FROM film WHERE rating = 'PG-13';

SELECT DISTINCT length from film;

SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00;

SELECT f.title, c.name as category, f.rating FROM film as f INNER JOIN film_category as fc ON f.film_id = fc.film_id INNER JOIN category as c ON c.category_id = fc.category_id WHERE f.special_features = 'Behind the Scenes';