-- Active: 1654711325756@@127.0.0.1@3306@sakila

USE sakila;

#Add a new customer
#To store 1
#For address use an existing address. The one that has the biggest address_id in 'United States'
INSERT INTO
    customer (
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        active
    )
SELECT
    1,
    'Mati',
    'Carbel',
    'maticarbel@gmail.com',
    MAX(ad.address_id),
    1
FROM address ad
WHERE ad.city_id IN (
        SELECT ci.city_id
        FROM
            country co,
            city ci
        WHERE
            co.country = "United States"
            AND co.country_id = ci.country_id
            AND ci.city_id = ad.city_id
    );

SELECT * FROM customer WHERE last_name = "Carbel";

#Add a rental
#Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
#Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
#Select any staff_id from Store 2.
INSERT INTO
    rental (
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id
    )
SELECT CURRENT_TIMESTAMP, (
        SELECT
            MAX(i.inventory_id)
        FROM inventory i
            INNER JOIN film f USING(film_id)
        WHERE
            f.title LIKE 'ACE GOLDFINGER'
    ),
    600,
    NULL, (
        SELECT manager_staff_id
        FROM store
        WHERE store_id = 2
        ORDER BY RAND()
        LIMIT 1
    );

SELECT * FROM rental WHERE customer_id = 600;

#Update film year based on the rating
#For example if rating is 'G' release date will be '2001'
#You can choose the mapping between rating and year.
#Write as many statements are needed.
SELECT DISTINCT rating
FROM film;

UPDATE film SET release_year = 2000 WHERE rating = 'PG';

UPDATE film SET release_year = 2001 WHERE rating ='G';

UPDATE film SET release_year = 2002 WHERE rating ='NC-17';

UPDATE film SET release_year = 2003 WHERE rating ='PG-13';

UPDATE film SET release_year = 2004 WHERE rating = 'R';

SELECT * FROM film WHERE rating = 'PG';

#Return a film
#Write the necessary statements and queries for the following steps.
#Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
#Use the id to return the film.
SELECT r.rental_id
FROM film f
    INNER JOIN inventory i USING(film_id)
    INNER JOIN rental r USING(inventory_id)
WHERE r.return_date IS NULL ORDER BY r.rental_date DESC
LIMIT 1;

UPDATE rental 
SET return_date = CURRENT_TIMESTAMP
WHERE rental_id =16050;

- #Try to delete a film
#Check what happens, describe what to do.
#Write all the necessary delete statements to entirely remove the film from the DB.
- #Rent a film
#Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
#Add a rental entry
#Add a payment entry
#Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
#Once you're done. Restore the database data using the populate script from class 3.