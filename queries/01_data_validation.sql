-- ------------------------------------------------
-- Validation raw tables
-- ------------------------------------------------

-- Checking tables load; Result - all loaded 
SELECT COUNT(*) AS all_machines FROM raw_machines;
SELECT COUNT(*) AS all_downtime FROM raw_downtime_events;
SELECT COUNT(*) AS all_orders FROM raw_production_orders;
SELECT COUNT(*) AS all_products FROM raw_products;
SELECT COUNT(*) AS all_checks FROM raw_quality_checks;

-- raw_machines dataset --

-- Checking for missing data; Result - none 
SELECT COUNT(*) AS machines_missing_data
FROM raw_machines 
WHERE machine_id IS NULL 
OR machine_name IS NULL 
OR machine_type IS NULL 
OR location IS NULL 
OR installation_date IS NULL 
OR status IS NULL;

-- Checking for duplicate machine_id; Result - none 
SELECT COUNT(*) AS machines_duplicates
FROM
    (SELECT machine_id
    FROM raw_machines
    GROUP BY machine_id
    HAVING COUNT(*) > 1) as sub;

--raw_product dataset --

--check for missing values; Result - none
SELECT COUNT(*) as products_missing_data
FROM raw_products
WHERE product_id IS NULL
OR product_name IS NULL 
OR category IS NULL 
OR standard_cycle_time_minutes IS NULL;

-- Checking for duplicate product_id; Result - none 
SELECT COUNT(*) AS products_duplicates
FROM
    (SELECT  product_id
    FROM raw_products
    GROUP BY product_id
    HAVING COUNT(*) > 1) AS sub;

-- raw_production_orders dataset --
--check for missing values; Result - none

SELECT COUNT(*) as orders_missing_data
FROM raw_production_orders
WHERE order_id IS NULL
OR machine_id IS NULL
OR product_id IS NULL
OR quantity_produced IS NULL
OR quantity_target IS NULL
OR production_date IS NULL
OR start_time IS NULL
OR end_time IS NULL;

-- checking impossible values; Result - none
SELECT COUNT(*) AS orders_impossible_values
FROM raw_production_orders
WHERE quantity_produced::integer < 0
OR quantity_target::integer < 0;

-- checking connection to machines table; Result - none
SELECT COUNT(*) AS orders_machine_key_missing
FROM raw_production_orders
WHERE machine_id NOT IN (SELECT machine_id FROM raw_machines);

-- checking connection to the products table; Result - none
SELECT COUNT(*) AS orders_products_key_missing
FROM raw_production_orders
WHERE product_id NOT IN (SELECT product_id FROM raw_products);

-- raw_downtime_events dataset --

--check for missing values; Result - none
SELECT COUNT(*) as downtime_missing_values
FROM raw_downtime_events
WHERE event_id IS NULL
OR machine_id IS NULL
OR downtime_reason IS NULL
OR duration_minutes IS NULL
OR event_timestamp IS NULL;

--checking impossible values; Result - none

SELECT COUNT(*) as downtime_impossible_values
FROM raw_downtime_events
WHERE duration_minutes::integer < 0;

-- raw_quality_checks dataset --

--check for missing values; Result - none
SELECT COUNT(*) AS checks_missing_values
FROM raw_quality_checks
WHERE check_id IS NULL
OR order_id IS NULL
OR defects_found IS NULL
OR units_inspected IS NULL
OR inspection_date IS NULL
OR result IS NULL;

--checking impossible values; Result - none
SELECT COUNT(*) AS checks_impossible_values
FROM raw_quality_checks
WHERE units_inspected::integer < 0
OR result NOT IN ('Pass','Fail');

--checking connection to orders; Result - none 

SELECT COUNT(*) AS checks_missing_orders
FROM raw_quality_checks
WHERE order_id NOT IN (
    SELECT order_id FROM raw_production_orders
);

-- --------------------------------------------
--DATA SUMMARY 
-- --------------------------------------------

SELECT ROUND(AVG(quantity_produced::INTEGER),2) AS avg_produced,
        MIN(quantity_produced::INTEGER) AS min_produced,
        MAX(quantity_produced::INTEGER) AS max_produced
FROM raw_production_orders;

-- =========================
-- DATA QUALITY RESULT
-- =========================
-- machines: PASS (0 issues)
-- products: PASS (0 issues)
-- orders: PASS (0 issues)
-- downtime: PASS (0 issues)
-- quality_checks: PASS (0 issues)

-- ------------------------------------------------
-- Validation clean tables
-- ------------------------------------------------

--Dimentions tables--

SELECT COUNT(*) AS all_clean_categories FROM categories;
SELECT COUNT(*) AS all_clean_dt_reasons FROM downtime_reasons;
SELECT COUNT(*) AS all_clea_machines FROM machines;
SELECT COUNT(*) AS all_clea_products FROM products; 

SELECT COUNT(*)  AS prod_missing_category
FROM products 
WHERE category_id IS NULL;

-- Facts tables ---
SELECT COUNT(*) AS all_clean_orders FROM production_orders;
SELECT COUNT(*) AS all_clean_dt_events FROM downtime_events;
SELECT COUNT(*) AS all_clean_checks FROM quality_checks;

SELECT COUNT(*)
FROM downtime_events
WHERE reason_id IS NULL;