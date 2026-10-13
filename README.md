# Retail Sales Analysis Using SQL

## Project Overview
This project analyzes retail sales data using MySQL to understand revenue performance, product sales, customer spending, payment methods, and city-wise sales trends.

The project demonstrates SQL skills commonly used in entry-level Data Analyst roles.

## Objectives
- Calculate total revenue and key business KPIs.
- Identify top-performing products and categories.
- Analyze monthly sales trends.
- Compare customer spending.
- Evaluate revenue by payment method and city.
- Practice SQL joins, subqueries, and window functions.
- Check data quality using missing-value and invalid-value queries.

## Tools Used
- MySQL
- MySQL Workbench
- SQL

## Database Structure

### 1. Sales
Contains 10 sample sales records with the following columns:
- `sale_id`
- `sale_date`
- `customer_name`
- `product_name`
- `category`
- `quantity`
- `price`
- `payment_method`
- `city`

### 2. Customers
Contains 5 sample customer records with:
- `customer_id`
- `customer_name`
- `city`

## SQL Concepts Demonstrated
- SELECT, WHERE, ORDER BY, and LIMIT
- Aggregate functions: SUM, AVG, COUNT, MAX, and MIN
- GROUP BY and HAVING
- INNER JOIN and LEFT JOIN
- Subqueries
- DISTINCT and NULL checks
- Date functions
- Window functions: RANK() and PARTITION BY
- Business KPI calculations

## Key Findings
Based on the sample dataset:

- **Total revenue:** 138,600
- **Total units sold:** 26
- **Sales records:** 10
- **Unique customers:** 5
- **Average sale value:** 13,860
- **Highest individual sale value:** 55,000
- **Top revenue category:** Electronics, with 115,900
- **Highest-spending customer:** Amit, with 59,500

## Project Files
- `retail_sales_analysis.sql` — database setup, sample data, and SQL analysis queries.

## How to Run the Project
1. Install MySQL and open MySQL Workbench.
2. Open `retail_sales_analysis.sql`.
3. Execute the database setup and table creation statements.
4. Insert the sample data into the tables.
5. Run the analysis queries individually to explore the results.

**Note:** This is a small sample dataset created for SQL learning and portfolio practice. The findings describe only this sample and should not be interpreted as conclusions about a real retail business.

## Author
Sidharth Bhosale