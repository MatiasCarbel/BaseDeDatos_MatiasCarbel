USE sakila;

SELECT title, special_features FROM film WHERE rating = 'PG-13';

SELECT DISTINCT length from film;

SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00;

