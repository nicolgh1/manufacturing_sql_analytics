DROP TABLE IF EXISTS quality_checks;
DROP TABLE IF EXISTS downtime_events;
DROP TABLE IF EXISTS production_orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS machines;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS downtime_reasons;

CREATE TABLE IF NOT EXISTS machines (
  machine_id char(10) PRIMARY KEY,
  machine_name varchar NOT NULL,
  machine_type varchar NOT NULL,
  location varchar NOT NULL,
  installation_date timestamp NOT NULL,
  status varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
  category_id serial PRIMARY KEY,
  category_name varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
  product_id char(10) PRIMARY KEY,
  product_name varchar NOT NULL,
  category_id integer NOT NULL REFERENCES categories(category_id),
  standard_cycle_time_minutes integer NOT NULL
);

CREATE TABLE IF NOT EXISTS production_orders (
  order_id char(10) PRIMARY KEY,
  machine_id char(10) NOT NULL REFERENCES machines(machine_id),
  product_id char(10) NOT NULL REFERENCES products(product_id),
  quantity_produced integer NOT NULL,
  quantity_target integer NOT NULL,
  production_date date NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL
);

CREATE TABLE IF NOT EXISTS downtime_reasons (
  reason_id serial PRIMARY KEY,
  downtime_reason varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS downtime_events (
  event_id char(10) PRIMARY KEY,
  machine_id char(10) NOT NULL REFERENCES machines(machine_id),
  reason_id integer NOT NULL REFERENCES downtime_reasons(reason_id),
  duration_minutes integer NOT NULL,
  event_timestamp timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS quality_checks(
  check_id char(10) PRIMARY KEY,
  order_id char(10) NOT NULL REFERENCES production_orders(order_id),
  defects_found integer NOT NULL,
  units_inspected integer NOT NULL,
  inspection_date timestamp NOT NULL,
  result varchar NOT NULL
);


