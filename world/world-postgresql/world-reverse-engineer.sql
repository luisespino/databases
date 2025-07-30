-- 1. Show tables

SELECT tablename 
    FROM pg_catalog.pg_tables
    WHERE schemaname != 'pg_catalog'
    AND schemaname != 'information_schema';

-- 2. Count tuples of tables

SELECT COUNT(*)
    FROM country;

SELECT COUNT(*)
    FROM countrylanguage;

SELECT COUNT(*)
    FROM city;

-- 3. Show information schema of tables

SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = 'country';

SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = 'countrylanguage';

SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = 'city';

-- 4. Show both optionalities between country and countrylanguage

(SELECT 'country' tablename, COUNT(*) countries 
    FROM country)
UNION
(SELECT 'countrylanguage', COUNT(*) 
    FROM 
        (SELECT DISTINCT countrycode 
            FROM countrylanguage) AS foo);

SELECT COUNT(*)
    FROM countrylanguage
    WHERE countrycode IS NULL;

-- 5. Show both optionalities between country and city

(SELECT 'country' tablename, COUNT(*) countries 
    FROM country)
UNION
(SELECT 'city', COUNT(*) 
    FROM 
        (SELECT DISTINCT countrycode 
            FROM city) AS foo);

SELECT COUNT(*)
    FROM city
    WHERE countrycode IS NULL;

-- 6. Show both optionalities between country and city as capital

(SELECT 'country' tablename, COUNT(capital) countries 
    FROM country)
UNION
(SELECT 'city', COUNT(*) 
    FROM 
        (SELECT DISTINCT id 
            FROM city) AS foo);

SELECT COUNT(*)
    FROM country
    WHERE capital IS NULL;

-- 7. Show nullable attributes

SELECT COUNT(*)
    FROM COUNTRY
    WHERE lifeexpectancy IS NULL;

SELECT COUNT(*)
    FROM COUNTRY
    WHERE gnpold IS NULL;

SELECT COUNT(*)
    FROM COUNTRY
    WHERE headofstate IS NULL;
