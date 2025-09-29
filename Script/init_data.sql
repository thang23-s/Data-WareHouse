/*Create Database and Schemas 
Script Purpose:
This script creates a new database name "DataWareHouse" after checking if it already exists.
IF the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database: 'bronze', 'silver' and 'gold'
*/

Use master:
Go 

--Drop and recreate--
IF exists (select 1 from sys.database WHERE name = 'DataWarehouse')
Begin
     ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
     DROP DATABASE DataWarehouse;
END;
GO

--Create database--
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Create Schemas
CREATE SCHEMAS bronze;
GO

CREATE SCHEMAS sliver;
GO

CREATE SCHEMAS gold;
GO
