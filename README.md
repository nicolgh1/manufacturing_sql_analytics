# 🏭 Manufacturing SQL Analytics

A PostgreSQL-based data analytics project simulating a real-world manufacturing environment.  
The goal is to model production operations, machine performance, and quality outcomes using relational database design and analytical SQL.

---

## 📌 Project Overview

Modern manufacturing environments suffer from fragmented data spread across machines, spreadsheets, and legacy systems.  
This project simulates a unified operational database designed to answer key business questions such as:

- Which machines are most productive?
- Where are production bottlenecks occurring?
- What are the main causes of downtime?
- Which products have the highest defect rates?
- How efficient are production lines over time?

The focus is on **data modelling, SQL, and analytical thinking**, not application development.

---

## 🎯 Objectives

This project is designed to demonstrate:

- Relational database design (3NF principles)
- PostgreSQL schema creation
- Data modelling for real-world systems
- Complex SQL querying (joins, aggregates, CTEs)
- KPI development for operational analytics
- Business-oriented data thinking

---

## 🧱 Database Schema

The system is built around the following entities:

### Core Tables

- **machines** → Manufacturing equipment information
- **products** → Products being manufactured
- **categories** → Product classification system
- **production_orders** → Records of production runs
- **downtime_events** → Machine downtime tracking
- **downtime_reasons** → Standardised downtime classifications
- **quality_checks** → Quality inspection results

---

## 🔗 Data Model Relationships

- A machine can have many production orders
- A product can appear in many production orders
- A production order can have one or many quality checks
- A machine can generate multiple downtime events
- Downtime events are linked to standardized reason categories
- Products belong to defined categories

---

## 🛠️ Tech Stack

- PostgreSQL (database)
- SQL (data modelling + analytics)
- VS Code (development environment)
- WSL (Linux subsystem for database runtime)

---

## 📁 Project Structure
manufacturing-sql-analytics/
│
├── db/
│ └── schema.sql # Database schema (CREATE TABLE statements)
│
├── data/
│ └── raw/ # CSV datasets (simulated production data)
│
├── queries/
│ ├── business_questions.sql # Basic operational queries
│ ├── kpis.sql # Key performance indicators
│ └── analysis.sql # Advanced analytical queries
│
├── docs/
│ ├── schema_diagram.png # ER diagram
│ └── data_dictionary.md # Table descriptions
│
├── notes/
│ └── design_decisions.md # Schema design rationale
│
└── README.md

## 📊 Example Business Questions

This database is designed to answer:

### Production Performance
- Which machine produces the highest output?
- Which products have the highest throughput?
- How does production vary over time?

### Machine Efficiency
- Which machines have the highest downtime?
- What is the most common downtime reason?
- What is machine utilisation rate?

### Quality Control
- Which products have the highest defect rate?
- Which production orders fail inspection most often?
- What percentage of output is defective?

## 📈 Example KPIs

- Machine utilisation rate
- Production efficiency vs target
- Downtime percentage per machine
- Defect rate per product
- Output per machine per day


## 📚 Key Learning Outcomes

Through this project, I am developing:

- Strong understanding of relational database design
- Ability to translate business problems into SQL queries
- Experience with analytical thinking using structured data
- Understanding of data normalization and schema design
- Foundational skills for backend and data engineering roles

## 🧠 Future Improvements

After completing the SQL version, this project can be extended into:

- Python-based ETL pipeline
- FastAPI backend service
- Dashboard (Power BI / React)
- Real-time data simulation layer

## 👤 Author

Built as part of a learning journey transitioning into backend/data engineering, with a focus on SQL, systems thinking, and real-world data modelling.