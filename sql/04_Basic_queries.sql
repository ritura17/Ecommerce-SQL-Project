drop Database ecomerce_db;
show databases;
show tables;
use ecomerce_db;
select * from
categories
order by category_id asc;
select count (category_name)from categories;
select first_name,phone FROM
customers;
select first_name , last_name,state
from customers
where state in ('jharkhand','bihar');
-- where state = 'jharkhand' or 'bihar';
select * from products;
select product_name , stock
from products;
-- Average product price
select avg(price) from products;
-- Price greater than the their average prices
select product_name,price
from products
having price > (
    select avg(price)
    from products
);
-- or
select product_name,price
from products
where price > (
    select avg(price)
    from products
);
select product_name,price
from products
where price =(
    select  max(price) 
    from products
    );
-- top 3 cheapest product
select product_name , price
from products
order by price asc
limit 3;
-- count total stock
select sum(stock) as total_stock
from products;
-- Product which stock greater than 20
select product_id , product_name,stock
from products
where stock > 20;
-- Order with status delivered
select * from orders
where order_status = 'delivered';
-- Order status is diff. from delivered
select * from orders
where order_status != 'delivered';
-- Payments made using 'UPI'
select * from payments
where payment_method = 'upi';
-- Customers whose last name start with S
select firs_name,last_name
from customers
where last_name is like to %s;

