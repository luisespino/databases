CREATE TABLE city (
    id NUMBER(10) NOT NULL,
    name VARCHAR2(255) NOT NULL,
    countrycode CHAR(3) NOT NULL,
    district VARCHAR2(255) NULL,
    population NUMBER(10) NOT NULL,
    CONSTRAINT city_pkey PRIMARY KEY (id)
);

CREATE TABLE country (
    code CHAR(3) NOT NULL,
    name VARCHAR2(255) NOT NULL,
    continent VARCHAR2(255) NOT NULL,
    region VARCHAR2(255) NOT NULL,
    surfacearea NUMBER(10, 2) NOT NULL,
    indepyear NUMBER(5) NULL,
    population NUMBER(10) NOT NULL,
    lifeexpectancy NUMBER(10, 2) NULL,
    gnp NUMBER(10, 2) NULL,
    gnpold NUMBER(10, 2) NULL,
    localname VARCHAR2(255) NOT NULL,
    governmentform VARCHAR2(255) NOT NULL,
    headofstate VARCHAR2(255) NULL,
    capital NUMBER(10) NULL,
    code2 CHAR(2) NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (code)
);

CREATE TABLE countrylanguage (
    countrycode CHAR(3) NOT NULL,
    language VARCHAR2(255) NOT NULL,
    isofficial CHAR(1) NOT NULL,
    percentage NUMBER(5, 2) NOT NULL,
    CONSTRAINT countrylanguage_pkey PRIMARY KEY (countrycode, language)
);


