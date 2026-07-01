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
SELECT *
FROM   bronze.erp_px_cat_g1v2;


-- Check for Unwanted Spaces
SELECT *
FROM   bronze.erp_px_cat_g1v2
WHERE  cat != TRIM(cat)
       OR subcat != TRIM(subcat)
       OR maintenance != TRIM(maintenance);


-- Check Data Standardization & Consistency

SELECT DISTINCT cat
FROM   bronze.erp_px_cat_g1v2;


SELECT DISTINCT subcat
FROM   bronze.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2