CREATE TABLE IF NOT EXISTS raw_machines (
  machine_id TEXT,
  machine_name TEXT,
  machine_type TEXT,
  location TEXT,
  installation_date TEXT,
  status TEXT
);

CREATE TABLE IF NOT EXISTS raw_products (
  product_id TEXT,
  product_name TEXT,
  category TEXT,
  standard_cycle_time_minutes TEXT
);

CREATE TABLE IF NOT EXISTS raw_production_orders (
  order_id TEXT,
  machine_id TEXT,
  product_id TEXT,
  quantity_produced TEXT,
  quantity_target TEXT,
  production_date TEXT,
  start_time TEXT,
  end_time TEXT
);

CREATE TABLE IF NOT EXISTS raw_downtime_events (
  event_id TEXT,
  machine_id TEXT,
  downtime_reason TEXT,
  duration_minutes TEXT,
  event_timestamp TEXT
);

CREATE TABLE IF NOT EXISTS raw_quality_checks(
  check_id TEXT,
  order_id TEXT,
  defects_found TEXT,
  units_inspected TEXT,
  inspection_date TEXT,
  result TEXT
);