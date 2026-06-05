-- ----------------------------------------------------
-- KPI 1: Production Efficiency %
-- Measures how close production was to target.
-- ----------------------------------------------------

SELECT ROUND(SUM(quantity_produced::numeric) / SUM(quantity_target::numeric) * 100,2) AS average_efficiency
FROM production_orders;

-- ----------------------------------------------------
-- KPI 2: Machine Utilisation
-- Measures production output by machine.
-- ----------------------------------------------------

SELECT  machine_id,
        ROUND(SUM(quantity_produced::numeric) / SUM(quantity_target::numeric) * 100,2) AS production_efficiency_pct
FROM production_orders
GROUP BY machine_id
ORDER BY machine_id;

-- ----------------------------------------------------
-- KPI 3: Downtime % per month
-- Downtime Minutes / (Production Minutes + Downtime Minutes) * 100
-- ----------------------------------------------------

WITH downtime_per_day AS (
    SELECT  machine_id,
            event_timestamp,
            SUM(duration_minutes) AS downtime_minutes
    FROM downtime_events
    GROUP BY machine_id, event_timestamp
), orders_per_day AS (
    SELECT  machine_id,
            production_date,
            SUM(EXTRACT(EPOCH FROM (end_time - start_time)) / 60) AS production_minutes
    FROM production_orders
    GROUP BY machine_id, production_date
)
SELECT  DATE_TRUNC('month', dpd.event_timestamp),
        SUM(downtime_minutes) AS total_downtime,
        ROUND(SUM(production_minutes),0) AS total_production_time,
        ROUND(SUM(downtime_minutes) / SUM(production_minutes) * 100,2) AS downtime_percentage
FROM orders_per_day AS opd 
JOIN downtime_per_day AS dpd 
ON opd.machine_id = dpd.machine_id
    AND DATE(dpd.event_timestamp) = DATE(opd.production_date)
GROUP BY DATE_TRUNC('month', dpd.event_timestamp);


-- ----------------------------------------------------
-- KPI 4: Defect Rate %
-- Total Defects / Units Inspected * 100 
-- ----------------------------------------------------

SELECT ROUND(SUM(defects_found::numeric) / SUM(units_inspected::numeric) * 100, 2) AS defect_rate_percentage
FROM quality_checks;

-- ----------------------------------------------------
-- KPI 5: On-Target Order Rate %
-- Orders meeting target /Total Orders * 100
-- ----------------------------------------------------

SELECT  COUNT(CASE WHEN quantity_produced >= quantity_target THEN 1 END) AS orders_on_target,
        ROUND(COUNT(CASE WHEN quantity_produced >= quantity_target THEN 1 END)::numeric / COUNT(*) * 100, 2) AS on_target_order_percentage
FROM production_orders;