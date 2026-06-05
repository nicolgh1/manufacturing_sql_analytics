\copy raw_machines FROM '/home/gabs123/portofolio-projects/manufacturing_sql_analytics/data/raw/machines.csv' CSV HEADER;

\copy raw_products FROM '/home/gabs123/portofolio-projects/manufacturing_sql_analytics/data/raw/products.csv' CSV HEADER;

\copy raw_production_orders FROM '/home/gabs123/portofolio-projects/manufacturing_sql_analytics/data/raw/production_orders.csv' CSV HEADER;

\copy raw_downtime_events FROM '/home/gabs123/portofolio-projects/manufacturing_sql_analytics/data/raw/downtime_events.csv' CSV HEADER;

\copy raw_quality_checks FROM '/home/gabs123/portofolio-projects/manufacturing_sql_analytics/data/raw/quality_checks.csv' CSV HEADER;