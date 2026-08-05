USE ecomerce_db;

INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports');
select * from categories;
INSERT INTO customers
(first_name,last_name,email,phone,city,state)
VALUES
('Rohan','Sharma','rohan@gmail.com','9876543210','Delhi','Delhi'),
('Priya','Singh','priya@gmail.com','9876543211','Mumbai','Maharashtra'),
('Amit','Kumar','amit@gmail.com','9876543212','Patna','Bihar'),
('Sneha','Das','sneha@gmail.com','9876543213','Kolkata','West Bengal'),
('Rahul','Verma','rahul@gmail.com','9876543214','Ranchi','Jharkhand');
select * from customers;
INSERT INTO products
(product_name,category_id,price,stock)
VALUES
('Laptop',1,65000,15),
('Wireless Mouse',1,1200,100),
('T-Shirt',2,799,60),
('Python Programming',3,699,40),
('Mixer Grinder',4,3500,20),
('Football',5,999,50);
select * from products;
INSERT INTO orders
(customer_id,order_date,total_amount,order_status)
VALUES
(1,'2026-08-01',66200,'Delivered'),
(2,'2026-08-02',799,'Delivered'),
(3,'2026-08-03',699,'Pending'),
(4,'2026-08-04',3500,'Shipped'),
(5,'2026-08-05',999,'Delivered');
select * from orders;
INSERT INTO order_items
(order_id,product_id,quantity,price)
VALUES
(1,1,1,65000),
(1,2,1,1200),
(2,3,1,799),
(3,4,1,699),
(4,5,1,3500),
(5,6,1,999);
select * from order_items;
INSERT INTO payments
(order_id,payment_date,payment_method,amount,payment_status)
VALUES
(1,'2026-08-01','UPI',66200,'Paid'),
(2,'2026-08-02','Credit Card',799,'Paid'),
(3,'2026-08-03','Cash',699,'Pending'),
(4,'2026-08-04','Debit Card',3500,'Paid'),
(5,'2026-08-05','UPI',999,'Paid');
select * from payments;
INSERT INTO shipping
(order_id,shipping_address,city,state,postal_code,delivery_date,shipping_status)
VALUES
(1,'221 MG Road','Delhi','Delhi','110001','2026-08-03','Delivered'),
(2,'45 Park Street','Mumbai','Maharashtra','400001','2026-08-04','Delivered'),
(3,'12 Gandhi Road','Patna','Bihar','800001',NULL,'Pending'),
(4,'88 Lake View','Kolkata','West Bengal','700001','2026-08-06','Shipped'),
(5,'56 Main Road','Ranchi','Jharkhand','834001','2026-08-07','Delivered');
select * from shipping;