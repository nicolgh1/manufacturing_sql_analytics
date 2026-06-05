INSERT INTO categories (category_name)
SELECT DISTINCT category 
FROM raw_products;

INSERT INTO downtime_reasons (downtime_reason)
SELECT DISTINCT downtime_reason
FROM raw_downtime_events;

INSERT INTO machines(
    machine_id,
    machine_name,
    machine_type,
    location,
    installation_date,
    status
)
SELECT DISTINCT 
    TRIM(machine_id),
    TRIM(machine_name),
    TRIM(machine_type),
    TRIM(location),
    installation_date::timestamp,
    status
FROM raw_machines; 

INSERT INTO products (
    product_id,
    product_name,
    category_id,
    standard_cycle_time_minutes
)
SELECT DISTINCT 
    TRIM(rp.product_id),
    TRIM(rp.product_name),
    c.category_id,
    rp.standard_cycle_time_minutes::integer
FROM raw_products AS rp
JOIN categories AS c
ON rp.category = c.category_name
