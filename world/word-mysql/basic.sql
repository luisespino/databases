USE world;

-- show unique names of countries and cities
SELECT name FROM country
UNION
SELECT name FROM city;


-- show all names of countries and cities
SELECT name FROM country
UNION ALL
SELECT name FROM city;


-- show countries and cities with same name
SELECT name FROM country
INTERSECT
SELECT name FROM city;

-- equivalent query
SELECT name FROM country
	WHERE name IN (SELECT name FROM city);


-- show names of countries minus cities
SELECT name FROM country
EXCEPT -- MINUS
SELECT name FROM city;

-- equivalent query
SELECT name FROM country
	WHERE name
		NOT IN (SELECT name FROM city);


-- show cross join between countries and cities
SELECT count(*) FROM country, city;

-- equivalent query
SELECT count(*) FROM country CROSS JOIN city;


-- inner join between city and country
SELECT ci.name, co.name 
	FROM city ci, country co
	WHERE ci.countrycode = co.code;

-- natural join between city and country
SELECT ci.name, co.name 
	FROM city ci 
	NATURAL JOIN country co;

-- inner join between city and country
-- with using
SELECT ci.name, 
	co.name FROM city ci 
	JOIN country co USING (countrycode);

-- inner join between city and country
-- with on
SELECT ci.name, co.name 
	FROM city ci JOIN country co ON 				
	ci.countrycode = co.code;


-- left outer join
SELECT ci.name, co.name 
	FROM city ci LEFT OUTER JOIN country co 
	ON ci.countrycode = co.code;

-- rigth outer join
SELECT ci.name, co.name 
	FROM city ci RIGHT OUTER JOIN country co 
	ON ci.countrycode = co.code;


-- full outer join
SELECT ci.name, co.name 
	FROM city ci FULL OUTER JOIN 
	country co ON ci.countrycode = co.code;

-- equivalent query
SELECT ci.name, co.name 
	FROM city ci LEFT OUTER JOIN country co 
	ON ci.countrycode = co.code
UNION ALL
SELECT ci.name, co.name 
	FROM city ci RIGHT OUTER JOIN country co 
	ON ci.countrycode = co.code
	WHERE ci.countrycode IS NULL;


-- show countries with the same city name
SELECT name FROM country
	WHERE name = ANY (SELECT name FROM city);

-- show countries without any matching city name
SELECT name FROM country
	WHERE name != ALL (SELECT name FROM city);
