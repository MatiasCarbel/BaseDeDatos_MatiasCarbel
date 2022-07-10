-- Active: 1654711325756@@127.0.0.1@3306@sakila

use sakila;

#1 
CREATE
OR
REPLACE
    VIEW list_of_customers AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name),
    a.address,
    a.postal_code,
    a.phone,
    ci.city,
    co.country,
    CASE
        WHEN c.active = 1 THEN 'Active'
        ELSE 'Inactive'
    END 'Status'
FROM customer c
    INNER JOIN address a USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id);

SELECT * FROM list_of_customers;

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name),
    a.address,
    a.postal_code,
    a.phone,
    ci.city,
    co.country,
    CASE
        WHEN c.active = 1 THEN 'Active'
        ELSE 'Inactive'
    END 'Status'
FROM customer c
    INNER JOIN address a USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id);

#2
CREATE
OR
REPLACE VIEW film_details AS
SELECT
    f.film_id,
    f.title,
    f.description,
    ca.name AS 'Category',
    f.rental_rate AS 'Price',
    f.length,
    f.rating,
    GROUP_CONCAT(
        CONCAT(a.first_name, ' ', a.last_name)
    ) AS 'Actors'
FROM film f
    INNER JOIN film_category USING(film_id)
    INNER JOIN category ca USING(category_id)
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor a USING(actor_id)
GROUP BY film_id, ca.name;

SELECT * FROM film_details;

#3 #4 #5 