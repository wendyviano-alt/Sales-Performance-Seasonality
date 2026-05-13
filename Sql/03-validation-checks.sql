/* =====================================================
Row count checks for clean views
===================================================== */
SELECT 'clean.dim_customers' AS object_name, COUNT(*) AS row_count FROM clean.dim_customers
UNION ALL
SELECT 'clean.dim_stores', COUNT(*) FROM clean.dim_stores
UNION ALL
SELECT 'clean.dim_dates', COUNT(*) FROM clean.dim_dates
UNION ALL
SELECT 'clean.dim_currency_exchange', COUNT(*) FROM clean.dim_currency_exchange
UNION ALL
SELECT 'clean.dim_product', COUNT(*) FROM clean.dim_product
UNION ALL
SELECT 'clean.dim_order_rows', COUNT(*) FROM clean.dim_order_rows
UNION ALL
SELECT 'clean.fact_sales', COUNT(*) FROM clean.fact_sales
UNION ALL
SELECT 'clean.fact_orders', COUNT(*) FROM clean.fact_orders
UNION ALL
SELECT 'mart.vw_fact_sales_model', COUNT(*) FROM mart.vw_fact_sales_model
UNION ALL
SELECT 'mart.vw_fact_orders_model', COUNT(*) FROM mart.vw_fact_orders_model;


/* =====================================================
Duplicate key checks in dimension tables
Expected result: no rows returned
===================================================== */

SELECT 
    'dim_customers' AS table_name,
    CAST(customer_key AS varchar(100)) AS key_value,
    COUNT(*) AS duplicate_count
FROM clean.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'dim_stores',
    CAST(store_key AS varchar(100)),
    COUNT(*)
FROM clean.dim_stores
GROUP BY store_key
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'dim_product',
    CAST(product_key AS varchar(100)),
    COUNT(*)
FROM clean.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'dim_dates',
    CAST(date_key AS varchar(100)),
    COUNT(*)
FROM clean.dim_dates
GROUP BY date_key
HAVING COUNT(*) > 1

UNION ALL

SELECT 
    'dim_currency_exchange',
    CAST(currency_exchange_key AS varchar(100)),
    COUNT(*)
FROM clean.dim_currency_exchange
GROUP BY currency_exchange_key
HAVING COUNT(*) > 1;


/* =====================================================
Duplicate order row key check
Expected result: no rows returned
===================================================== */

SELECT
    order_row_key,
    COUNT(*) AS duplicate_count
FROM clean.dim_order_rows
GROUP BY order_row_key
HAVING COUNT(*) > 1;


/* =====================================================
Missing relationship checks for fact_sales
Expected result: all values should be 0
===================================================== */

SELECT
    SUM(CASE WHEN dc.customer_key IS NULL THEN 1 ELSE 0 END) AS missing_customers,
    SUM(CASE WHEN ds.store_key IS NULL THEN 1 ELSE 0 END) AS missing_stores,
    SUM(CASE WHEN dd.date_key IS NULL THEN 1 ELSE 0 END) AS missing_dates,
    SUM(CASE WHEN dp.product_key IS NULL THEN 1 ELSE 0 END) AS missing_products,
    SUM(CASE WHEN fx.currency_exchange_key IS NULL THEN 1 ELSE 0 END) AS missing_currency_exchange
FROM clean.fact_sales fs
LEFT JOIN clean.dim_customers dc
    ON fs.customer_key = dc.customer_key
LEFT JOIN clean.dim_stores ds
    ON fs.store_key = ds.store_key
LEFT JOIN clean.dim_dates dd
    ON fs.order_date_key = dd.date_key
LEFT JOIN clean.dim_product dp
    ON fs.product_key = dp.product_key
LEFT JOIN clean.dim_currency_exchange fx
    ON fs.currency_exchange_key = fx.currency_exchange_key;


/* =====================================================
Missing relationship checks for fact_orders
Expected result: all values should be 0
===================================================== */

SELECT
    SUM(CASE WHEN dc.customer_key IS NULL THEN 1 ELSE 0 END) AS missing_customers,
    SUM(CASE WHEN ds.store_key IS NULL THEN 1 ELSE 0 END) AS missing_stores,
    SUM(CASE WHEN dd.date_key IS NULL THEN 1 ELSE 0 END) AS missing_dates,
    SUM(CASE WHEN fx.currency_exchange_key IS NULL THEN 1 ELSE 0 END) AS missing_currency_exchange
FROM clean.fact_orders fo
LEFT JOIN clean.dim_customers dc
    ON fo.customer_key = dc.customer_key
LEFT JOIN clean.dim_stores ds
    ON fo.store_key = ds.store_key
LEFT JOIN clean.dim_dates dd
    ON fo.order_date_key = dd.date_key
LEFT JOIN clean.dim_currency_exchange fx
    ON fo.currency_exchange_key = fx.currency_exchange_key;


/* =====================================================
Check fact_orders with missing order rows
Expected result: 0
===================================================== */

SELECT
    COUNT(*) AS fact_orders_missing_order_rows
FROM clean.fact_orders fo
WHERE NOT EXISTS (
    SELECT 1
    FROM clean.dim_order_rows dor
    WHERE dor.order_key = fo.order_key
);


/* =====================================================
Source sales vs clean.fact_sales validation
Expected result:
dbo.sales and clean.fact_sales totals should match
===================================================== */

SELECT
    'dbo.sales' AS object_name,
    COUNT(*) AS row_count,
    SUM(Quantity) AS total_quantity,
    SUM(Quantity * UnitPrice) AS gross_sales_amount,
    SUM(Quantity * NetPrice) AS net_sales_amount,
    SUM(Quantity * UnitCost) AS cost_amount,
    SUM(Quantity * (NetPrice - UnitCost)) AS margin_amount
FROM dbo.sales

UNION ALL

SELECT
    'clean.fact_sales',
    COUNT(*) AS row_count,
    SUM(quantity) AS total_quantity,
    SUM(gross_sales_amount) AS gross_sales_amount,
    SUM(net_sales_amount) AS net_sales_amount,
    SUM(cost_amount) AS cost_amount,
    SUM(margin_amount) AS margin_amount
FROM clean.fact_sales;


/* =====================================================
Source order rows vs clean.fact_orders validation
Expected result:
dbo.orderrows aggregated and clean.fact_orders totals should match
===================================================== */

SELECT
    'dbo.orderrows aggregated' AS object_name,
    COUNT(DISTINCT OrderKey) AS order_count,
    SUM(Quantity) AS total_quantity,
    SUM(Quantity * UnitPrice) AS gross_order_amount,
    SUM(Quantity * NetPrice) AS net_order_amount,
    SUM(Quantity * UnitCost) AS order_cost_amount,
    SUM(Quantity * (NetPrice - UnitCost)) AS order_margin_amount
FROM dbo.orderrows

UNION ALL

SELECT
    'clean.fact_orders',
    COUNT(*) AS order_count,
    SUM(total_quantity) AS total_quantity,
    SUM(gross_order_amount) AS gross_order_amount,
    SUM(net_order_amount) AS net_order_amount,
    SUM(order_cost_amount) AS order_cost_amount,
    SUM(order_margin_amount) AS order_margin_amount
FROM clean.fact_orders;


/* =====================================================
Validate sales model row count after key-based FX join
Expected result:
clean.fact_sales and mart.vw_fact_sales_model should match
===================================================== */

SELECT 
    'clean.fact_sales' AS object_name,
    COUNT(*) AS row_count
FROM clean.fact_sales

UNION ALL

SELECT 
    'mart.vw_fact_sales_model' AS object_name,
    COUNT(*) AS row_count
FROM mart.vw_fact_sales_model;


/* =====================================================
Validate orders model row count after key-based FX join
Expected result:
expected_orders_model_rows and mart.vw_fact_orders_model should match
===================================================== */

SELECT 
    'expected_orders_model_rows' AS object_name,
    COUNT(*) AS row_count
FROM clean.fact_orders fo
LEFT JOIN clean.dim_order_rows dor
    ON fo.order_key = dor.order_key

UNION ALL

SELECT 
    'mart.vw_fact_orders_model' AS object_name,
    COUNT(*) AS row_count
FROM mart.vw_fact_orders_model;


/* =====================================================
Check missing FX rows in sales model
Expected result: 0
===================================================== */

SELECT 
    COUNT(*) AS missing_currency_exchange_rows
FROM mart.vw_fact_sales_model
WHERE exchange_rate_to_usd IS NULL;


/* =====================================================
Check missing FX rows in orders model
Expected result: 0
===================================================== */

SELECT 
    COUNT(*) AS missing_currency_exchange_rows
FROM mart.vw_fact_orders_model
WHERE exchange_rate_to_usd IS NULL;


/* =====================================================
Check duplicate currency exchange keys
Expected result: no rows returned
===================================================== */

SELECT
    currency_exchange_key,
    exchange_date,
    from_currency_code,
    to_currency_code,
    COUNT(*) AS duplicate_count
FROM clean.dim_currency_exchange
GROUP BY
    currency_exchange_key,
    exchange_date,
    from_currency_code,
    to_currency_code
HAVING COUNT(*) > 1;


/* =====================================================
Validate Online Store country handling
Expected result:
Online Store should have NULL country_name
Physical Store should have country_name populated
===================================================== */

SELECT
    store_type,
    country_name,
    COUNT(*) AS store_count
FROM clean.dim_stores
GROUP BY
    store_type,
    country_name
ORDER BY
    store_type,
    country_name;


/* =====================================================
Date range checks
Helps confirm the available reporting period
===================================================== */

SELECT
    MIN(full_date) AS min_date,
    MAX(full_date) AS max_date
FROM clean.dim_dates;

SELECT
    MIN(order_date) AS min_sales_order_date,
    MAX(order_date) AS max_sales_order_date
FROM clean.fact_sales;

SELECT
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date
FROM clean.fact_orders;
