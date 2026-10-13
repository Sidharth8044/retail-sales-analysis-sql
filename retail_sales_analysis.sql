
-- Project: Retail Sales Analysis Using SQL
-- Database: retail_sales_analysis


-- Select the database
CREATE DATABASE IF NOT EXISTS retail_sales_analysis;
USE retail_sales_analysis;

-- Create the sales table
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    payment_method VARCHAR(50),
    city VARCHAR(50)
);


-- Insert sample sales data
INSERT INTO sales
(sale_id, sale_date, customer_name, product_name, category,
 quantity, price, payment_method, city)
VALUES
(1, '2026-01-05', 'Rahul', 'Laptop', 'Electronics', 1, 55000.00, 'UPI', 'Pune'),
(2, '2026-01-07', 'Priya', 'Headphones', 'Electronics', 2, 1500.00, 'Credit Card', 'Mumbai'),
(3, '2026-01-10', 'Amit', 'Office Chair', 'Furniture', 1, 4500.00, 'Cash', 'Pune'),
(4, '2026-01-12', 'Sneha', 'Notebook', 'Stationery', 5, 80.00, 'UPI', 'Nashik'),
(5, '2026-01-15', 'Rahul', 'Mouse', 'Electronics', 2, 700.00, 'Debit Card', 'Pune'),
(6, '2026-02-02', 'Priya', 'Desk', 'Furniture', 1, 8000.00, 'UPI', 'Mumbai'),
(7, '2026-02-05', 'Vikram', 'Notebook', 'Stationery', 10, 80.00, 'Cash', 'Nagpur'),
(8, '2026-02-11', 'Amit', 'Laptop', 'Electronics', 1, 55000.00, 'Credit Card', 'Pune'),
(9, '2026-02-14', 'Sneha', 'Headphones', 'Electronics', 1, 1500.00, 'UPI', 'Nashik'),
(10, '2026-02-20', 'Vikram', 'Office Chair', 'Furniture', 2, 4500.00, 'Debit Card', 'Nagpur');


-- Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- Insert sample customer data
INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'Rahul', 'Pune'),
(102, 'Priya', 'Mumbai'),
(103, 'Amit', 'Pune'),
(104, 'Sneha', 'Nashik'),
(105, 'Vikram', 'Nagpur');


-- =========================================
-- 1. Calculate Total Revenue
-- =========================================
SELECT SUM(quantity * price) AS total_revenue
FROM sales;

-- =========================================
-- 2. Revenue by Category
-- =========================================
SELECT
    category,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- =========================================
-- 3. Total Units Sold by Product
-- =========================================
SELECT
    product_name,
    SUM(quantity) AS total_units_sold
FROM sales
GROUP BY product_name
ORDER BY total_units_sold DESC;

-- =========================================
-- 4. Top 3 Products by Revenue
-- =========================================
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 3;

-- =========================================
-- 5. Monthly Revenue
-- =========================================
SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sales_month;


-- =========================================
-- 6. Total Spending by Customer
-- =========================================
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC;

-- =========================================
-- 7. Revenue by Payment Method
-- =========================================
SELECT
    payment_method,
    SUM(quantity * price) AS total_revenue,
    COUNT(*) AS total_transactions
FROM sales
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- =========================================
-- 8. Revenue by City
-- =========================================
SELECT
    city,
    SUM(quantity * price) AS total_revenue,
    COUNT(*) AS total_sales_records
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- =========================================
-- 9. Products with Revenue Above 5000
-- =========================================
SELECT
    product_name,
    SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_name
HAVING SUM(quantity * price) > 5000
ORDER BY total_revenue DESC;

-- =========================================
-- 10. Repeat Customers
-- =========================================
SELECT
    customer_name,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY customer_name
HAVING COUNT(*) > 1
ORDER BY number_of_sales DESC;


-- =========================================
-- 11. Sales Above Average Sale Value
-- =========================================
SELECT
    sale_id,
    customer_name,
    product_name,
    quantity * price AS sale_value
FROM sales
WHERE quantity * price > (
    SELECT AVG(quantity * price)
    FROM sales
)
ORDER BY sale_value DESC;

-- =========================================
-- 12. Second-Highest Distinct Sale Value
-- =========================================
SELECT MAX(quantity * price) AS second_highest_sale
FROM sales
WHERE quantity * price < (
    SELECT MAX(quantity * price)
    FROM sales
);

-- =========================================
-- 13. Revenue by Category and Payment Method
-- =========================================
SELECT
    category,
    payment_method,
    SUM(quantity * price) AS total_revenue,
    COUNT(*) AS total_sales_records
FROM sales
GROUP BY category, payment_method
ORDER BY category, total_revenue DESC;

-- =========================================
-- 14. Check for Missing Values
-- =========================================
SELECT *
FROM sales
WHERE customer_name IS NULL
   OR product_name IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price IS NULL
   OR payment_method IS NULL
   OR city IS NULL;

-- =========================================
-- 15. Check Record and Customer Counts
-- =========================================
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT sale_id) AS unique_sale_ids,
    COUNT(DISTINCT customer_name) AS unique_customers
FROM sales;

-- =========================================
-- 16. Business KPIs
-- =========================================
SELECT
    COUNT(*) AS total_sales_records,
    SUM(quantity) AS total_units_sold,
    SUM(quantity * price) AS total_revenue,
    ROUND(AVG(quantity * price), 2) AS average_sale_value,
    MAX(quantity * price) AS highest_sale_value,
    MIN(quantity * price) AS lowest_sale_value
FROM sales;

-- =========================================
-- 17. Check Invalid Quantities and Prices
-- =========================================
SELECT *
FROM sales
WHERE quantity <= 0 OR price <= 0;


-- =========================================
-- 18. Latest Purchase and Total Spending
-- =========================================
SELECT
    customer_name,
    MAX(sale_date) AS most_recent_purchase,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY most_recent_purchase DESC;

-- =========================================
-- 19. Customers Spending Above Average
-- =========================================
SELECT
    customer_name,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_name
HAVING SUM(quantity * price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(quantity * price) AS customer_total
        FROM sales
        GROUP BY customer_name
    ) AS customer_spending
)
ORDER BY total_spent DESC;

-- =========================================
-- 20. INNER JOIN: Sales and Customers
-- =========================================
SELECT
    s.sale_id,
    s.customer_name,
    c.customer_id,
    s.product_name,
    s.quantity,
    s.price,
    s.quantity * s.price AS revenue,
    c.city AS customer_city
FROM sales AS s
INNER JOIN customers AS c
    ON s.customer_name = c.customer_name
ORDER BY s.sale_id;

-- =========================================
-- 21. LEFT JOIN: Keep All Sales
-- =========================================
SELECT
    s.sale_id,
    s.customer_name,
    s.product_name,
    c.customer_id,
    c.city AS customer_city
FROM sales AS s
LEFT JOIN customers AS c
    ON s.customer_name = c.customer_name
ORDER BY s.sale_id;

-- =========================================
-- 22. Customers Without Purchases
-- =========================================
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers AS c
LEFT JOIN sales AS s
    ON c.customer_name = s.customer_name
WHERE s.sale_id IS NULL;

-- =========================================
-- 23. Rank Products by Total Revenue
-- =========================================
SELECT
    product_name,
    category,
    SUM(quantity * price) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(quantity * price) DESC
    ) AS revenue_rank
FROM sales
GROUP BY product_name, category
ORDER BY revenue_rank;

-- =========================================
-- 24. Top Products Within Each Category
-- =========================================
SELECT *
FROM (
    SELECT
        product_name,
        category,
        SUM(quantity * price) AS total_revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(quantity * price) DESC
        ) AS revenue_rank
    FROM sales
    GROUP BY product_name, category
) AS ranked_products
WHERE revenue_rank <= 2
ORDER BY category, revenue_rank;


      