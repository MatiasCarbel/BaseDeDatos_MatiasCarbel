USE sakila;

#1
SELECT
	title,
	special_features
FROM
	film
WHERE
	rating = 'PG-13';

#2 SELECT DISTINCT length from film;

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
	INNER JOIN address as ad ON st.address_id = ad.address_id
	INNER JOIN city as ci ON ad.city_id = ci.city_id
	INNER JOIN country as co ON ci.country_id = co.country_id;

#7
SELECT
	f1.title,
	f2.title,
	f1.rating
FROM
	film f1,
	film f2
WHERE
	f1.rating = f2.rating
	AND f1.film_id <> f2.film_id
ORDER BY
	f1.title;

#8
SELECT
	f.title,
	sto.store_id,
  sta.first_name,
  sta.last_name
FROM
	film as f
	INNER JOIN inventory as inv ON f.film_id = inv.film_id
	INNER JOIN store as sto ON inv.store_id = sto.store_id
  INNER JOIN staff as sta ON sto.manager_staff_id = sta.staff_id
WHERE
  sto.store_id = 2;

  A