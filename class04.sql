USE sakila;
#1
SELECT
  title,
  special_features
FROM
  film
WHERE
  rating = 'PG-13';
#2
SELECT
  DISTINCT length
from
  film;
#3
SELECT
  title,
  rental_rate,
  replacement_cost
FROM
  film
WHERE
  replacement_cost BETWEEN 20.00
  AND 24.00;
#4
SELECT
  f.title,
  c.name as category,
  f.rating
FROM
  film as f
  INNER JOIN film_category as fc ON f.film_id = fc.film_id
  INNER JOIN category as c ON c.category_id = fc.category_id
WHERE
  f.special_features = 'Behind the Scenes';
#5
SELECT
  a.first_name,
  a.last_name
FROM
  film AS f
  INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
  INNER JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE
  f.title = "ZOOLANDER FICTION";
#6
SELECT
  ad.address,
  ci.city,
  co.country
FROM
  store as st
  JOIN address as ad on st.address_id = ad.address_id
  JOIN city as ci ON ad.city_id = ci.city_id
  JOIN country as co on ci.country_id = co.country_id;
