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
SELECT
    first_name,
    last_name
FROM
    customer c
WHERE
    1 =(
        SELECT
            COUNT(*)
        FROM
            rental r
        WHERE
            c.customer_id = r.customer_id
    );

select
    c.first_name,
    c.last_name
from
    customer c
where
    c.customer_id NOT IN (
        select
            r.customer_id
        from
            rental r
        group by
            r.customer_id
        having
            count(*) > 1
    )
order by
    c.customer_id;

#4
