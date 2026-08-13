-- E-Commerce SQL Project
-- File: 15_data_quality.sql
-- Topic: Data Quality and Validation

USE ecomerce_db;

-- 1. Check duplicate customer emails

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- 2. Check duplicate customer records

SELECT
    first_name,
    last_name,
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY
    first_name,
    last_name,
    email
HAVING COUNT(*) > 1;

-- 3. Check products with invalid prices

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price <= 0;

-- 4. Check products with negative stock

SELECT
    product_id,
    product_name,
    stock
FROM products
WHERE stock < 0;

-- 5. Check orders with invalid amounts

SELECT
    order_id,
    total_amount
FROM orders
WHERE total_amount < 0;

-- 6. Check order items with invalid quantity

SELECT
    order_item_id,
    order_id,
    product_id,
    quantity
FROM order_items
WHERE quantity <= 0;

-- 7. Check order items with invalid price

SELECT
    order_item_id,
    product_id,
    price
FROM order_items
WHERE price <= 0;

-- 8. Check payments with invalid amount

SELECT
    payment_id,
    order_id,
    amount
FROM payments
WHERE amount <= 0;

-- 9. Check orders without customers

SELECT
    o.order_id,
    o.customer_id
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 10. Check order items without orders

SELECT
    oi.order_item_id,
    oi.order_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 11. Check order items without products

SELECT
    oi.order_item_id,
    oi.product_id
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 12. Check products without categories

SELECT
    p.product_id,
    p.product_name,
    p.category_id
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

-- 13. Check payments without orders

SELECT
    pay.payment_id,
    pay.order_id
FROM payments pay
LEFT JOIN orders o
    ON pay.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 14. Check NULL values in important customer fields

SELECT
    COUNT(*) AS missing_customer_data
FROM customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL;

-- 15. Check NULL product information

SELECT
    COUNT(*) AS missing_product_data
FROM products
WHERE product_name IS NULL
   OR price IS NULL
   OR stock IS NULL;

-- 16. Compare order total with order item total

SELECT
    o.order_id,
    o.total_amount AS recorded_total,
    SUM(oi.quantity * oi.price) AS calculated_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.price);

-- 17. Check payment amount against order amount

SELECT
    o.order_id,
    o.total_amount AS order_amount,
    SUM(pay.amount) AS paid_amount
FROM orders o
JOIN payments pay
    ON o.order_id = pay.order_id
GROUP BY
    o.order_id,
    o.total_amount
HAVING SUM(pay.amount) <> o.total_amount;

-- 18. Check invalid order dates

SELECT
    order_id,
    order_date
FROM orders
WHERE order_date IS NULL;

-- 19. Check invalid payment dates

SELECT
    payment_id,
    payment_date
FROM payments
WHERE payment_date IS NULL;

-- 20. Overall row count summary

SELECT 'Customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'Categories', COUNT(*)
FROM categories

UNION ALL

SELECT 'Products', COUNT(*)
FROM products

UNION ALL

SELECT 'Orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'Order Items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'Payments', COUNT(*)
FROM payments;