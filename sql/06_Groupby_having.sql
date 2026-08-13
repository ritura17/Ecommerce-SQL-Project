-- E-Commerce SQL Project
-- File: 06_groupby_having.sql
-- Topic: GROUP BY and HAVING

USE ecomerce_db;

-- 1. Count customers by state

SELECT
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state;

-- 2. Count products in each category

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- 3. Average product price by category

SELECT
    c.category_name,
    AVG(p.price) AS average_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- 4. Total stock by category

SELECT
    c.category_name,
    SUM(p.stock) AS total_stock
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- 5. Number of orders per customer

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
    c.last_name;

-- 6. Categories having more than 1 product

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) > 1;

-- 7. Customers who placed more than 1 order

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(o.order_id) > 1;

-- 8. Categories with average price above ₹1000

SELECT
    c.category_name,
    AVG(p.price) AS average_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING AVG(p.price) > 1000;

-- 9. Total revenue by product

SELECT
    p.product_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- 10. Total revenue by category

SELECT
    c.category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;