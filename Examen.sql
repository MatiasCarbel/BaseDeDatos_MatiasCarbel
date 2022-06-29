USE sakila;

#Obtener los pares de payments que comparten un monto(amount)
SELECT
    DISTINCT p1.payment_id,
    p2.payment_id,
    p1.amount
FROM payment p1, payment p2
WHERE p1.amount = p2.amount;

#Obtener las peliculas cuyas duraciones son mayores a la duracion(length) minima
SELECT f.title, f.length
FROM film f
WHERE f.length > (
        SELECT MIN(f2.length)
        FROM film f2
    );

#Obtener las peliculas que tienen los actors, 
#PENELOPE	GUINESS, NICK	WAHLBERG pero cuya categoria no es Documentary
SELECT f.title
FROM film f
WHERE f.film_id IN (
        SELECT fa.film_id
        FROM film_actor fa
        WHERE fa.actor_id IN (
                SELECT
                    actor_id
                FROM actor
                WHERE
                    first_name LIKE 'PENELOPE'
                    AND last_name LIKE 'GUINESS'
                    OR first_name LIKE 'NICK'
                    AND last_name LIKE 'WAHLBERG'
            )
    )
    AND f.film_id IN (
        SELECT film_id
        FROM film_category
        WHERE category_id IN (
                SELECT
                    category_id
                FROM category
                WHERE
                    name NOT LIKE 'Documentary'
            )
    );

#Obtener la venta maxima, minima, 
#la venta cuyo monto es igual al promedio, la cantidad de ventas y el monto recaudado por cada staff
SELECT
    st.staff_id,
    st.first_name, (
        SELECT MIN(p.amount)
        FROM payment p
        WHERE
            st.staff_id = p.staff_id
    ) AS 'Minimo', (
        SELECT MAX(p2.amount)
        FROM payment p2
        WHERE
            st.staff_id = p2.staff_id
    ) AS 'Maximo', (
        SELECT
            DISTINCT p3.amount
        FROM payment p3
        WHERE
            st.staff_id = p3.staff_id
        GROUP BY p3.amount
        HAVING p3.amount = (
                SELECT
                    AVG(amount)
                FROM
                    payment
            )
    ) AS 'Promedio', (
        SELECT COUNT(*)
        FROM payment p
        WHERE
            st.staff_id = p.staff_id
    ) AS 'Cantidad', (
        SELECT SUM(p4.amount)
        FROM
            payment p4
    ) AS 'Monto'
FROM staff st;

#Obtener las peliculas cuya descripcion contenga un caracter que no sea una letra, 
#es decir caracteres especiales, numeros,etc.
SELECT f.description
FROM film f
WHERE
    f.description REGEXP '^[A-Z a-z]+$';

#Obtener la variacion(max-min) de la duracion por rating(rating) 
#y caracteristicas especiales(special_features), 
#pista usar agregaciones(max,min,group by,avg,etc.) y subqueries
SELECT
    f1.rating,
    f1.special_features, (
        MAX(f1.length) - MIN(f1.length)
    )
FROM film f1
GROUP BY
    f1.special_features,
    f1.rating
ORDER BY f1.rating;

SELECT
    f.special_features, (MAX(f.length) - MIN(f.length))
FROM film f
GROUP BY f.special_features;

#Mostrar los datos del cliente, la cantidad de peliculas que alquilo y en una columna separado por comas
# el nombre de las peliculas que alguna vez alquilo. 
#Ademas debera mostrar su compra maxima y minima y el promedio del monto de sus compras
SELECT
    c.first_name,
    c.last_name, (
        SELECT COUNT(*)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    ), (
        SELECT
            GROUP_CONCAT(f.title)
        FROM film f
        WHERE f.film_id IN (
                SELECT
                    i.film_id
                FROM
                    inventory i
                WHERE
                    i.inventory_id IN(
                        SELECT
                            r.inventory_id
                        FROM
                            rental r
                        WHERE
                            r.customer_id = c.customer_id
                    )
            )
    ), (
        SELECT MAX(p.amount)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    ), (
        SELECT MIN(p.amount)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    ), (
        SELECT AVG(p.amount)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    )
FROM customer c;

SELECT GROUP_CONCAT(title) FROM film;