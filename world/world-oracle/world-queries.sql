
-- 1. ¿Cuántos idiomas tiene el país con código 'USA'?

SELECT COUNT(*)
	FROM country c, countrylanguage l
	WHERE c.code = l.countrycode
	AND c.code = 'USA'


-- 2. ¿Cuál es el promedio de porcentaje de lenguaje 'Spanish' 
-- en los paises que sí lo hablan de la región 'Caribbean'?

SELECT AVG(percentage)
	FROM country c, countrylanguage l
	WHERE c.code = l.countrycode
	AND c.region = 'Caribbean'
	AND language = 'Spanish'


-- 3. ¿En cuantos paises no se habla el lenguaje 'English'?

SELECT 
	(SELECT COUNT(*)
		FROM country c)
	-
	(SELECT COUNT(*)
		FROM country c, countrylanguage l
		WHERE c.code = l.countrycode
		AND l.language = 'English')


-- 4. ¿Cuántas personas de manera aproximada de la ciudad
-- 'Mumbai' del país 'IND' hablan lenguaje 'Hindi' según 
-- su porcentaje?

SELECT ROUND(
	(SELECT population
		FROM city
		WHERE name = 'Mumbai (Bombay)' )
	*
	(SELECT percentage
		FROM country c, countrylanguage l
		WHERE c.code = l.countrycode
		AND c.code = 'IND'
		AND l.language = 'Hindi')
	/
	100)

-- 5. Mostrar una tabla categorizada por el nivel expectativa 
-- de vida nula, baja, media y alta de países. Los resultados 
-- deben estar agrupados por continente. 
-- (Usar tablas dinamicas con CASE)

SELECT * FROM (
	(SELECT continent,
		sum (CASE WHEN lifeexpectancy IS NULL THEN 1 ELSE 0 END) nula,
		sum (CASE WHEN lifeexpectancy<50 THEN 1 ELSE 0 END) baja,
		sum (CASE WHEN (lifeexpectancy>=50 AND lifeexpectancy<65) THEN 1 ELSE 0 END) media,
		sum (CASE WHEN lifeexpectancy>=65 THEN 1 ELSE 0 END) alta,
		count(name) as subtotal
		FROM country
		GROUP BY continent order by continent)
	UNION
	(SELECT 'TOTAL',
		sum (CASE WHEN lifeexpectancy IS NULL THEN 1 ELSE 0 END) nula,
		sum (CASE WHEN lifeexpectancy<50 THEN 1 ELSE 0 END) baja,
		sum (CASE WHEN (lifeexpectancy>=50 AND lifeexpectancy<65) THEN 1 ELSE 0 END) media,
		sum (CASE WHEN lifeexpectancy>=65 THEN 1 ELSE 0 END) alta,
		count(name) as subtotal
		FROM country)) AS t
	ORDER BY continent


-- 6. Mostrar los nombres de países que concuerdan con el nombre de una ciudad.

SELECT name FROM country
INTERSECT
SELECT name FROM city

-- alternativo
SELECT name 
	FROM country
	WHERE name IN (SELECT name FROM city)

--alternativo
SELECT name 
	FROM country
	WHERE name = ANY 
	(SELECT name FROM city)


-- 7. Mostrar los nombres de países que NO concuerdan con el nombre de una ciudad.

SELECT name FROM country
EXCEPT -- MINUS
SELECT name FROM city

-- alternativo
SELECT name 
	FROM country
	WHERE name 
	
-- alternativo
SELECT name 
	FROM country
	WHERE name != ALL (SELECT name FROM city)


-- 8. Mostrar cuál es el valor máximo y el mínimo de esperanza de vida de los países
-- (no tomar en cuenta los nulos).

SELECT MAX(lifeexpectancy), MIN(lifeexpectancy)
	FROM country


-- 9. Mostrar los nombres de países ordenados alfabéticamente y el número de 
-- ciudades que tiene.

SELECT co.name, COUNT(ci.countrycode)
	FROM city ci, country co
	WHERE co.code = ci.countrycode
	GROUP BY co.name
	ORDER BY co.name 


-- 10. Mostrar los nombres de países que no tienen ninguna ciudad asociada.

SELECT name 
	FROM country 
	WHERE code NOT IN 
		(SELECT countrycode 
			FROM city 
			GROUP BY countrycode)
			