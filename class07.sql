-- Active: 1654711325756@@127.0.0.1@3306

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

#3 Generate a report with list of customers showing the lowest payments done by each of them.
#Show customer information, the address and the lowest amount,
#provide both solution using ALL and/or ANY and MIN.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT
            DISTINCT p.amount
        FROM
            payment p
        WHERE
            c.customer_id = p.customer_id
            AND p.amount <= ALL (
                SELECT
                    p2.amount
                FROM
                    payment p2
                WHERE
                    c.customer_id = p2.customer_id
            )
            
    ) AS lowest_payment
FROM
    customer c;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT
            MIN(p.amount)
        FROM
            payment p
        WHERE
            c.customer_id = p.customer_id
    ) as lowest_payment,
    (
                SELECT
                    a.address
                FROM
                    address a
                WHERE
                    c.address_id = a.address_id
            )
FROM
    customer c;

#4Generate a report that shows the customer's information 
#with the highest payment and the lowest payment in the same row.
SELECT customer.customer_id, first_name, last_name, CONCAT(max(payment.amount),'  ' ,min(payment.amount)) AS MaxMin
FROM customer, payment 
WHERE customer.customer_id = payment.customer_id 
GROUP BY customer.customer_id, first_name, last_name;
        