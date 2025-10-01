/* ==========================================================
   Quality Checks - Gold Layer
   Purpose:
     - Validate uniqueness of surrogate keys.
     - Ensure referential integrity between fact & dimensions.
     - Validate relationships for analytical correctness.
   ========================================================== */

-- Check uniqueness of keys
SELECT customer_key, COUNT(*) AS dup_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

SELECT product_key, COUNT(*) AS dup_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check referential integrity in fact_sales
SELECT f.*
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;
