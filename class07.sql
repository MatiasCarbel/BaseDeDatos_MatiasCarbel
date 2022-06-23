USE sakila;

#1Find the films with less duration, show the title and rating.
SELECT
    f.title,
    f.rating,
    f.length
FROM
    film f
WHERE
    f.length =(
        SELECT
            MIN(f2.length)
        FROM
            film f2
    );

#2 Write a query that returns the tiltle of the film which duration is the lowest.
#If there are more than one film with the lowest durtation, the query returns an empty resultset.
SELECT
    f.title,
    f.rating,
    f.length
FROM
    film f
WHERE
    f.length < ALL(
        SELECT
            MIN(f2.length)
        FROM
            film f2
    );

#3Generate a report with list of customers showing the lowest payments done by each of them.
#Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT
            MIN(amount)
        FROM
            payment p
        WHERE
            c.customer_id = p.customer_id
    ) AS pay
FROM
    customer c
ORDER BY
    pay;