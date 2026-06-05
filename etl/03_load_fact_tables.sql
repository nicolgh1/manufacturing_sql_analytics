INSERT INTO production_orders (
    order_id,
    machine_id,
    product_id,
    quantity_produced,
    quantity_target,
    production_date,
    start_time,
    end_time
)
SELECT  TRIM(order_id),
        TRIM(machine_id),
        TRIM(product_id),
        quantity_produced::INT,
        quantity_target::INT,
        production_date::TIMESTAMP,
        start_time::TIME,
        end_time::TIME
FROM raw_production_orders;

INSERT INTO downtime_events (
    event_id,
    machine_id,
    reason_id,
    duration_minutes,
    event_timestamp
)
SELECT  TRIM(r.event_id),
        TRIM(r.machine_id),
        dr.reason_id,
        r.duration_minutes::INT,
        r.event_timestamp::TIMESTAMP
FROM raw_downtime_events AS r
JOIN downtime_reasons AS dr 
ON r.downtime_reason = dr.downtime_reason;

INSERT INTO quality_checks (
    check_id,
    order_id,
    defects_found,
    units_inspected,
    inspection_date,
    result
)
SELECT  TRIM(check_id),
        TRIM(order_id),
        defects_found::INT,
        units_inspected::INT,
        inspection_date::TIMESTAMP,
        TRIM(result)
FROM raw_quality_checks;