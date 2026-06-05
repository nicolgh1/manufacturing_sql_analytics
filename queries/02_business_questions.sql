-- --------------------------------------------------------
--BUSINESS QUESTIONS 
-- --------------------------------------------------------

--1. Which machine produced the most units?

SELECT  machine_id,
        SUM(quantity_produced) AS total_qty_produced
FROM production_orders
GROUP BY machine_id
ORDER BY SUM(quantity_produced) DESC
LIMIT 1;

-- Which products are produced most frequently?

SELECT  po.product_id,
        p.product_name,
        SUM(po.quantity_produced) AS total_qty_produced,
        COUNT(*) AS no_orders
FROM production_orders AS po
LEFT JOIN products AS p 
ON po.product_id = p.product_id
GROUP BY po.product_id, p.product_name
ORDER BY no_orders DESC;

-- 3. Which production days generated the highest output?

SELECT  production_date,
        SUM(quantity_produced) AS total_produced
FROM production_orders
GROUP BY production_date
ORDER BY SUM(quantity_produced) DESC
LIMIT 1;

-- 4. Which machine achieved the highest average production per order?

SELECT  machine_id,
        ROUND(AVG(quantity_produced),2) AS avg_qty_per_order
FROM production_orders
GROUP BY machine_id
ORDER BY AVG(quantity_produced) DESC
LIMIT 1;

-- 5. Which products consistently miss production targets?

SELECT  product_id,
        COUNT(*) AS total_orders,
        COUNT(CASE WHEN quantity_produced < quantity_target THEN 1 END) AS missed_targets,
        ROUND(COUNT(CASE WHEN quantity_produced < quantity_target THEN 1 END)::numeric / COUNT(*) * 100,2) AS perc_failed
FROM production_orders
GROUP BY product_id
ORDER BY missed_targets DESC;

-- 6. Which machine experienced the most downtime?

SELECT  machine_id,
        COUNT(event_id) AS no_downtime_events,
        SUM(duration_minutes) AS total_downtime_minutes
FROM downtime_events
GROUP BY machine_id
ORDER BY no_downtime_events DESC, total_downtime_minutes DESC
LIMIT 1;

-- 7. What are the most common downtime reasons?

SELECT  dr.downtime_reason,
        COUNT(*) AS no_downtime_events
FROM downtime_events AS de 
LEFT JOIN downtime_reasons AS dr 
ON de.reason_id = dr.reason_id
GROUP BY de.reason_id, dr.downtime_reason
ORDER BY no_downtime_events DESC
LIMIT 3;

-- 8. Which machine has the highest average downtime event duration?

SELECT  machine_id,
        ROUND(AVG(duration_minutes),2) AS avg_duration
FROM downtime_events
GROUP BY machine_id
ORDER BY avg_duration DESC;

-- 9. How much downtime occurred each month?

SELECT  DATE_TRUNC('month', event_timestamp) AS month,
        SUM(duration_minutes)
FROM downtime_events
GROUP BY DATE_TRUNC('month', event_timestamp)
ORDER BY month ASC;

-- 10. Which machines suffer from the widest variety of downtime causes?

SELECT machine_id,
        COUNT(DISTINCT reason_id) AS no_dt_causes
FROM downtime_events
GROUP BY machine_id
ORDER BY no_dt_causes DESC;

-- 11. Which products have the highest defect rates?

SELECT  po.product_id,
        p.product_name,
        SUM(defects_found) /SUM(units_inspected) AS defect_rate,
FROM quality_checks AS qc 
LEFT JOIN production_orders AS po 
ON qc.order_id = po.order_id
LEFT JOIN products AS p 
ON p.product_id = po.product_id
GROUP BY po.product_id,p.product_name
ORDER BY total_defects DESC
LIMIT 3;

-- 12. Which production orders failed inspection?

SELECT order_id
FROM quality_checks
WHERE result = 'Fail'
LIMIT 5;

-- 13. Which machines produce the most defects?

SELECT  po.machine_id,
        SUM(defects_found)/ SUM(units_inspected) AS defect_rate
FROM quality_checks AS qc
LEFT JOIN production_orders AS po 
ON qc.order_id = po.order_id
GROUP BY po.machine_id
ORDER BY no_defects DESC
LIMIT 3;

-- 14. What percentage of inspections fail?

SELECT  COUNT(CASE WHEN result = 'Fail' THEN 1 END) no_fails,
        ROUND(COUNT(CASE WHEN result = 'Fail' THEN 1 END)::numeric / COUNT(*) * 100,2) as perc_fail
FROM quality_checks;

-- 15. Which product categories have the highest defect rates?

SELECT  c.category_name,
        COUNT(*) FILTER (WHERE qc.result = 'Fail') AS failed_checks,
        ROUND(COUNT(*) FILTER (WHERE qc.result = 'Fail')::numeric / SUM(COUNT(*) FILTER (WHERE qc.result = 'Fail')) OVER() * 100,2) AS defect_perc
FROM quality_checks AS qc 
LEFT JOIN production_orders AS po 
ON qc.order_id = po.order_id
LEFT JOIN products AS p 
ON p.product_id = po.product_id
LEFT JOIN categories AS c 
ON c.category_id = p.category_id
GROUP BY c.category_name