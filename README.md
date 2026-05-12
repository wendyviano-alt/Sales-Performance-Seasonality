# Sales Performance & 2023 Seasonality Analysis
## Internship Context

This project was completed during my internship at ACA Group as part of my data analytics and business intelligence learning experience. The goal of the project was to practice building a full analytics workflow using SQL Server, Power BI, DAX, and Python.

During the internship, I worked on cleaning and organizing sales data, building a structured data model, creating business-focused Power BI dashboards, and using Python to add a forecasting component. The project helped me apply data analysis skills to a real business-style scenario focused on sales performance, customer behavior, product profitability, regional performance, and seasonality.

The dashboard demonstrates my ability to clean data, build a data model, create Power BI reports, write DAX measures, and add Python forecasting to support business analysis.

## Project Overview

This project analyzes sales performance using SQL Server, Power BI, DAX, and Python. It was completed during my internship at ACA Group and focuses on turning raw sales data into a structured business intelligence dashboard.

The main goal was to understand overall business performance and then investigate a pattern discovered during the analysis: in 2023, February generated the highest sales while April generated the lowest sales.

I built a full sales analytics dashboard. While analyzing 2023 sales, I discovered February had the highest sales and April had the lowest. Then I investigated why.

The analysis focuses on identifying whether the difference between February and April was caused by customer volume, order volume, average order value, pricing, discounts, product demand, store channel performance, or regional behavior.

## Business Question

While analyzing monthly sales trends, February 2023 stood out as the strongest sales month, while April 2023 was the weakest.

The main business question became:

**Why did February 2023 generate the highest sales, and why did April 2023 generate the lowest sales?**

To answer this, the dashboard investigates:

- Did February have more customers than April?
- Did February have more orders?
- Were customers spending more per order?
- Did prices drop in February?
- Were discounts higher in February?
- Did certain products or categories drive the increase?
- Did online or physical stores perform differently?
- Were specific countries or regions responsible for the difference?

---

## Tools Used

- **SQL Server** — data cleaning, restructuring, and creation of analytical views
- **Power BI** — data modeling, relationships, dashboard design, and reporting
- **DAX** — KPI measures, sales metrics, margin calculations, and customer metrics
- **Python** — forecasting inside Power BI
- **Pandas** — data preparation for forecasting
- **Matplotlib** — Python forecast visualizations
- **Statsmodels / SARIMA** — time-series forecasting

---

## Data Pipeline

The raw data was first organized in SQL Server before being imported into Power BI.

```text
Raw Data
   ↓
SQL Server Cleaning Views
   ↓
Power BI Data Model
   ↓
DAX Measures
   ↓
Dashboard Visuals
   ↓
Python Forecasting
