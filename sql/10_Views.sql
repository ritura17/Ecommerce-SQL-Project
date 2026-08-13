-- E-Commerce SQL Project
-- File: 10_views.sql
-- Topic: SQL Views

USE ecomerce_db;
show databases;

-- 1. View: Product details with category

CREATE OR REPLACE VIEW product_details AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock
FROM products p
JOIN categories c
    ON p.category_id = c.category_id;


-- Test the view
SELECT *
FROM product_details;

-- 2. View: Customer order details

CREATE OR REPLACE VIEW customer_orders AS
SELECT
    o.order_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;


-- Test the view
SELECT *
FROM customer_orders;

-- 3. View: Complete order details

CREATE OR REPLACE VIEW complete_order_details AS
SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    p.product_name,
    ca.category_name,
    oi.quantity,
    oi.price AS item_price,
    (oi.quantity * oi.price) AS item_total,
    o.order_date,
    o.order_status,
    pay.payment_method,
    pay.payment_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories ca
    ON p.category_id = ca.category_id
LEFT JOIN payments pay
    ON o.order_id = pay.order_id;


-- Test the view
SELECT *
FROM complete_order_details;

-- 4. View: Product revenue

CREATE OR REPLACE VIEW product_revenue AS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;


-- Test the view
SELECT *
FROM product_revenue
ORDER BY total_revenue DESC;

-- 5. View: Customer spending

CREATE OR REPLACE VIEW customer_spending AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(
        SUM(oi.quantity * oi.price),
        0
    ) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;


-- Test the view
SELECT *
FROM customer_spending
ORDER BY total_spending DESC;

-- 6. View: Low stock products

CREATE OR REPLACE VIEW low_stock_products AS
SELECT
    product_id,
    product_name,
    stock,
    price
FROM products
WHERE stock < 20;


-- Test the view
SELECT *
FROM low_stock_products
ORDER BY stock ASC;

-- 7. View: Delivered orders

CREATE OR REPLACE VIEW delivered_orders AS
SELECT
    o.order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.total_amount,
    o.order_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered';


-- Test the view
SELECT *
FROM delivered_orders;

-- 8. View: Category revenue

CREATE OR REPLACE VIEW category_revenue AS
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
    c.category_name;


-- Test the view
SELECT *
FROM category_revenue
ORDER BY total_revenue DESC;

-- 9. Show all views in the database

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- 10. Example: Query a view like a normal table

SELECT
    first_name,
    last_name,
    total_orders,
    total_spending
FROM customer_spending
WHERE total_spending > 5000
ORDER BY total_spending DESC;