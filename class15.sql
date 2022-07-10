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

#3
CREATE
OR
REPLACE
    VIEW sales_by_film_category AS
SELECT
    ca.name,
    COUNT(r.rental_id) AS total_rental
FROM film
    INNER JOIN film_category USING(film_id)
    INNER JOIN category ca USING(category_id)
    INNER JOIN inventory USING(film_id)
    INNER JOIN rental r USING(inventory_id)
GROUP BY ca.name;

SELECT * FROM sales_by_film_category;

#4
CREATE
OR
REPLACE
    VIEW actor_information AS
SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS 'Actor',
    COUNT(film_id) AS 'Films Acted'
FROM actor a
    INNER JOIN film_actor USING(actor_id)
    INNER JOIN film USING(film_id)
GROUP BY a.actor_id
ORDER BY a.last_name;

SELECT * FROM actor_information;
#5
SHOW CREATE VIEW actor_info;

#6
/*A Materialized View (MV) is the pre-calculated (materialized) result of a query.
Unlike a simple VIEW the result of a Materialized View is stored somewhere,
generally in a table. Materialized Views are used when immediate response is needed
and the query where the Materialized View bases on would take to long to produce a result.
MySQL does not provide Materialized Views by itself. But it is easy to build Materialized Views yourself.
Materialized Views have to be refreshed once in a while.
https://fromdual.com/mysql-materialized-views#what_is
*/