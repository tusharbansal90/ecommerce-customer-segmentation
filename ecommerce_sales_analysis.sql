CREATE DATABASE online_retail_db;
USE online_retail_db;

SELECT * FROM online_retail LIMIT 10;
SELECT COUNT(*) FROM online_retail;

SELECT
    COUNT(*) AS total_rows,
    SUM(CustomerID IS NULL) AS missing_customer_id,
    SUM(Description IS NULL) AS missing_description,
    SUM(InvoiceNo IS NULL) AS missing_invoice_no,
    SUM(Quantity IS NULL) AS missing_quantity,
    SUM(UnitPrice IS NULL) AS missing_unit_price
FROM online_retail;

SELECT 
	SUM(CASE WHEN Quantity <0 THEN 1 ELSE 0 END)AS negative_quantity_count,
    SUM(CASE WHEN Quantity =0 THEN 1 ELSE 0 END)AS zero_quantity_count,
    SUM(CASE WHEN UnitPrice <0 THEN 1 ELSE 0 END)AS negative_UnitPrice_count,
    SUM(CASE WHEN UnitPrice <0 THEN 1 ELSE 0 END)AS zero_UnitPrice_count
FROM online_retail;
    
SELECT
    COUNT(*) AS cancelled_rows,
    SUM(Quantity < 0) AS negative_quantity_rows,
    SUM(Quantity > 0) AS positive_quantity_rows
FROM online_retail
WHERE InvoiceNo LIKE 'C%';



SELECT COUNT(*)AS total_rows,
SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END) AS cancelled_rows,
ROUND(100.0 * SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END)/COUNT(*),2)AS cancelled_rows_PERCENTAGE
FROM online_retail;



SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM online_retail
WHERE Quantity < 0
  AND InvoiceNo NOT LIKE 'C%'
LIMIT 20;


  
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    COUNT(DISTINCT CustomerID) AS unique_customers,
    SUM(Quantity) AS total_quantity,
    SUM(Quantity * UnitPrice) AS total_value
FROM online_retail
WHERE Quantity < 0
  AND InvoiceNo NOT LIKE 'C%';


SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM online_retail
WHERE UnitPrice <= 0
ORDER BY UnitPrice, InvoiceDate
LIMIT 20;


SELECT CASE WHEN UnitPrice<0 THEN 'Negative price'
			WHEN UnitPrice=0 THEN 'Zero price' 
            END AS price_category,
COUNT(*) AS total_rows,
COUNT(DISTINCT InvoiceNo) AS unique_invoices
FROM online_retail
WHERE UnitPrice <= 0
GROUP BY price_category;


SELECT
    Description,
    COUNT(*) AS total_rows,
    SUM(Quantity) AS total_quantity
FROM online_retail
WHERE UnitPrice = 0
GROUP BY Description
ORDER BY total_rows DESC
LIMIT 15;



SELECT
    COUNT(*) AS candidate_sales_rows,
    COUNT(DISTINCT InvoiceNo) AS candidate_invoices,
    ROUND(SUM(Quantity * UnitPrice), 2) AS candidate_sales_value
FROM online_retail
WHERE Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';
  
  
  
  
  
  
CREATE VIEW vw_retail_sales AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Quantity * UnitPrice AS LineTotal
FROM online_retail
WHERE Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';
  
  


SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    ROUND(SUM(LineTotal), 2) AS sales_value
FROM vw_retail_sales;


SELECT 
		InvoiceDate, STR_TO_DATE(InvoiceDate, '%d/%m/%Y %H:%i' ) AS converted_InvoiceDate
FROM vw_retail_sales LIMIT 10;


SELECT
    DATE_FORMAT(
        STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(LineTotal), 2) AS monthly_sales,
    COUNT(DISTINCT InvoiceNo) AS total_invoices,
    ROUND(ROUND(SUM(LineTotal), 2) / COUNT(DISTINCT InvoiceNo),2)AS average_order_value
FROM vw_retail_sales
WHERE STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') IS NOT NULL
GROUP BY sales_month
ORDER BY sales_month ASC;



SELECT Country, 
ROUND(SUM(LineTotal), 2)AS total_revenue,
COUNT(DISTINCT InvoiceNo)AS unique_invoice,
COUNT(DISTINCT CustomerID)AS unique_CustomerID
FROM vw_retail_sales
WHERE Quantity >0 AND UnitPrice >0 AND InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;



SELECT StockCode,Description,
sum(Quantity)AS total_sold_quantity,
SUM(LineTotal)AS total_product_revenue
From vw_retail_sales
WHERE Quantity >0 AND UnitPrice >0 AND InvoiceNo NOT LIKE 'C%'
GROUP BY StockCode,Description
ORDER BY total_sold_quantity DESC
LIMIT 10;

SELECT StockCode,Description,
sum(Quantity)AS total_sold_quantity,
SUM(LineTotal)AS total_product_revenue
From vw_retail_sales
WHERE Quantity >0 AND UnitPrice >0 AND InvoiceNo NOT LIKE 'C%'
GROUP BY StockCode,Description
ORDER BY total_product_revenue DESC
LIMIT 10;


SELECT CustomerID,SUM(LineTotal)AS total_revenue,COUNT(DISTINCT InvoiceNo)AS unique_invoice
FROM vw_retail_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC LIMIT 10;


WITH customer_invoice_counts AS(
	SELECT
		CustomerID,
        COUNT(DISTINCT InvoiceNo ) AS total_invoice
	FROM vw_retail_sales
    WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
)
SELECT total_invoice,
COUNT(*) AS total_customers
FROM customer_invoice_counts
GROUP BY total_invoice
ORDER BY total_invoice;



WITH customer_invoice_counts AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_invoices
    FROM vw_retail_sales
    WHERE CustomerID IS NOT NULL
      AND InvoiceNo NOT LIKE 'C%'
    GROUP BY CustomerID
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN total_invoices = 1 THEN 1
        ELSE 0
    END) AS one_time_customers,
    SUM(CASE
        WHEN total_invoices > 1 THEN 1
        ELSE 0
    END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE
            WHEN total_invoices > 1 THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS repeat_customer_percentage
FROM customer_invoice_counts;



SELECT StockCode,Description , SUM(Quantity)AS total_quantity_sold , SUM(Quantity * UnitPrice) AS total_revenue 
 FROM vw_retail_sales
 WHERE Quantity>0 AND UnitPrice>0 AND InvoiceNo NOT LIKE 'C%'
 GROUP BY StockCode , Description 
 ORDER BY total_revenue DESC LIMIT 10;



SELECT CustomerID , SUM(LineTotal) AS total_revenue , COUNT(DISTINCT InvoiceNo) AS unique_invoiveNo
FROM vw_retail_sales
WHERE CustomerID IS NOT NULL AND InvoiceNo NOT LIKE 'C%'
GROUP BY CustomerID
ORDER BY total_revenue DESC
LIMIT 10;


WITH customer_invoice_counts AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_invoices
    FROM vw_retail_sales
    WHERE CustomerID IS NOT NULL
      AND InvoiceNo NOT LIKE 'C%'
    GROUP BY CustomerID
)
SELECT
    total_invoices,
    COUNT(*) AS total_customers
FROM customer_invoice_counts
GROUP BY total_invoices
ORDER BY total_invoices ASC;



SELECT CustomerID,SUM(LineTotal)AS total_revenue
FROM vw_retail_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC LIMIT 10;


SELECT CustomerID,COUNT(DISTINCT InvoiceNo)AS total_invoice,SUM(Quantity)AS total_quantity,SUM(LineTotal)AS total_revenue
FROM vw_retail_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC LIMIT 10;


SELECT
    DATE_FORMAT(
        STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(LineTotal), 2) AS monthly_sales,
    COUNT(DISTINCT InvoiceNo) AS total_invoices,
    ROUND(ROUND(SUM(LineTotal), 2) / COUNT(DISTINCT InvoiceNo),2)AS average_order_value
FROM vw_retail_sales
WHERE STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') IS NOT NULL
AND InvoiceNo NOT LIKE 'C%'
GROUP BY sales_month
ORDER BY sales_month ASC;


WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i:%s'),
            '%Y-%m'
        ) AS sales_month,
        SUM(LineTotal) AS monthly_revenue
    FROM vw_retail_sales
    WHERE STR_TO_DATE(
              InvoiceDate, '%m/%d/%Y %H:%i:%s'
          ) IS NOT NULL
      AND InvoiceNo NOT LIKE 'C%'
    GROUP BY sales_month
),
sales_with_previous AS (
    SELECT
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS current_month_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        100.0 * (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS sales_growth_percentage
FROM sales_with_previous
ORDER BY sales_month;



WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i:%s'),
            '%Y-%m'
        ) AS sales_month,
        SUM(LineTotal) AS monthly_revenue
    FROM vw_retail_sales
    WHERE STR_TO_DATE(
        InvoiceDate, '%m/%d/%Y %H:%i:%s'
    ) IS NOT NULL
      AND InvoiceNo NOT LIKE 'C%'
    GROUP BY sales_month
),
sales_comparison AS (
    SELECT
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS current_revenue,
    ROUND(previous_month_revenue, 2) AS previous_revenue,
    ROUND(
        100.0 * (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage
FROM sales_comparison
WHERE monthly_revenue < previous_month_revenue
ORDER BY sales_month;




SELECT Country, SUM(LineTotal)AS total_revenue
FROM vw_retail_sales
GROUP BY Country
ORDER BY total_revenue DESC LIMIT 10;



SELECT Description, SUM(Quantity) AS total_quantity
FROM vw_retail_sales
WHERE Quantity > 0 AND UnitPrice > 0 AND InvoiceNo NOT LIKE 'C%'
GROUP BY Description
ORDER BY total_quantity DESC
LIMIT 10;


SELECT Description, SUM(Quantity) AS total_quantity
FROM vw_retail_sales
WHERE Quantity > 0 AND UnitPrice > 0 AND InvoiceNo NOT LIKE 'C%'
GROUP BY Description
ORDER BY total_quantity ASC
LIMIT 10;


SELECT CustomerID,COUNT(DISTINCT InvoiceNo)AS total_invoiceNo
FROM vw_retail_sales
WHERE CustomerID IS NOT NULL AND InvoiceNo NOT LIKE 'C%'
GROUP BY CustomerID
ORDER BY total_invoiceNo DESC LIMIT 10;


SELECT Country , 
COUNT(DISTINCT InvoiceNo)AS unique_invoiceNo,
SUM(LineTotal)AS total_revenue,
(SUM(LineTotal)/COUNT(DISTINCT InvoiceNo))AS avg_order_value
FROM vw_retail_sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY avg_order_value DESC LIMIT 10;



SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_price,
    SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0 END) AS cancelled_transactions,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer_id
FROM vw_retail_sales;




SELECT
    COUNT(*) AS cancelled_rows
FROM vw_retail_sales
WHERE InvoiceNo LIKE 'C%';

SELECT COUNT(*) AS cancelled_rows
FROM online_retail
WHERE InvoiceNo LIKE 'C%';

SHOW CREATE VIEW vw_retail_sales;