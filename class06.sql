USE sakila;

SELECT DISTINCT (SELECT GROUP_CONCAT(a1.first_name)FROM actor a1 WHERE
	a1.last_name = a2.last_name) FROM actor a2;
A