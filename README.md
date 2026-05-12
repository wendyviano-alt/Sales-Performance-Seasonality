# Sales Performance & 2023 Seasonality Analysis

## Internship Context

This project was completed during my internship at ACA Group as part of my data analytics and business intelligence learning experience. The goal of the project was to practice building a full analytics workflow using SQL Server, Power BI, DAX, and Python.

During the internship, I worked on cleaning and organizing sales data, building a structured data model, creating business-focused Power BI dashboards, and using Python to add a forecasting component. The project helped me apply data analysis skills to a real business-style scenario focused on sales performance, customer behavior, product profitability, regional performance, and seasonality.

The dashboard demonstrates my ability to clean data, build a data model, create Power BI reports, write DAX measures, and add Python forecasting to support business analysis.


## Project Overview

This project analyzes sales performance using SQL Server, Power BI, DAX, and Python. It was completed during my internship at ACA Group and focuses on turning raw sales data into a structured business intelligence dashboard.

The main goal was to understand overall business performance and then investigate a pattern discovered during the analysis: in 2023, February generated the highest sales while April generated the lowest sales.

I built a full sales analytics dashboard. While analyzing 2023 sales, I discovered that February had the highest sales and April had the lowest. Then I investigated why.

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


## Tools Used

- **SQL Server** — data cleaning, restructuring, and creation of analytical views
- **Power BI** — data modeling, relationships, dashboard design, and reporting
- **DAX** — KPI measures, sales metrics, margin calculations, and customer metrics
- **Python** — forecasting inside Power BI
- **Pandas** — data preparation for forecasting
- **Matplotlib** — Python forecast visualizations
- **Statsmodels / SARIMA** — time-series forecasting


## Data Pipeline

The raw data was first organized in SQL Server before being imported into Power BI.

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


Instead of connecting Power BI directly to raw tables, I created cleaned SQL views first. This helped keep the reporting layer organized and made the dashboard easier to analyze, maintain, and explain.


## Data Model

The data was structured into a fact and dimension model to make the analysis easier to manage in Power BI.

### Fact Tables

- `fact_sales`
- `fact_orders`

### Dimension Tables

- `dim_customers`
- `dim_product`
- `dim_stores`
- `dim_dates`
- `dim_currency_exchange`
- `dim_order_rows`

This model allowed me to analyze sales by month, customer segment, product category, store type, country, and profitability.


## Dashboard Story

The report was designed as a guided business investigation. It starts with overall business performance, then moves into the 2023 sales pattern, then investigates why February performed the best and April performed the worst.


### 1. Executive KPI Overview

The first page provides a high-level view of business performance.

It includes:

- Total Sales USD
- Total Margin USD
- Margin %
- Total Orders
- Total Customers
- Average Order Value

This page gives a quick view of business health before moving into the deeper monthly sales investigation.

![Executive KPI Overview](Screenshots/Executive%20KPI%20Overview.png)


### 2. Sales Trend Discovery

This page focuses on discovering the 2023 monthly sales pattern.

While reviewing sales by month, February stood out as the highest sales month, while April stood out as the lowest sales month.

This discovery changed the project from a general dashboard into a deeper investigation.

![Sales Trend Discovery](Screenshots/Sales%20Trend%20Discovery.png)


### 3. 2023 Peak vs Low Month Investigation

This page compares the strongest sales months against April to understand what was driving the difference.

The analysis compares:

- Customer volume
- Order volume
- Average order value
- Average net price
- Average discount
- Store channel performance

The strongest months had much higher customer and order volume than April. However, average order value, net price, and discount levels stayed relatively stable.

This suggests that February’s stronger performance was driven more by customer demand and sales volume than by pricing or discounts.

![2023 Peak vs Low Month Investigation](Screenshots/2023%20Peak%20vs%20Low%20Month%20Investigation.png)



### 4. Customer Insights & Targeting

After identifying customer and order volume as major drivers, this page analyzes which customer segments contributed most to sales.

The page looks at:

- Sales by age group
- Product categories purchased by age group
- Sales by gender
- Customer count by country
- Average spend by customer segment

The analysis showed that the 50+ age group was the strongest customer segment.

![2023 Customer Insights & Targeting](Screenshots/2023%20Customer%20Insights%20%26%20Targeting.png)



### 5. Product Sales & Profitability

The product analysis focuses on understanding which products, categories, and product colors contributed to sales performance.

This part of the dashboard helps answer:

- Which products generated the most sales?
- Which products sold the most by quantity?
- Which products had the strongest margin?
- Did product color influence sales performance?
- Did product demand change between strong and weak months?

The purpose of this page is not only to identify top-selling products, but also to understand whether those products are profitable and worth focusing on.

A high-selling product is not always the best product to promote if the cost is high or the margin is weak. For that reason, the analysis compares sales, cost, margin, quantity sold, and product performance over time.



### 6. Regional & Store Performance

The regional and store performance analysis focuses on where sales came from and whether sales performance was driven by online or physical store activity.

This part of the dashboard helps answer:

- Did online or physical stores drive stronger sales months?
- Which countries generated the most physical store sales?
- Were high-sales countries also profitable?
- Was April’s low performance isolated to one region or broader across channels?

Online sales were analyzed separately because online is a sales channel, not a physical country.

This helped determine whether April’s lower performance was a regional issue, a channel issue, or part of a broader demand pattern.



### 7. 2023 Seasonality Findings

This page summarizes the main findings from the 2023 sales pattern.

The key takeaway is that February had the highest sales and April had the lowest sales mainly because of differences in customer and order volume.

Pricing, discounts, and average order value did not change enough to explain the gap by themselves.

![2023 Seasonality Findings](Screenshots/2023%20Seasonality%20Findings.png)



### 8. Sales Forecast

The final analytical page adds forecasting using Python inside Power BI.

The forecast estimates future monthly sales, orders, and average order value based on historical monthly trends.

SARIMA was used because the data is monthly and shows seasonality.

The forecast is intended as a planning tool, not a guaranteed prediction.

![2026 Sales Forecast](Screenshots/2026%20Sales%20Forecast.png)



## Key Findings

1. **February 2023 had the highest sales, while April 2023 had the lowest sales.**

2. **The difference was not mainly caused by lower prices.**  
   Average net price stayed relatively stable.

3. **The difference was not mainly caused by higher discounts.**  
   Discounts did not increase enough to explain the February peak.

4. **Customer and order volume were stronger explanations.**  
   February had significantly more customer and order activity than April.

5. **The 50+ age group was the strongest customer segment.**  
   This segment generated the highest sales activity.

6. **Product demand and store channel performance helped provide additional business context.**

7. **Forecasting was added to support future planning.**



## Business Recommendations

Based on the analysis, I would recommend:

- Investigating what drove higher customer and order volume in February.
- Reviewing why April had weaker demand.
- Continuing to monitor the 50+ customer segment because it generated the strongest sales activity.
- Comparing product performance across strong and weak months.
- Reviewing store channel performance separately for online and physical stores.
- Adding marketing campaign data in the future to test whether advertising contributed to peak sales months.
- Using the forecast as a planning tool for future sales expectations.



## Forecasting Method

Python was used inside Power BI to create forecasting visuals.

The forecasting process included:

1. Aggregating sales and orders by month
2. Preparing a monthly time-series dataset
3. Applying a SARIMA forecasting model
4. Forecasting the next 12 months
5. Visualizing forecasted sales, orders, and average order value

SARIMA was selected because it can model monthly seasonality.



## Limitations

This project analyzes sales using sales, customer, product, store, date, and order data.

However, the dataset does not include marketing campaign data. Because of that, the analysis cannot fully confirm whether advertising or promotions caused the February sales peak.

To improve the analysis in the future, I would add:

- Campaign dates
- Products promoted
- Ad spend
- Impressions
- Clicks
- Conversions
- Marketing channel



## Skills Demonstrated

- SQL Server data cleaning
- Power BI data modeling
- Fact and dimension table structure
- DAX measure creation
- KPI dashboard design
- Customer segmentation
- Product performance analysis
- Store channel analysis
- 2023 seasonality analysis
- Python forecasting inside Power BI
- SARIMA time-series forecasting
- Business storytelling with data



## Project Summary

This project started as a general sales performance dashboard during my internship at ACA Group.

After reviewing the 2023 monthly sales trend, I discovered that February was the highest-performing month and April was the lowest-performing month.

That discovery led to a deeper investigation into customer behavior, order volume, pricing, discounts, products, and store channels.

The analysis showed that February’s stronger performance was most likely connected to higher customer and order volume, while April’s lower performance appeared to be driven by weaker demand rather than pricing or discount changes.

The final dashboard turns the analysis into a clear business story: identify the pattern, investigate the cause, support the findings with data, and use forecasting to support future planning.
