\copy raw_machines FROM 'data/raw/machines.csv' CSV HEADER;

\copy raw_products FROM 'data/raw/products.csv' CSV HEADER;

\copy raw_production_orders FROM 'data/raw/production_orders.csv' CSV HEADER;

\copy raw_downtime_events FROM 'data/raw/downtime_events.csv' CSV HEADER;

\copy raw_quality_checks FROM 'data/raw/quality_checks.csv' CSV HEADER;