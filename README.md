# E-Commerce Sales Analysis & Customer Segmentation

An end-to-end data analytics project using SQL, Python (Pandas), and an interactive HTML dashboard to explore e-commerce sales performance and customer purchasing behavior through RFM analysis.

## 🚀 Live Interactive Dashboard

**[Open the Dashboard](https://tusharbansal90.github.io/ecommerce-customer-segmentation/)**

The dashboard includes interactive KPI cards, revenue trends, customer segmentation, country-level analysis, RFM summaries, and filters that update charts and metrics.

## 🎯 Business Objectives

- Analyze transaction revenue and order volume.
- Explore customer purchasing patterns and buying frequency.
- Apply RFM (Recency, Frequency, Monetary) analysis to examine customer segments.
- Investigate customers classified as At Risk in the provided workbook.
- Present sales and customer insights through an interactive dashboard.

## 🛠️ Tools & Technologies

- **SQL / MySQL** — transaction querying and sales analysis
- **Python** — data processing and analysis
- **Pandas** — data cleaning, aggregation, and RFM analysis
- **HTML, CSS, JavaScript** — interactive dashboard
- **GitHub Pages** — dashboard hosting and deployment

## 📊 Dataset Overview

The current dashboard workbook contains the following metrics:

| Metric | Value |
|---|---:|
| Transaction rows | 779,486 |
| Distinct invoices | 36,975 |
| Customers with purchases | 5,881 |
| Total transaction revenue | 17,374,760.00 |

**Note:** The workbook does not explicitly identify the currency, so transaction revenue is presented in unspecified currency units.

## 🔍 Analysis Performed

### SQL Analysis
- Queried transaction data to analyze sales and order activity.
- Organized SQL analysis in a reusable script.

### Python & Pandas Analysis
- Processed transaction data and explored customer purchasing behavior.
- Examined Recency, Frequency, and Monetary metrics.
- Reviewed existing customer segments and RFM scores.

### Interactive Dashboard
- KPI cards for key sales and customer metrics.
- Monthly revenue trends and country-level comparisons.
- Customer segment and RFM analysis.
- Interactive filters for exploring the data.

## 📁 Repository Structure

- [`index.html`](./index.html) — interactive dashboard
- [`ecommerce_sales_analysis.sql`](./ecommerce_sales_analysis.sql) — SQL analysis script
- [`customer_segmentation_rfm.ipynb`](./customer_segmentation_rfm.ipynb) — Python/Pandas analysis notebook
- [`README.md`](./README.md) — project documentation

## ⚠️ Data Notes & Limitations

- The workbook's currency has not been independently confirmed.
- An earlier RFM analysis reported 5,942 customers, while the current dashboard workbook contains 5,881 distinct customers. The discrepancy remains unresolved.
- Some stored RFM values differ from metrics recalculated directly from transaction records.
- Customer segment labels and churn-related flags are treated as workbook fields; their business definitions require further validation.
- Findings should be interpreted according to the metric definitions and data limitations above.

## ▶️ How to Explore

1. Open the [live dashboard](https://tusharbansal90.github.io/ecommerce-customer-segmentation/).
2. Change the available filters to explore different customer groups and sales patterns.
3. Review the SQL script and Python notebook to understand the analysis workflow.

## 👤 Project Focus

This project demonstrates practical data analytics skills in SQL, Python/Pandas, customer segmentation, interactive dashboard development, and communicating data limitations transpar
