# 🏭 Manufacturing SQL Analytics (End-to-End Data Engineering Project)

## ⚙️ What This Project Demonstrates

This project simulates a real-world manufacturing data warehouse and demonstrates a complete analytics engineering workflow:

**Raw CSV Data → Staging Tables → Data Validation → Transformation Layer → Fact Tables → KPI Analytics Layer**

It is designed to showcase SQL, data modelling, ETL design, and analytical thinking using PostgreSQL.

---

# 📌 Project Overview

Modern manufacturing environments generate data across machines, production systems, and quality control processes. This data is often fragmented and inconsistent.

This project builds a unified relational database that enables analysis of:

* Production performance
* Machine efficiency
* Downtime analysis
* Product quality
* Operational KPIs

The focus is on **data engineering, SQL, and analytical modelling**, not application development.

---

# 🎯 Objectives

This project demonstrates:

* End-to-end ETL pipeline design using SQL
* Relational database design (3NF principles)
* Data cleaning and validation strategies
* Fact and dimension modelling concepts
* Complex analytical SQL (joins, CTEs, aggregations)
* KPI design for operational reporting
* Real-world data debugging and transformation

---

# 🔄 ETL Pipeline

This project implements a full SQL-based ETL workflow:

## 1. Staging Layer

Raw CSV files are loaded into staging tables (`raw_*`) without transformation.

## 2. Data Validation Layer

Data quality checks ensure reliability of downstream analytics:

* Missing values detection
* Duplicate record detection
* Referential integrity checks
* Business rule validation (e.g. negative values, invalid categories)
* Data consistency checks across datasets

## 3. Transformation Layer

Raw data is transformed into analytics-ready dimensions:

* Product categories extracted and standardised
* Downtime reasons normalised
* Machine and product dimension tables populated
* Data type cleaning and formatting applied

## 4. Fact Table Loading

Cleaned and validated data is loaded into core operational tables:

* production_orders
* downtime_events
* quality_checks

---

# 🧱 Database Schema

## Core Tables

* **machines** → Manufacturing equipment metadata
* **products** → Product catalog
* **categories** → Product classification system
* **production_orders** → Production execution records
* **downtime_events** → Machine downtime tracking
* **downtime_reasons** → Standardised failure reasons
* **quality_checks** → Inspection and defect tracking

---

# 🔗 Data Model Relationships

* Machines generate many production orders
* Products belong to categories
* Production orders link machines and products
* Production orders have quality checks
* Machines generate downtime events
* Downtime events reference standardised reasons

---

# 🛠️ Tech Stack

* PostgreSQL (database engine)
* SQL (ETL + analytics)
* WSL (Linux environment)
* VS Code (development)

---

# 📁 Project Structure

```

manufacturing-sql-analytics/
│
├── db/
│   └── schema.sql                  # Database schema
│   └── stg_schema.sql              # Stage Database schema
│
├── data/
│   └── raw/                        # Raw CSV datasets
│
├── etl/
│   ├── 00_reset.sql               # Reset database
│   ├── 01_load_csv.sql            # Load raw data into staging
│   ├── 02_transform_dimensions.sql# Build dimension tables
│   ├── 03_load_fact_tables.sql    # Load fact tables
│   └── validation.sql             # Data quality checks
│
├── queries/
│   ├── 01_data_validation.sql     # Data quality checks
│   ├── 02_business_questions.sql  # Operational analytics queries
│   └── 03_kpis.sql                # KPI definitions
│   
│
├── docs/
│   └── schema_diagram.png
│  
│
└── README.md

```

---

# 📊 Business Questions Answered

## Production Performance

* Which machine produces the most units?
* Which products are produced most frequently?
* Which production days have highest output?

## Machine Efficiency

* Which machines have the highest downtime?
* What are the most common downtime reasons?
* Which machines are most/least efficient?

## Quality Control

* Which products have the highest defect rates?
* Which production orders fail inspection?
* What is the overall defect rate?

## Operational Performance

* Which machines are most productive vs target?
* What is overall production efficiency?
* How consistent is production over time?

---

# 📈 KPI Layer

This project implements core manufacturing KPIs:

* Production efficiency (% actual vs target)
* Machine throughput (output volume)
* Downtime percentage (availability metric)
* Defect rate (quality metric)
* On-target production rate (schedule reliability)

These KPIs are calculated using SQL aggregations and reflect real-world manufacturing performance monitoring.

---

# 🧠 Data Engineering Skills Demonstrated

* SQL-based ETL pipeline design
* Data validation and quality assurance frameworks
* Schema design and relational modelling
* Fact and dimension table architecture
* Handling real-world messy data (timestamps, duplicates, FK issues)
* KPI design and operational analytics
* Debugging and iterative database development

---

# 📚 Key Learning Outcomes

Through this project, I developed:

* Strong understanding of relational databases
* Ability to build ETL pipelines using SQL only
* Practical experience with data validation strategies
* Analytical thinking for business KPI design
* Confidence in debugging data engineering workflows

---

# 🚀 Future Improvements

This project can be extended into:

* Python-based ETL pipeline (Airflow or scripts)
* FastAPI backend service
* Power BI / Tableau dashboard
* Real-time data ingestion simulation
* Materialized views for performance optimisation

---

# 👤 Author

Built as part of a learning journey into backend and data engineering, with a focus on SQL systems, analytics engineering, and real-world data modelling.
