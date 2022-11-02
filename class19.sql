-- Active: 1654711325756@@127.0.0.1@3306@sakila

#Create a user data_analyst
CREATE USER data_analyst@localhost IDENTIFIED BY 'pepe1234';


#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';
SHOW GRANTS FOR 'data_analyst'@'localhost';


#Login with this user and try to create a table. Show the result of that operation.
USE sakila;

CREATE TABLE new_table( id INT(10) NOT NULL );
/*
ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'new_table'
*/


#Try to update a title of a film. Write the update script.
UPDATE film SET title = 'ACADEMY DINOSAUR 2' WHERE title = 'ACADEMY DINOSAUR';


#With root or any admin user revoke the UPDATE permission. Write the command
REVOKE UPDATE ON sakila.* FROM data_analyst;


#Login again with data_analyst and try again the update done in step 4. Show the result.
UPDATE film SET title = 'ACADEMY DINOSAUR' WHERE title = 'ACADEMY DINOSAUR 2';
/*
ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
*/