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
select avg(price) from products;
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


