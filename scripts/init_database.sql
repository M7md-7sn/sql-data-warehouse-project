/*
===========================================================
Create Database and Schemas
===========================================================

Script Purpose:
---------------
This script creates a new database named 'DataWarehouse'.

- If the database already exists, it is dropped and recreated.
- Three schemas are then created within the database:
  - Bronze
  - Silver
  - Gold

Warning:
--------
Running this script will permanently delete the existing
'DataWarehouse' database, if it exists.

All data stored in the database will be lost.

Proceed with caution and ensure you have a backup before
executing this script.
*/


--Create DataWarehouse Database, Drop DatWarehouse database and recreate it.
USE master;


IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN

	ALTER DATABASE DataWarehouse
	SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE;

	DROP DATABASE DataWarehouse;
END

CREATE DATABASE DataWarehouse;


-- Create schemas.
GO
USE DataWarehouse;

GO
CREATE SCHEMA bronze;

GO
CREATE SCHEMA silver;

GO
CREATE SCHEMA gold;
