# Data Warehouse & Analytics Project: SQL Server Implementation

## 🎯 Project Overview

This project demonstrates the design and implementation of a **Modern Data Warehouse** using SQL Server, adhering to industry best practices in data engineering and analytics. The core objective is to transform raw data from disparate source systems (CRM and ERP) into reliable, structured, and business-ready information optimized for Business Intelligence (BI).

---

## 🏗️ Data Architecture: The Medallion Approach

The solution is built upon the **Medallion Architecture**, providing robust quality control and governance across the data lifecycle:

| Layer | Role | Description |
| :--- | :--- | :--- |
| **Bronze** | **Raw Data Ingestion** | Stores raw, immutable, and unmodified data ingested directly from source CSV files (ERP & CRM). |
| **Silver** | **Data Cleansing & Standardization** | Contains cleaned, standardized, de-duplicated, and integrated data. This layer resolves data quality issues and prepares data for modeling. |
| **Gold** | **Business-Ready Data** | Data is organized into a **Star Schema** (Fact and Dimension Views), optimized for performance, intuitive querying, and analytical reporting. |

---

## 🔧 Key Components & Technology

| Component | Description | Technologies / Files |
| :--- | :--- | :--- |
| **ETL Pipelines** | Stored Procedures (`load_`) responsible for the Extract, Transform, and Load process, moving data incrementally between the Bronze, Silver, and Gold layers. | `scripts/proc_load_*.sql` |
| **Data Modeling** | Implementation of **Fact Views** (e.g., sales) and **Dimension Views** (e.g., customers, products) to enable efficient aggregation and analysis. | `scripts/ddl_gold.sql` |
| **Data Quality** | Scripts designed to validate primary key integrity, check data consistency (e.g., `Sales = Quantity * Price`), and confirm standardization post-transformation. | `tests/` |
| **Naming Conventions** | Strict adherence to predefined conventions (`snake_case`, `dim_`, `fact_`, `dwh_` prefixes) for object clarity and maintainability. | `docs/` |



## 🚀 Getting Started

1.  **Environment Setup:** Ensure you have access to a **SQL Server** instance (or Azure SQL Database) and SSMS.
2.  **Schema Creation:** Create the three necessary schemas in your database: `bronze`, `silver`, and `gold`.
3.  **Load DDL:** Execute `scripts/ddl_bronze.sql` and `scripts/ddl_silver.sql` to create the foundational tables.
4.  **Run ETL:** Update the CSV file paths in `scripts/proc_load_bronze.sql` and execute the Stored Procedures sequentially:
    1.  `EXEC bronze.load_bronze;`
    2.  `EXEC silver.load_silver;`
    3.  Execute `scripts/ddl_gold.sql` to finalize the analytical views.
5.  **Validate:** Run the scripts in the `tests/` folder to confirm data quality before consumption.
