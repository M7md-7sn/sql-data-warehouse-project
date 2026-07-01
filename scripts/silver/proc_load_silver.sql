USE DataWarehouse; -- ============================================================ -- Table: silver.crm_cust_info -- Description: --     Creates the Silver layer table used to store customer --     master data from the CRM system. -- -- Notes: --     This table serves as the destination for customer data --     loaded and transformed into the Silver layer. -- ============================================================

IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info (
    cst_id             INT          ,
    cst_key            NVARCHAR (50),
    cst_firstname      NVARCHAR (50),
    cst_lastname       NVARCHAR (50),
    cst_marital_status NVARCHAR (50),
    cst_gndr           NVARCHAR (50),
    cst_create_date    DATE         ,
    dwh_create_date    DATETIME2     DEFAULT GETDATE()
);


GO
-- ============================================================
-- Table: silver.crm_prod_info
-- Description:
--     Creates the Silver layer table used to store product
--     master data from the CRM system.
--
-- Notes:
--     This table serves as the destination for product data
--     loaded and transformed into the Silver layer.
-- ============================================================
IF OBJECT_ID('silver.crm_prod_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prod_info;

CREATE TABLE silver.crm_prod_info (
    prd_id          INT          ,
    cat_id          NVARCHAR (50),
    prd_key         NVARCHAR (50),
    prd_nm          NVARCHAR (50),
    prd_cost        INT          ,
    prd_line        NVARCHAR (50),
    prd_start_dt    DATE         ,
    prd_end_dt      DATE         ,
    dwh_create_date DATETIME2     DEFAULT GETDATE()
);


GO
-- ============================================================
-- Table: silver.crm_sales_details
-- Description:
--     Creates the Silver layer table used to store sales
--     transaction data from the CRM system.
--
-- Notes:
--     This table serves as the destination for sales
--     transaction data loaded into the Silver layer.
-- ============================================================
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
    sls_ord_num     NVARCHAR (50),
    sls_prd_key     NVARCHAR (50),
    sls_cust_id     INT          ,
    sls_order_dt    DATE         ,
    sls_ship_dt     DATE         ,
    sls_due_dt      DATE         ,
    sls_sales       INT          ,
    sls_quantity    INT          ,
    sls_price       INT          ,
    dwh_create_date DATETIME2     DEFAULT GETDATE()
);


GO
-- ============================================================
-- Table: silver.erp_cust_az12
-- Description:
--     Creates the Silver layer table used to store customer
--     demographic data from the ERP system.
--
-- Notes:
--     This table serves as the destination for customer
--     demographic data loaded into the Silver layer.
-- ============================================================
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;

CREATE TABLE silver.erp_cust_az12 (
    cid             NVARCHAR (50),
    bdate           DATE         ,
    gen             NVARCHAR (50),
    dwh_create_date DATETIME2     DEFAULT GETDATE()
);


GO
-- ============================================================
-- Table: silver.erp_loc_a101
-- Description:
--     Creates the Silver layer table used to store customer
--     location data from the ERP system.
--
-- Notes:
--     This table serves as the destination for customer
--     location data loaded into the Silver layer.
-- ============================================================
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;

CREATE TABLE silver.erp_loc_a101 (
    cid             NVARCHAR (50),
    cntry           NVARCHAR (50),
    dwh_create_date DATETIME2     DEFAULT GETDATE()
);


GO
-- ============================================================
-- Table: silver.erp_px_cat_g1v2
-- Description:
--     Creates the Silver layer table used to store product
--     category and classification data from the ERP system.
--
-- Notes:
--     This table serves as the destination for product
--     category and classification data loaded into the
--     Silver layer.
-- ============================================================
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;

CREATE TABLE silver.erp_px_cat_g1v2 (
    id              NVARCHAR (50),
    cat             NVARCHAR (50),
    subcat          NVARCHAR (50),
    maintenance     NVARCHAR (50),
    dwh_create_date DATETIME2     DEFAULT GETDATE()
);
