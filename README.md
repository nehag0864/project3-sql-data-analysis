# Project 3: SQL Data Analysis
**DecodeLabs Industrial Training Kit | Batch 2026**

## 📌 Overview
This project is part of the DecodeLabs Data Analytics Internship (Project 3 — SQL Data Analysis).
The goal is to use SQL queries to extract insights from a relational dataset by writing `SELECT`
statements, filtering with `WHERE`, sorting with `ORDER BY`, grouping with `GROUP BY`, and
performing aggregations (`COUNT`, `SUM`, `AVG`).

The dataset simulates an **Online Retail Store**, with customers, products, orders, and order
line items — a realistic scenario for practicing business intelligence queries.

## 🎯 Objective
Bridge the gap between raw, massive datasets and specific, actionable answers using pure
relational (SQL) logic — filtering, grouping, and aggregating data into business insights.

## 🗂️ Repository Structure
```
project3-sql-data-analysis/
├── README.md
├── database/
│   ├── schema.sql          # Table definitions (DDL)
│   └── sample_data.sql     # Sample records (DML)
└── queries/
    └── analysis_queries.sql # All analysis queries (SELECT, WHERE, GROUP BY, HAVING, etc.)
```

## 🧩 Database Schema (ERD Summary)
- **customers** (customer_id, customer_name, city, signup_date)
- **products** (product_id, product_name, category, price)
- **orders** (order_id, customer_id, order_date, status)
- **order_items** (order_item_id, order_id, product_id, quantity)

Relationships:
- One customer → many orders
- One order → many order_items
- One product → many order_items

## ⚙️ How to Run
### Option 1: SQLite (quickest, no setup)
```bash
sqlite3 store.db < database/schema.sql
sqlite3 store.db < database/sample_data.sql
sqlite3 store.db < queries/analysis_queries.sql
```

### Option 2: MySQL / PostgreSQL
```bash
mysql -u root -p your_db_name < database/schema.sql
mysql -u root -p your_db_name < database/sample_data.sql
mysql -u root -p your_db_name < queries/analysis_queries.sql
```
> Note: Query 12 (monthly trend) uses SQLite's `strftime()`. For MySQL use
> `DATE_FORMAT(order_date, '%Y-%m')`; for PostgreSQL use `TO_CHAR(order_date, 'YYYY-MM')`.

## 🔍 What the Queries Cover
| # | Query | SQL Concept |
|---|-------|-------------|
| 1 | High-priced products | `SELECT`, `WHERE`, `ORDER BY` |
| 2 | Cancelled orders | `WHERE` (equality) |
| 3 | Delhi-based customers | `WHERE ... LIKE` |
| 4 | Recent orders | `ORDER BY DESC` |
| 5 | Orders per status | `GROUP BY`, `COUNT()` |
| 6 | Units sold per product | `JOIN`, `SUM()` |
| 7 | Avg order value per customer | `JOIN`, `AVG()` |
| 8 | High-volume categories | `GROUP BY`, `HAVING` |
| 9 | Revenue per category | `SUM()`, multi-table `JOIN` |
| 10 | % revenue contribution | Subquery + aggregation |
| 11 | Top 5 customers by orders | `GROUP BY`, `LIMIT` |
| 12 | Monthly order trend | `GROUP BY` on date |

## 🧠 Key Learnings
- SQL is **declarative** — you describe the result you want; the engine decides how to fetch it.
- The **logical execution order** differs from how a query is written:
  `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`
- Because `WHERE` runs before `SELECT`, column aliases defined in `SELECT` cannot be used in
  `WHERE` (the "alias trap").
- `COUNT(*)` includes `NULL`s; `SUM()` and `AVG()` ignore them — important to watch for skewed
  results.

## 👤 Author
Nehaaa — Manav Rachna University
Data Analytics Intern, DecodeLabs (Batch 2026)

## 🙏 Acknowledgment
This project was completed as part of the **DecodeLabs Industrial Training Kit**.
📧 decodelabs.tech@gmail.com | 🌐 www.decodelabs.tech
