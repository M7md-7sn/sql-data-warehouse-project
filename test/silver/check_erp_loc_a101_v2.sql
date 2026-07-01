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

-- Check Key Values

SELECT cid,
	cntry
FROM bronze.erp_loc_a101
WHERE cid NOT IN (
	SELECT cst_key
	FROM bronze.crm_cust_info
)


SELECT REPLACE(cid, '-', '') AS cid,
	cntry
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '') NOT IN (
	SELECT cst_key
	FROM bronze.crm_cust_info
)


-- Check Data Standrization & Consistency

SELECT DISTINCT cntry,
	CASE 
		WHEN TRIM(UPPER(cntry)) = 'DE' THEN 'Germany'
		WHEN TRIM(UPPER(cntry)) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE cntry
	END AS new_cntry
FROM bronze.erp_loc_a101
