## World Sample Database in MySQL


Download the database:

[https://downloads.mysql.com/docs/world-db.zip](https://downloads.mysql.com/docs/world-db.zip)

Extract the SQL file from the ZIP archive:

```
unzip -j world-db.zip
```

Connect to the MySQL server using the command-line client:

```
mysql -u root -p
```

At the `mysql>` prompt, load the SQL file by running:

```
SOURCE ~/Documents/world.sql;
```

Switch to the `world` database:

```
USE world;
```

You should see the message: Database changed.

List the tables:

```
SHOW TABLES;
```

Expected output:

```
+-----------------+
| Tables_in_world |
+-----------------+
| city            |
| country         |
| countrylanguage |
+-----------------+
3 rows in set (0.002 sec)
```

