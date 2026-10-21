# E-Commerce Customer Segmentation & RFM Analysis

## Project Overview
This project analyzes e-commerce transaction data to understand sales performance, customer purchasing behavior, and customer segments using RFM (Recency, Frequency, Monetary) analysis.

## Objectives
- Analyze transaction revenue and order volume.
- Explore customer purchasing patterns.
- Segment customers using RFM scores.
- Identify customers classified as At Risk in the provided workbook.
- Present findings through an interactive dashboard.

## Tools & Technologies
- **SQL** — data querying and sales analysis
- **Python / Pandas** — data cleaning and customer analysis
- **HTML** — interactive dashboard
- **GitHub** — project documentation and version control

## Dashboard
An interactive dashboard is included in `index.html` with KPI cards, monthly revenue trends, customer segment analysis, country-level revenue, RFM summaries, and filters.

## Key Dataset Metrics
- Transaction rows: 779,486
- Distinct invoices: 36,975
- Customers with purchases: 5,881
- Transaction revenue: 17,374,760.00 in the workbook's unspecified currency units

These figures describe the current dashboard workbook and should be interpreted using its metric definitions.

## Important Limitations
- The workbook does not explicitly specify the currency.
- An earlier RFM analysis reported a different customer count; the discrepancy remains unresolved.
- Stored RFM fields may differ from metrics recalculated directly from transaction rows.
- Segment labels and churn-related flags are treated as provided workbook fields, not independently validated business truths.

## Repository Contents
- `ecommerce_sales_analysis.sql` — SQL analysis script
- `index.html` — interactive dashboard (to be added)

## Next Steps
- Add the Python analysis notebook.
- Validate RFM calculations against the original source data.
- Publish the dashboard using GitHub Pages after adding `index.html`.
