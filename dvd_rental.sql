--MODULO 5:FUNDAMENTOS DE BASE DE DATOS RELACIONALES
-- DRILLING FINAL: Arriendo de DVDS

-- Creación de Base de Datos en Psql --
-- Database: dvdrental


-- Carga del archivo "dvdrental.tar" en CMD --

-- Desarrollo del punto 4 en adelante en "pgAdmin 4" --
-- 4. Construye las siguientes consultas:
-- • Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.

-- Se inserta en tabla CUSTOMER
INSERT INTO customer (store_id, first_name,last_name,email, address_id, activebool, last_update, active)
VALUES(9, 'Ian', 'Durant', 'idurant@esmimail.cl', 455, true, now(), 1);
-- Se consulta por el registro agregado a la tabla Customer
SELECT *FROM customer WHERE email = 'idurant@esmimail.cl';
-- Se realiza modificación de email
update customer set email = 'ian.durant@esmimail.cl';

-- Se inserta en la tabla Staff
INSERT INTO public.staff (store_id, first_name, last_name,address_id,  active, username, password, last_update)
VALUES(5, 'Alegro', 'Camaro', 6,  true, 'chiquitete', '15150', now()),
	  (5, 'Alegro', 'Camaro', 6, true, 'chiquitete', '15150', now());
-- Se realiza consulta a registro agregado a la tabla Staff
SELECT *FROM public.staff WHERE username = 'chiquitete';
-- Se modifica registro a tabla Staff, se agrega email
update public.staff set email = 'alegro@esmimail.com';
-- Se elimina de la tabla Staff el registro duplicado
DELETE FROM public.staff WHERE staff_id = 9 and username = 'chiquitete';

-- Se inserta en la tabla Actor
INSERT INTO actor(first_name, last_name, last_update)
VALUES('Leonardo', 'DiCaprio', now());
-- Se realiza consulta a registro agregado a la tabla Actor
SELECT *FROM actor WHERE last_name = 'DiCaprio';
-- Se elimina de la tabla Actor el nuevo registro
delete from actor where actor_id = 201 and last_name = 'DiCaprio' 

-- • Listar todas las “rental” con los datos del “customer” dado un año y mes.
-- Se usa JOIN para obtener resultado
SELECT
customer.first_name,
customer.last_name,
customer.customer_id,
rental.rental_id,
rental.rental_date,
customer.store_id,
customer.email,
customer.address_id,
customer.create_date
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
WHERE EXTRACT(YEAR FROM rental.rental_date) = 2005
AND EXTRACT(MONTH FROM rental.rental_date) = 6;

-- • Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT payment_id, payment_date, amount FROM payment
GROUP BY payment_id;

-- • Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
select * from film where release_year = 2006 and rental_rate > 4.0;

-- 5. Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, y su tipo de dato correspondiente.
SELECT 
	t1.TABLE_NAME AS tabla_nombre,
	t1.COLUMN_NAME AS columna_nombre,
	t1.COLUMN_DEFAULT AS columna_defecto,
	t1.IS_NULLABLE AS columna_nulo,
	t1.DATA_TYPE AS columna_tipo_dato,
	COALESCE(t1.NUMERIC_PRECISION,
	t1.CHARACTER_MAXIMUM_LENGTH) AS columna_longitud,
	PG_CATALOG.COL_DESCRIPTION(t2.OID,
	t1.DTD_IDENTIFIER::int) AS columna_descripcion,
	t1.DOMAIN_NAME AS columna_dominio
FROM 
	INFORMATION_SCHEMA.COLUMNS t1 
	INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE 
	t1.TABLE_SCHEMA = 'public'
ORDER BY 
	t1.TABLE_NAME;

--Fin de Drilling Módulo 5 --