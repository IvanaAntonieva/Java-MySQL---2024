-- MySQL Exam 13 February 2022
-- Online store – electronic devices
create database online_store;
use online_store;
set global log_bin_trust_function_creators = 1;
set sql_safe_updates = 0;

-- Section 1: Data Definition Language (DDL) – 40 pts
-- 01. Table Design
create table brands(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table categories(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table reviews(
id int primary key auto_increment,
content text, 
rating decimal(10,2) not null,
picture_url varchar(80) not null,
published_at datetime not null
);

create table products(
id int primary key auto_increment,
name varchar(40) not null,
price decimal(19, 2) not null,
quantity_in_stock int,
description text,
brand_id int not null,
category_id int not null,
review_id int,
foreign key (brand_id) references brands(id),
foreign key (category_id) references categories(id),
foreign key (review_id) references reviews(id)
);


create table customers(
id int primary key auto_increment,
first_name varchar(20) not null,
last_name varchar(20) not null,
phone varchar(30) not null unique,
address varchar(60) not null,
discount_card bit not null default 0
);

create table orders(
id int primary key auto_increment,
order_datetime datetime not null,
customer_id int not null,
foreign key (customer_id) references customers(id)
);

create table orders_products(
order_id int,
product_id int,
foreign key (order_id) references orders(id),
foreign key (product_id) references products(id)
);

-- Section 2: Data Manipulation Language (DML) – 30 pt
-- 02. Insert
insert into reviews(content, picture_url, published_at, rating)
select 
	substring(p.description, 1, 15),
    reverse(p.name),
    date('2010/10/10'),
    p.price / 8
from products as p
where p.id >= 5;

-- 03. Update
update products as p
set p.quantity_in_stock = p.quantity_in_stock - 5
where p.quantity_in_stock between 60 and 70;

-- 04. Delete
delete c from customers as c
left join orders as o on c.id = o.customer_id
where o.customer_id is null;

-- Section 3: Querying – 50 pts
-- дропвам всичко и наливам цялата информация наново!!!
-- 05. Categories
select * from categories
order by name desc;

-- 06
select id, brand_id, name, quantity_in_stock
from products
where price > 1000 and quantity_in_stock < 30
order by quantity_in_stock, id;

-- 07 
select * from reviews
where substring(content, 1, 2) = 'My' and char_length(content) > 61
order by rating desc;

-- 08
select 
concat(c.first_name, ' ', c.last_name) as full_name,
c.address,
o.order_datetime as order_date
from customers as c
join orders as o on c.id = o.customer_id
having year(o.order_datetime) <= 2018
order by full_name desc;

-- 09
select 	count(c.id) as items_count,
		c.name as name,
        sum(p.quantity_in_stock) as total_quantity
from categories as c 
join products as p on c.id = p.category_id
group by c.id
order by items_count desc, total_quantity
limit 5;

-- Section 4: Programmability – 30 pts
-- 10. Extract client cards count
delimiter $$
create function udf_customer_products_count(name VARCHAR(30)) 
	returns int
	deterministic
begin
	declare products_count int;
	set products_count := (
	select 
	count(*) as total_product
	from customers as c
	join orders as o on c.id = o.customer_id
	join orders_products as op on o.id = op.order_id
	where c.first_name = name
);
return products_count;
end $$
delimiter ;

SELECT 	c.first_name,
		c.last_name, 
        udf_customer_products_count('Shirley') as total_products 
FROM customers as c
WHERE c.first_name = 'Shirley';

-- 11.
delimiter $$
create procedure udp_reduce_price(category_name VARCHAR(50))
begin
	update products as p
    join categories as c on p.category_id = c.id
    join reviews as r on p.review_id = r.id
    set p.price = p.price * 0.7
    where c.name = category_name and r.rating < 4;
end $$
delimiter ;

CALL udp_reduce_price ('Phones and tablets');