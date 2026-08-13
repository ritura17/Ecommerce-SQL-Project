-- E-Commerce SQL Project
-- File: 14_business_analysis.sql
-- Topic: Business Analysis

USE ecomerce_db;

-- 1. Total Revenue

SELECT
    SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi;

-- 2. Total Number of Orders

SELECT
    COUNT(*) AS total_orders
FROM orders;

-- 3. Average Order Value

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders;

-- 4. Top 5 Customers by Spending

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.price) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spending DESC
LIMIT 5;

-- 5. Best-Selling Products by Quantity

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY units_sold DESC;

-- 6. Top 5 Products by Revenue

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 7. Revenue by Category

SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_revenue DESC;

-- 8. Units Sold by Category

SELECT
    c.category_name,
    SUM(oi.quantity) AS units_sold
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY units_sold DESC;

-- 9. Customers with No Orders

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 10. Products Never Ordered

SELECT
    p.product_id,
    p.product_name,
    p.price,
    p.stock
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 11. Low Stock Products

SELECT
    product_id,
    product_name,
    stock,
    price
FROM products
WHERE stock < 20
ORDER BY stock ASC;

-- 12. High-Value Orders

SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.total_amount > 5000
ORDER BY o.total_amount DESC;

-- 13. Orders by Status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 14. Revenue by Payment Method

SELECT
    pay.payment_method,
    SUM(pay.amount) AS total_payment
FROM payments pay
GROUP BY pay.payment_method
ORDER BY total_payment DESC;

-- 15. Payment Status Analysis

SELECT
    payment_status,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;

-- 16. Monthly Revenue

SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;

-- 17. Average Spending by Customer

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(
        AVG(o.total_amount),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY average_order_value DESC;

-- 18. Customer Order Frequency

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders DESC;

-- 19. Most Expensive Products

SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 20. Complete Business Summary

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS customers_with_orders,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(
        SUM(oi.quantity * oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;