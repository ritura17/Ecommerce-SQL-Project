-- 1. Customers with their orders
select c.customer_id,c.first_name,c.last_name,
o.order_id,o.order_date,o.total_amount
from customers as c
inner join orders as o
on c.customer_id = o.customer_id;
--2. Product with categories name
select p.product_id,p.product_name,p.price,
p.stock,ca.category_id,ca.category_name
from products as p
inner join categories as ca
on p.category_id = ca.category_id;
-- In simple way of 2nd question
select p.product_name,p.price,
ca.category_name
from products as p
inner join categories as ca
on p.category_id = ca.category_id;
--3. Oderes with customers name
select c.first_name,c.last_name,
o.order_date,o.total_amount,o.order_status
from customers as c
inner join orders as o
on c.customer_id = o.customer_id;
--4. Orders item with products name
select o.quantity,p.product_name,o.price,p.price
from order_items as o
inner join products as p
on o.product_id = p.product_id;
--5. Payments with customers name
select c.first_name,c.last_name,c.phone,
p.payment_date,p.payment_method,p.payment_status,
p.amount,o.order_status
from orders as o
inner join customers as c
on o.customer_id = c.customer_id
inner join payments as p
on o.order_id = p.order_id;
--6(i). Shipping details
select c.first_name,c.last_name,
s.shipping_address,s.city,s.state,s.postal_code,
o.total_amount
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
INNER JOIN shipping as s
on o.order_id = s.order_id;
--6(ii). Another way
select c.first_name,c.last_name,
s.shipping_address,s.city,s.state,s.postal_code
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
inner join shipping as s
on oi.order_id = s.order_id;
--7. Complete orders details
select c.first_name,c.last_name,o.order_date,
oi.quantity,p.product_name,ca.category_name,
pay.payment_date,pay.payment_method,pay.amount
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
inner join order_items as oi
on o.order_id = oi.order_id
inner join products as p
on oi.product_id = p.product_id
inner join categories as ca
on p.category_id = ca.category_id
inner join payments as pay
on o.order_id = pay.order_id;
--Left join
select c.first_name,c.last_name,
o.order_status,o.total_amount
from customers as c
left join orders as o
on c.customer_id = o.customer_id;
9-- Count order per customers
select c.first_name,c.last_name,
p.product_name,count(o.order_id) as total
from customers as c
left join orders as o
on c.customer_id = o.customer_id
left join order_items as oi
on o.order_id = oi.order_id
left join products as p
on oi.product_id = p.product_id
group by
c.customer_id,
c.first_name,c.last_name,
p.product_id,p.product_name;