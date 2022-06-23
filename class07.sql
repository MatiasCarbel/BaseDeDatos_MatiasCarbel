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