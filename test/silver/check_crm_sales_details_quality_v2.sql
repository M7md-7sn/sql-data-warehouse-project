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

-- Check Nulls
-- Expectation: No Results



SELECT sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num IS NULL;


SELECT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key IS NULL;

SELECT DISTINCT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (
	SELECT DISTINCT prd_key
	FROM silver.crm_prod_info
);

SELECT sls_cust_id
FROM bronze.crm_sales_details
WHERE sls_cust_id IS NULL;

SELECT DISTINCT sls_cust_id
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN(
	SELECT DISTINCT cst_id
	FROM silver.crm_cust_info
);


-- Check Invalid Dates
-- Expectation: No Results


SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt IS NULL OR
	LEN(sls_order_dt) != 8 OR
	sls_order_dt < 19000101 OR
	sls_order_dt > 20500101


SELECT sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt IS NULL OR
	LEN(sls_ship_dt) != 8 OR
	sls_ship_dt < 19000101 OR
	sls_ship_dt > 20500101


SELECT sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt IS NULL OR
	LEN(sls_due_dt) != 8 OR
	sls_due_dt < 19000101 OR
	sls_due_dt > 20500101

SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR
	sls_order_dt > sls_due_dt

SELECT *
FROM bronze.crm_sales_details
WHERE sls_ship_dt > sls_due_dt


-- Check Consistency: Between Sales, Quantity and Price
-- Sales = Quantity * Price
-- Values must be Not Null, Zero, Not Negative.



SELECT DISTINCT 
	sls_sales, sls_quantity, sls_price,
	CASE
		WHEN sls_sales IS NULL OR sls_sales < 0 OR sls_sales != ABS(sls_quantity) * ABS(sls_price)
			THEN ABS(sls_quantity) * ABS(sls_price)
		ELSE sls_sales
	END AS new_sls_sales,
	CASE
		WHEN sls_quantity IS NULL OR sls_quantity < 0
			THEN ABS(sls_quantity) / ABS(sls_quantity)
		ELSE sls_quantity
	END AS sls_quantity,
	CASE 
		WHEN sls_price IS NULL OR sls_price < 0
			THEN ABS(sls_sales) / ABS(sls_quantity)
		ELSE sls_price
	END AS sls_price
FROM bronze.crm_sales_details
WHERE sls_price != sls_sales * sls_quantity OR
	sls_price IS NULL OR sls_quantity IS NULL OR sls_sales IS NULL OR
	sls_price <= 0 OR sls_quantity <= 0 OR sls_sales <=  0 

