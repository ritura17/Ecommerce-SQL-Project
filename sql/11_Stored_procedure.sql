-- E-Commerce SQL Project
-- File: 11_stored_procedures.sql
-- Topic: Stored Procedures

USE ecomerce_db;

-- 1. Get all products

DROP PROCEDURE IF EXISTS get_all_products;

CREATE PROCEDURE get_all_products()
SELECT
    product_id,
    product_name,
    category_id,
    price,
    stock
FROM products
ORDER BY product_name;

CALL get_all_products();

-- 2. Get product by ID

DROP PROCEDURE IF EXISTS get_product_by_id;

CREATE PROCEDURE get_product_by_id(IN p_product_id INT)
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
WHERE p.product_id = p_product_id;

CALL get_product_by_id(1);

-- 3. Get customer orders

DROP PROCEDURE IF EXISTS get_customer_orders;

CREATE PROCEDURE get_customer_orders(IN p_customer_id INT)
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM orders o
WHERE o.customer_id = p_customer_id
ORDER BY o.order_date DESC;

CALL get_customer_orders(1);

-- 4. Get products by category

DROP PROCEDURE IF EXISTS get_products_by_category;

CREATE PROCEDURE get_products_by_category(IN p_category_id INT)
SELECT
    p.product_id,
    p.product_name,
    p.price,
    p.stock
FROM products p
WHERE p.category_id = p_category_id
ORDER BY p.price DESC;

CALL get_products_by_category(1);

-- 5. Get low-stock products

DROP PROCEDURE IF EXISTS get_low_stock_products;

CREATE PROCEDURE get_low_stock_products(IN p_stock_limit INT)
SELECT
    product_id,
    product_name,
    stock,
    price
FROM products
WHERE stock < p_stock_limit
ORDER BY stock ASC;

CALL get_low_stock_products(20);

-- 6. Search products by name

DROP PROCEDURE IF EXISTS search_products;

CREATE PROCEDURE search_products(IN p_search_term VARCHAR(100))
SELECT
    product_id,
    product_name,
    price,
    stock
FROM products
WHERE product_name LIKE CONCAT('%', p_search_term, '%')
ORDER BY product_name;

CALL search_products('Laptop');

-- 7. Get orders by status

DROP PROCEDURE IF EXISTS get_orders_by_status;

CREATE PROCEDURE get_orders_by_status(IN p_status VARCHAR(30))
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
WHERE o.order_status = p_status
ORDER BY o.order_date DESC;

CALL get_orders_by_status('Delivered');

-- 8. Show all stored procedures

SHOW PROCEDURE STATUS
WHERE Db = DATABASE();