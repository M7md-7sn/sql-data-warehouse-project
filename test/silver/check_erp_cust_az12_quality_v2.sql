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

-- Check Keys Values

SELECT DISTINCT cid,
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
	END cid_new
FROM bronze.erp_cust_az12
WHERE cid NOT IN (
	SELECT cst_key
	FROM silver.crm_cust_info
)

SELECT DISTINCT cid,
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
	END cid_new
FROM bronze.erp_cust_az12
WHERE CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		ELSE cid
	END NOT IN (
	SELECT cst_key
	FROM silver.crm_cust_info
)



-- Identify Invalid Dates

SELECT *
FROM bronze.erp_cust_az12
WHERE bdate <= '1924-01-01' OR bdate >= GETDATE();






-- Data Standardization & Consistency

SELECT DISTINCT gen,
	CASE
		WHEN TRIM(UPPER(gen)) IN ('F', 'FEMALE') THEN 'Female'
		WHEN TRIM(UPPER(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'n/a'
	END AS gen
FROM bronze.erp_cust_az12