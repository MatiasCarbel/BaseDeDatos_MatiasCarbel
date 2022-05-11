USE sakila;

#1
SELECT
    DISTINCT a1.first_name,
    a1.last_name,
    a1.actor_id
FROM
    actor a1,
    actor a2
WHERE
    a1.last_name = a2.last_name
ORDER BY
    a1.last_name;

#2
SELECT
    first_name,
    last_name,
    actor_id
FROM
    actor
WHERE
    EXISTS (
        SELECT
            actor_id
        FROM
            film_actor
    );

#3
SELECT customer_id FROM customer WHERE customer_id NOT IN (SELECT
    r1.customer_id
FROM
    rental r1,
    rental r2
WHERE
    r1.customer_id = r2.customer_id
    AND r1.inventory_id <> r2.inventory_id);
