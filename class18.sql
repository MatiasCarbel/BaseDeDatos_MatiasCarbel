use sakila;

SHOW PROCEDURE STATUS;

SHOW CREATE PROCEDURE film_in_stock;
CALL film_in_stock('1', '1', '5');