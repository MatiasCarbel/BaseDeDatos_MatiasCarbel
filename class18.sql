use sakila;

SHOW PROCEDURE STATUS;

SHOW CREATE PROCEDURE film_in_stock;

CALL film_in_stock('4', '1', @t);

SELECT @t;

#1 

DELIMITER $

CREATE FUNCTION get_amount(f_id INT, st_id INT) RETURNS 
INT DETERMINISTIC 
BEGIN 
	DECLARE cant INT;
	SELECT
	    COUNT(i.inventory_id) INTO cant
	FROM film f
	    INNER JOIN inventory i USING(film_id)
	    INNER JOIN store st USING(store_id)
	WHERE
	    f.film_id = f_id
	    AND st.store_id = st_id;
	RETURN (cant);
	END 
END $ 

DELIMITER ;

SELECT get_amount(1,1);

#2
SELECT CONCAT_WS(';',c.first_name,c.last_name)
FROM customer c
    INNER JOIN address ad USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id) WHERE co.country_id = 1;