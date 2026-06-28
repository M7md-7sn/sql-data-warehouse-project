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

USE MASTER;
-- Drop and Recrate 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END

-- Create 'DataWarehouse' Database
CREATE DATABASE DataWarehouse;



USE DataWarehouse;

GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
