-- ==========================================================
-- E-Commerce SQL Project
-- File: 09_window_functions.sql
-- Topic: Window Functions
-- ==========================================================

USE ecomerce_db;


-- ==========================================================
-- 1. Rank products by price
-- ==========================================================

SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;


-- ==========================================================
-- 2. Dense rank products by price
-- ==========================================================

SELECT
    product_id,
    product_name,
    price,
    DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;


-- ==========================================================
-- 3. Row number for products by price
-- ==========================================================

SELECT
    product_id,
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num
FROM products;


-- ==========================================================
-- 4. Rank customers by total spending
-- ==========================================================

WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.price) AS total_spending
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cs.total_spending,
    RANK() OVER (
        ORDER BY cs.total_spending DESC
    ) AS spending_rank
FROM customers c
JOIN customer_spending cs
    ON c.customer_id = cs.customer_id;


-- ==========================================================
-- 5. Rank products within each category
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price,
    RANK() OVER (
        PARTITION BY p.category_id
        ORDER BY p.price DESC
    ) AS category_rank
FROM products p;


-- ==========================================================
-- 6. Top product in each category
-- ==========================================================

WITH ranked_products AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        p.price,
        RANK() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS product_rank
    FROM products p
)
SELECT
    rp.product_id,
    rp.product_name,
    c.category_name,
    rp.price
FROM ranked_products rp
JOIN categories c
    ON rp.category_id = c.category_id
WHERE rp.product_rank = 1;


-- ==========================================================
-- 7. Running total of order revenue
-- ==========================================================

SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS running_revenue
FROM orders;


-- ==========================================================
-- 8. Average order amount alongside each order
-- ==========================================================

SELECT
    order_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER () AS average_order_amount
FROM orders;


-- ==========================================================
-- 9. Difference between order amount and average order amount
-- ==========================================================

SELECT
    order_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER () AS average_order_amount,
    total_amount -
        AVG(total_amount) OVER () AS difference_from_average
FROM orders;


-- ==========================================================
-- 10. Customer order sequence
-- ==========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_order_number
FROM orders;


-- ==========================================================
-- 11. Previous order amount for each customer
-- ==========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders;


-- ==========================================================
-- 12. Next order amount for each customer
-- ==========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount
FROM orders;


-- ==========================================================
-- 13. Compare current order with previous order
-- ==========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount,

    total_amount -
        LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS difference
FROM orders;


-- ==========================================================
-- 14. Total revenue by category with category ranking
-- ==========================================================

WITH category_revenue AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT
    c.category_id,
    c.category_name,
    cr.revenue,
    RANK() OVER (
        ORDER BY cr.revenue DESC
    ) AS revenue_rank
FROM category_revenue cr
JOIN categories c
    ON cr.category_id = c.category_id;


-- ==========================================================
-- 15. Percentage contribution of each product to total revenue
-- ==========================================================

WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_id,
    product_name,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM product_revenue
ORDER BY revenue DESC;