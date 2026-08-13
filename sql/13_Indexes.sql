-- E-Commerce SQL Project
-- File: 13_indexes_optimization.sql
-- Topic: Indexes and Query Optimization

USE ecomerce_db;

-- 1. Check existing indexes on customers

SHOW INDEX FROM customers;

-- 2. Check existing indexes on orders

SHOW INDEX FROM orders;

-- 3. Check existing indexes on products

SHOW INDEX FROM products;

-- 4. Create index on customer email

CREATE INDEX idx_customer_email
ON customers(email);

-- 5. Create index on order customer_id

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

-- 6. Create index on order date

CREATE INDEX idx_orders_order_date
ON orders(order_date);

-- 7. Create index on product category

CREATE INDEX idx_products_category_id
ON products(category_id);

-- 8. Create index on product name

CREATE INDEX idx_products_product_name
ON products(product_name);

-- 9. Check indexes after creation

SHOW INDEX FROM customers;

SHOW INDEX FROM orders;

SHOW INDEX FROM products;

-- 10. Analyze customer search query

EXPLAIN
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE email = 'rohan@example.com';

-- 11. Analyze customer order query

EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE customer_id = 1;

-- 12. Analyze order date query

EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM orders
WHERE order_date >= '2025-01-01';

-- 13. Analyze product category query

EXPLAIN
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE category_id = 1;

-- 14. Analyze product search query

EXPLAIN
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE product_name = 'Laptop';

-- 15. Check table statistics

ANALYZE TABLE customers;

ANALYZE TABLE orders;

ANALYZE TABLE products;