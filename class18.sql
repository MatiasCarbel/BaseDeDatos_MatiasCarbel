-- Active: 1654711325756@@127.0.0.1@3306@sakila

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
	END E 
END END $ 

DELIMITER ;

SELECT get_amount(1,1);

#2(no usar ws usar cursor) 

#selecciona ultimo
DELIMITER $

DROP PROCEDURE IF EXISTS list_procedure $

CREATE PROCEDURE list_procedure(
	IN co_name VARCHAR(250), 
	OUT list VARCHAR(500)
	) 
BEGIN 
	DECLARE finished INT DEFAULT 0;
	DECLARE f_name VARCHAR(250) DEFAULT ''; 
	DECLARE l_name VARCHAR(250) DEFAULT '';
	DECLARE coun VARCHAR(250) DEFAULT '';

	DECLARE cursList CURSOR FOR
	SELECT
	    co.country,
	    c.first_name,
	    c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursList;

	looplabel: LOOP
		FETCH cursList INTO coun, f_name, l_name;
		IF finished = 1 THEN
			LEAVE looplabel;
		END IF;

		IF coun = co_name THEN
			SET list = CONCAT(f_name,';',l_name);
		END IF;
		
		
	END LOOP looplabel;
	CLOSE cursList;
	

END $
DELIMITER ;


set @list = '';

CALL list_procedure('Argentina',@list);

SELECT @list;

SELECT
    CONCAT_WS(';', c.first_name, c.last_name)
FROM customer c
    INNER JOIN address ad USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id)
WHERE co.country = 'Argentina';

#------------------------------------------------------------------
#selecciona primero
DELIMITER $
DROP PROCEDURE IF EXISTS list_procedure $

CREATE PROCEDURE list_procedure(
	IN co_name VARCHAR(250)
	) 
BEGIN 
	DECLARE finished INT DEFAULT 0;
	DECLARE f_name VARCHAR(250) DEFAULT ''; 
	DECLARE l_name VARCHAR(250) DEFAULT '';
	DECLARE list VARCHAR(300);

	DECLARE cursList CURSOR FOR
	SELECT
	    c.first_name,
	    c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id)
	WHERE co_name = co.country;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursList;

	looplabel: LOOP
		FETCH cursList INTO f_name, l_name;
		IF finished = 1 THEN
			LEAVE looplabel;
		END IF;

		SET list = CONCAT(f_name,';',l_name);

		SELECT list;#devuelve primero

	END LOOP looplabel;
	-- SELECT list; devuelve ultimo
	CLOSE cursList;
	

END $
DELIMITER ;

CALL list_procedure('Argentina');
#3 
SHOW CREATE FUNCTION inventory_in_stock;

SHOW CREATE PROCEDURE film_in_stock;