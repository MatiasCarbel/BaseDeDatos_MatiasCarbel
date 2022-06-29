USE sakila;

#1Get the amount of cities per country in the database. 
#Sort them by country, country_id.
SELECT
    co.country_id,
    co.country, (
        SELECT COUNT(*)
        FROM city ci
        WHERE
            ci.country_id = co.country_id
    )
FROM country co
GROUP BY
    co.country,
    co.country_id;

#2Get the amount of cities per country in the database. 
#Show only the countries with more than 10 cities, 
#order from the highest amount of cities to the lowest.
SELECT
    co.country_id,
    co.country, (
        SELECT COUNT(*)
        FROM city ci
        WHERE
            ci.country_id = co.country_id
    ) AS city_quant
FROM country co
GROUP BY
    co.country,
    co.country_id
HAVING city_quant > 10
ORDER BY city_quant DESC;

#3Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
#Show the ones who spent more money first.
SELECT
    CONCAT(c.first_name, ' ', c.last_name), (
        SELECT a.address
        FROM address a
        WHERE
            a.address_id = c.address_id
    ) AS 'address', (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            r.customer_id = c.customer_id
    ) AS 'films quantity', (
        SELECT SUM(p.amount)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    ) AS 'total'
FROM customer c
ORDER BY total DESC;

#4Which film categories have the larger film duration (comparing average)?
#Order by average in descending order
SELECT ca.name, (
        SELECT AVG(f.length)
        FROM film f
        WHERE f.film_id IN(
                SELECT
                    fc.film_id
                FROM
                    film_category fc
                WHERE
                    fc.category_id = ca.category_id
            )
    ) AS average_length
FROM category ca
ORDER BY average_length DESC;

#5Show sales per film rating
SELECT f.rating, (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            r.inventory_id IN (
                SELECT
                    i.inventory_id
                FROM
                    inventory i
                WHERE
                    i.film_id IN (
                        SELECT f2.film_id
                        FROM film f2
                        WHERE f2.rating = f.rating
                    )
            )
    )
FROM film f
GROUP BY f.rating;