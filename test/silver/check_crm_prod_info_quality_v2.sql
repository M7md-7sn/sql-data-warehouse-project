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

-- Check Nulls and Duplicates in Primary Key
-- Expectation: No Result


SELECT prd_id,
	COUNT(*) AS no_prod
FROM silver.crm_prod_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


-- Check For Unwanted Spaces 
-- Expectation: No Results

SELECT prd_nm
FROM silver.crm_prod_info
WHERE prd_nm != TRIM(prd_nm)


-- Check For Negative or Null Costs
-- Expectation: No Results

SELECT prd_cost
FROM silver.crm_prod_info
WHERE prd_cost < 0 OR prd_cost IS NULL;


-- Data Standardization and Cardinality

SELECT DISTINCT prd_line
FROM silver.crm_prod_info



-- Check Data Columns Quality
-- Expectation: No Results

SELECT *
FROM silver.crm_prod_info
WHERE prd_start_dt > prd_end_dt


SELECT *,
	DATEADD(DAY, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_start_dt_new
FROM silver.crm_prod_info
WHERE prd_key IN ('AC-HE-HL-U509', 'AC-HE-HL-U509-R');