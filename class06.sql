USE sakila;

#1
SELECT
    DISTINCT a1.first_name,
    a1.last_name
FROM
    actor a1,
    actor a2
WHERE
    a1.last_name = a2.last_name
    AND a1.actor_id <> a2.actor_id
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
