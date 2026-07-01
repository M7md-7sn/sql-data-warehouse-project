/*
================================================================================
Quality Checks
================================================================================

Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and business rules.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading data into the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.

================================================================================
*/

USE DataWarehouse;

-- Check For Nulls of Duplicates in Primary Key
-- Expecetation: No Result

SELECT 
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- Check For Unwanted Spaces
-- Expecetation: No Result

SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);


SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)


-- Data Standardization & Consistency

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info



SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info
