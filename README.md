# Sales Performance & 2023 Seasonality Analysis

## Internship Context

This project was completed during my internship at ACA Group as part of my data analytics and business intelligence learning experience. The goal of the project was to practice building a full analytics workflow using SQL Server, Power BI, DAX, and Python.

During the internship, I worked on cleaning and organizing sales data, building a structured data model, creating business-focused Power BI dashboards, documenting DAX measures, validating SQL views, and adding forecasting logic.

The dashboard demonstrates my ability to clean data, build a data model, create Power BI reports, write DAX measures, validate SQL views, and explain business insights through a structured data story.

---

## Project Overview

This project analyzes sales performance using SQL Server, Power BI, DAX, and Python. It focuses on turning raw sales data into a structured business intelligence dashboard.

The project started as a general sales analytics report. While reviewing sales trends over time, I discovered a clear monthly pattern: February consistently appeared as a strong sales month, while April appeared as a weaker sales month.

After identifying that pattern, I focused the analysis on the year 2023 because it had the highest overall sales performance in the dataset. Within 2023, February stood out as the highest-sales month, while April stood out as the lowest-sales month.

That discovery became the main focus of the project. The analysis investigates why February 2023 performed so strongly and why April 2023 underperformed.

The analysis investigates whether the difference between February and April was caused by:

- Customer volume
- Order volume
- Average order value
- Pricing
- Discounts
- Store channel behavior
- Seasonality
- or, other factors like Tax Season

---

## Business Question

While analyzing monthly sales trends, February 2023 stood out as the strongest sales month, while April 2023 was the weakest.

The main business question became:

**Why did February generate the highest sales, and why did April generate the lowest sales?**

To answer this, the dashboard investigates:

- Did February have more customers than April?
- Did February have more orders?
- Were customers spending more per order?
- Did prices drop in February?
- Were discounts higher in February?
- Did online or physical stores perform differently?
- Was the difference part of a broader seasonal pattern?

---

## Tools Used

- **SQL Server** — data cleaning, restructuring, validation, and creation of analytical views
- **Power BI** — data modeling, relationships, dashboard design, and reporting
- **DAX** — KPI measures, sales metrics, margin calculations, customer metrics, pricing metrics, forecasting logic, and conditional formatting
- **Python** — original SARIMA forecasting in Power BI Desktop
- **Pandas** — data preparation for forecasting
- **Matplotlib** — Python forecast visualizations
- **Statsmodels / SARIMA** — time-series forecasting in the desktop version
- **GitHub** — project documentation and portfolio presentation

---

## Power BI Dashboard File

The Power BI file is included in this repository so the full dashboard can be opened and reviewed.

The report includes:

- Executive KPI Overview
- 2023 Sales Trend Discovery
- 2023 Peak vs Low Month Investigation
- Customer Insights & Targeting
- 2023 Seasonality Findings
- Sales Forecast using DAX-based forecasting for public publishing

# Power BI Dashboard

View the published Power BI dashboard here:

[Open the Power BI Dashboard](https://app.powerbi.com/view?r=eyJrIjoiYTE3ZTgzNjYtNWEwOS00NTMzLTkyODctY2NlNjhkNGQ3ZDRhIiwidCI6IjNjZjA0NjA1LWMxNTQtNGRkZi04OGE4LTRmOTczNDYyZjllMCJ9)

---

## SQL Data Preparation & Modeling

SQL Server was used as the data preparation layer before importing the data into Power BI.

The SQL process included:

- Creating a `clean` schema for cleaned fact and dimension views
- Creating a `mart` schema for final reporting views
- Applying repeated cleaning logic across multiple tables, including trimming text fields, converting blank strings to `NULL`, casting date fields, and renaming columns
- Creating clean fact and dimension views for Power BI
- Validating row counts between source tables, clean views, and reporting views
- Checking for missing relationships between facts and dimensions
- Handling currency exchange carefully to avoid duplicate rows
- Creating a single `currency_exchange_key` for easier Power BI relationships
- Separating online sales from physical store country reporting

Some SQL cleaning patterns were applied across multiple tables using the same logic, so the README does not duplicate every individual query. For example, trimming blank spaces, converting empty strings to `NULL`, renaming columns into business-friendly names, casting date fields, validating row counts, and checking relationship keys were repeated across several dimension and fact views.

The full SQL documentation is included here:

[SQL Documentation](Sql/Queries)

---

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

This model allowed me to analyze sales by month, customer segment, store type, sales channel, currency-adjusted revenue, orders, and profitability.

---

## DAX Measures

The project includes a dedicated DAX measures file documenting the calculations used in the Power BI report.

The measures include:

- Sales calculations
- Cost and margin calculations
- Customer metrics
- Order metrics
- Pricing and discount metrics
- Forecasting support columns
- DAX-based forecasting calculations
- Conditional formatting support measures

[DAX Measures](Dax_Measures/Measures)

These DAX measures helped turn raw fields into business metrics that could answer the main project question.

---

## Forecasting Approach

The original desktop version of the report used Python and SARIMA forecasting inside Power BI. The Python forecast was created with Pandas, Matplotlib, and Statsmodels.

However, when preparing the project for public publishing, the Python visuals did not render in the published public report. To make the public version of the dashboard viewable and interactive, I replaced the Python forecast visuals with DAX-based forecast measures.

The GitHub repository still includes the original Python SARIMA scripts to show the advanced forecasting approach used during development.

The published Power BI version uses a DAX-based seasonal trend forecast.

### Python SARIMA Forecast

The Python version used SARIMA to model monthly sales patterns. SARIMA was selected because the data is monthly and shows seasonality.

The Python version considered:

- Historical monthly sales
- Monthly seasonality
- Trend behavior
- Forecast confidence range

Python scripts are included here:

[Actual vs Forecasted Sales](Python/Actual_vs_Forecasted_Month)

[Forecasted Sales](Python/2026_Forecasted_Sales)

[Forecasted Orders](Python/Forecasted_Orders)

### DAX Forecast for Published Report

The published Power BI version uses DAX forecast measures instead of Python visuals.

The DAX forecast estimates future sales and orders using:

```text
Same-month historical average
+
Recent 12-month growth trend
```

This means the forecast asks:

- What did this same month usually do historically?
- Were the most recent 12 months stronger or weaker than the previous 12 months?
- How should the next 12 months be adjusted based on that trend?

The DAX forecast is not meant to exactly reproduce the SARIMA forecast. The Python and DAX forecasts can produce different numbers because they use different methods.

The reason for using DAX in the published report was practical: it allows the forecast page to remain visible, interactive, and usable in the public Power BI version.

---

## Dashboard Story

The report was designed as a guided business investigation. It starts with overall business performance, then moves into the 2023 sales pattern, then investigates why February performed the best and April performed the worst.

---

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

---

### 2. Sales Trend Discovery

This page focuses on discovering the 2023 monthly sales pattern.

While reviewing sales by month, February stood out as the highest sales month, while April stood out as the lowest sales month.

This discovery changed the project from a general dashboard into a deeper investigation.

![Sales Trend Discovery](Screenshots/Sales%20Trend%20Discovery.png)

---

### 3. 2023 Peak vs Low Month Investigation

This page compares the strongest sales months against April to understand what was driving the difference.

The analysis compares:

- Customer volume
- Order volume
- Average order value
- Average net price
- Average discount
- Online vs physical store performance

The strongest months had much higher customer and order volume than April. However, average order value, net price, and discount levels stayed relatively stable.

This suggests that February’s stronger performance was driven more by customer demand and sales volume than by pricing or discounts.

The analysis also showed stronger online sales activity during higher-performing periods. This may suggest that online demand or digital customer behavior contributed to the sales increase. However, advertising data would be needed to confirm whether paid marketing directly caused the change.

![2023 Peak vs Low Month Investigation](Screenshots/2023%20Peak%20vs%20Low%20Month%20Investigation.png)

---

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

---

### 5. 2023 Seasonality Findings

This page summarizes the main findings from the 2023 sales pattern.

The key takeaway is that February had the highest sales and April had the lowest sales mainly because of differences in customer and order volume.

Pricing, discounts, and average order value did not change enough to explain the gap by themselves.

![2023 Seasonality Findings](Screenshots/2023%20Seasonality%20Findings.png)

---

### 6. Sales Forecast

The final analytical page adds forecasting to support future planning.

The desktop version originally used Python and SARIMA forecasting. The public published version uses DAX-based forecasting because Python visuals did not display in the public report.

The published forecast estimates future monthly sales, orders, and average order value using historical seasonality and recent growth trends.

This forecast is intended as a planning tool, not a guaranteed prediction.

![2026 Sales Forecast](Screenshots/2026%20Sales%20Forecast.png)

---

## Key Findings

## Key Findings

1. **February 2023 had the highest sales, while April 2023 had the lowest sales.**  
   After focusing on 2023, February appeared as the strongest month and April appeared as the weakest month. This became the main business question of the project.

2. **Store channel behavior changed over time.**  
   By comparing sales by store channel across 2022, 2023, 2024, and 2025, the data showed a clear shift in sales behavior. In 2022, sales were led more by physical stores, while in 2023 online store sales became stronger. This shift toward online sales may help explain why 2023, especially February, had higher sales activity.

3. **The online sales shift needed further investigation.**  
   Because online sales became stronger in 2023, I investigated whether the increase was connected to pricing, discounts, or cost changes. This helped determine whether customers were buying more because products became cheaper, discounts increased, or costs changed.

4. **The sales increase was not mainly caused by lower prices.**  
   Average net price stayed relatively stable, which suggests that the February sales peak was not mainly driven by price drops.

5. **The sales increase was not mainly caused by higher discounts.**  
   Discounts did not increase enough to explain the February peak, which helped rule out discounting as the main reason for the higher sales.

6. **Customer and order volume were stronger explanations.**  
   February had significantly more customer and order activity than April. This suggests that higher sales were more closely connected to increased demand and transaction volume.

7. **The 50+ age group was the strongest customer segment.**  
   This segment generated the highest sales activity and became an important customer group to highlight in the analysis.

8. **Advertising data would be needed to confirm the cause of the online shift.**  
   The data shows that online sales became stronger, but it does not include marketing campaign or advertising data. Because of that, the report can suggest that online demand or digital customer behavior contributed to higher sales, but it cannot prove that advertising caused the increase.

9. **Forecasting was added to support future planning.**  
   The original Python SARIMA forecast was kept in the repository, while the published report uses a DAX-based forecast for public compatibility.

---

## Business Recommendations

Based on the analysis, I would recommend:

- Investigating what drove higher customer and order volume in February.
- Reviewing why April had weaker demand.
- Continuing to monitor the 50+ customer segment because it generated the strongest sales activity.
- Reviewing online and physical store performance separately because they represent different sales behaviors.
- Adding marketing campaign data in the future to test whether advertising contributed to peak sales months.
- Using the forecast as a planning tool for future sales expectations.

---

## Forecasting Method

The project includes two forecasting approaches:

1. **Python SARIMA forecasting** used during desktop report development
2. **DAX-based seasonal trend forecasting** used in the published public report

### Why Two Forecasting Methods Were Used

The original Python forecast was more advanced because SARIMA can model seasonality and time-series behavior statistically.

However, the public Power BI version did not support displaying the Python visuals. To keep the report publishable and interactive, the forecast page was rebuilt using DAX measures.

The DAX forecast uses a simpler business forecasting method based on:

- Historical same-month averages
- Recent 12-month growth compared to the previous 12 months
- Seasonal month patterns

Because the Python and DAX methods are different, their forecast numbers are expected to be different.

The DAX version was used in the published report because it is compatible with public Power BI viewing.

---

## Limitations

This project analyzes sales using sales, customer, product, store, date, currency, and order data.

However, the dataset does not include advertising or marketing campaign data. Because of that, the analysis can identify changes in online sales behavior, but it cannot fully confirm whether increased advertising caused the higher sales months.

To improve the analysis in the future, I would add:

- Campaign dates
- Products promoted
- Ad spend
- Impressions
- Clicks
- Conversions
- Marketing channel

Another limitation is that the public report uses a DAX-based forecast instead of the original Python SARIMA visual. The DAX forecast is useful for public viewing and dashboard interactivity, but it is not as statistically advanced as the Python SARIMA model.

---

## Skills Demonstrated

- SQL Server data cleaning
- SQL validation checks
- Power BI data modeling
- Fact and dimension table structure
- DAX measure creation
- DAX-based forecasting
- KPI dashboard design
- Customer segmentation
- Store channel analysis
- 2023 seasonality analysis
- Python forecasting with SARIMA
- Power BI public publishing adaptation
- Business storytelling with data
- GitHub project documentation

---

## Project Summary

This project started as a general sales performance dashboard during my internship at ACA Group.
After reviewing the 2023 monthly sales trend, I discovered that February was the highest-performing month and April was the lowest-performing month.
That discovery led to a deeper investigation into customer behavior, order volume, pricing, discounts, store channel behavior, and seasonality.
The analysis showed that February’s stronger performance was most likely connected to higher customer and order volume, while April’s lower performance appeared to be driven by weaker demand rather than pricing or discount changes.
The analysis also showed that online sales activity became important to review separately from physical store performance. However, because the dataset does not include advertising data, the report does not claim that advertising caused the online sales shift.
The original desktop report used Python and SARIMA for forecasting. When preparing the project for public publishing, the Python visuals did not display in the public report, so the forecast page was rebuilt with DAX-based seasonal trend measures. The Python SARIMA scripts remain in the repository to document the original advanced forecasting approach.

The final dashboard turns the analysis into a clear business story: identify the pattern, investigate the cause, support the findings with data, adapt the report for public publishing, and use forecasting to support future planning.
