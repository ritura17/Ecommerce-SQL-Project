-- ==========================================================
-- E-Commerce SQL Project
-- File: 07_subqueries.sql
-- Topic: Subqueries
-- ==========================================================

USE ecomerce_db;


-- ==========================================================
-- 1. Products more expensive than the average product price
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


-- ==========================================================
-- 2. Find the most expensive product
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);


-- ==========================================================
-- 3. Find the cheapest product
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);


-- ==========================================================
-- 4. Customers who have placed at least one order
-- ==========================================================

SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);


-- ==========================================================
-- 5. Customers who have NOT placed any order
-- ==========================================================

SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);


-- ==========================================================
-- 6. Products that have been ordered
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
);


-- ==========================================================
-- 7. Products that have never been ordered
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM order_items
);


-- ==========================================================
-- 8. Customers whose total spending is above average
-- ==========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT SUM(oi.quantity * oi.price)
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        WHERE o.customer_id = c.customer_id
    ) AS total_spending
FROM customers c
WHERE (
    SELECT SUM(oi.quantity * oi.price)
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            o.customer_id,
            SUM(oi.quantity * oi.price) AS customer_total
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) AS customer_spending
);


-- ==========================================================
-- 9. Orders whose total amount is greater than average order amount
-- ==========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);


-- ==========================================================
-- 10. Find customers who placed the highest-value order
-- ==========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);