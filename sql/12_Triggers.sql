-- ==========================================================
-- E-Commerce SQL Project
-- File: 12_triggers.sql
-- Topic: MySQL Triggers
-- ==========================================================

USE ecomerce_db;


-- ==========================================================
-- 1. Reduce product stock after an order item is added
-- ==========================================================

DROP TRIGGER IF EXISTS reduce_stock_after_order;

CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON order_items
FOR EACH ROW
UPDATE products
SET stock = stock - NEW.quantity
WHERE product_id = NEW.product_id;


-- ==========================================================
-- 2. Restore product stock after an order item is deleted
-- ==========================================================

DROP TRIGGER IF EXISTS restore_stock_after_delete;

CREATE TRIGGER restore_stock_after_delete
AFTER DELETE ON order_items
FOR EACH ROW
UPDATE products
SET stock = stock + OLD.quantity
WHERE product_id = OLD.product_id;


-- ==========================================================
-- 3. Prevent product stock from becoming negative
-- ==========================================================

DROP TRIGGER IF EXISTS prevent_negative_stock;

CREATE TRIGGER prevent_negative_stock
BEFORE UPDATE ON products
FOR EACH ROW
SET NEW.stock = GREATEST(NEW.stock, 0);


-- ==========================================================
-- 4. Show all triggers
-- ==========================================================

SHOW TRIGGERS;