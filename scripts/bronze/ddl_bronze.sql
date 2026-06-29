GO
USE DataWarehouse;

-- ============================================================
-- Table: bronze.crm_cust_info
-- Description:
--     Stores raw customer master data ingested from the CRM system.
--
-- Notes:
--     Data is loaded without transformation and serves as the
--     source for customer cleansing and standardization in the
--     Silver layer.
-- ============================================================
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

GO

-- ============================================================
-- Table: bronze.crm_prod_info
-- Description:
--     Stores raw product master data ingested from the CRM system.
--
-- Notes:
--     Preserves source product information for downstream
--     transformation and enrichment.
-- ============================================================
IF OBJECT_ID('bronze.crm_prod_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prod_info;

CREATE TABLE bronze.crm_prod_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

GO

-- ============================================================
-- Table: bronze.crm_sales_details
-- Description:
--     Stores raw sales transaction data extracted from the CRM
--     sales system.
--
-- Notes:
--     Contains transactional sales data used to build the Sales
--     Fact table in the Silver and Gold layers.
-- ============================================================
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

GO

-- ============================================================
-- Table: bronze.erp_cust_az12
-- Description:
--     Stores raw customer demographic data extracted from the ERP
--     system.
--
-- Notes:
--     Used to enrich CRM customer records with additional
--     demographic attributes.
-- ============================================================
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);

GO

-- ============================================================
-- Table: bronze.erp_loc_a101
-- Description:
--     Stores raw customer location data extracted from the ERP
--     system.
--
-- Notes:
--     Provides geographic attributes used during customer
--     integration.
-- ============================================================
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101(
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

GO

-- ============================================================
-- Table: bronze.erp_px_cat_g1V2
-- Description:
--     Stores raw product category and maintenance information
--     extracted from the ERP system.
--
-- Notes:
--     Used to enrich product records with category and
--     classification attributes.
-- ============================================================
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
