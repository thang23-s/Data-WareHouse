/* ==========================================================
   Quality Checks - Silver Layer
   Purpose:
     - Validate PK uniqueness & nulls
     - Check spaces, invalid values, dates
     - Ensure data consistency & standardization
   ========================================================== */

-- crm_cust_info
SELECT cst_id, COUNT(*) FROM silver.crm_cust_info 
GROUP BY cst_id HAVING COUNT(*)>1 OR cst_id IS NULL;        -- PK check
SELECT cst_key FROM silver.crm_cust_info 
WHERE cst_key!=TRIM(cst_key);                               -- Spaces
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info; -- Standardization

-- crm_prd_info
SELECT prd_id, COUNT(*) FROM silver.crm_prd_info 
GROUP BY prd_id HAVING COUNT(*)>1 OR prd_id IS NULL;        -- PK check
SELECT prd_nm FROM silver.crm_prd_info 
WHERE prd_nm!=TRIM(prd_nm);                                 -- Spaces
SELECT prd_cost FROM silver.crm_prd_info 
WHERE prd_cost<0 OR prd_cost IS NULL;                       -- Invalid cost
SELECT DISTINCT prd_line FROM silver.crm_prd_info;          -- Standardization
SELECT * FROM silver.crm_prd_info 
WHERE prd_end_dt<prd_start_dt;                              -- Invalid dates

-- crm_sales_details
SELECT NULLIF(sls_due_dt,0) FROM bronze.crm_sales_details
WHERE sls_due_dt<=0 OR LEN(sls_due_dt)!=8 
   OR sls_due_dt>20500101 OR sls_due_dt<19000101;           -- Invalid due_dt
SELECT * FROM silver.crm_sales_details
WHERE sls_order_dt>sls_ship_dt OR sls_order_dt>sls_due_dt;  -- Date order
SELECT * FROM silver.crm_sales_details
WHERE sls_sales!=sls_quantity*sls_price 
   OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
   OR sls_sales<=0 OR sls_quantity<=0 OR sls_price<=0;      -- Sales consistency

-- erp_cust_az12
SELECT DISTINCT bdate FROM silver.erp_cust_az12
WHERE bdate<'1924-01-01' OR bdate>GETDATE();                -- Birthdate range
SELECT DISTINCT gen FROM silver.erp_cust_az12;              -- Standardization

-- erp_loc_a101
SELECT DISTINCT cntry FROM silver.erp_loc_a101 ORDER BY cntry;

-- erp_px_cat_g1v2
SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat!=TRIM(cat) OR subcat!=TRIM(subcat) OR maintenance!=TRIM(maintenance); -- Spaces
SELECT DISTINCT maintenance FROM silver.erp_px_cat_g1v2;     -- Standardization
