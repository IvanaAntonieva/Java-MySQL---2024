-- MySQL Exam 15 October 2022
-- Restaurant
create database restaurant;
use restaurant;

create table products(
id int primary key auto_increment,
name varchar(30) not null unique,
type varchar(30) not null,
price decimal(10, 2) not null
);

create table clients(
id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
birthdate date not null,
card varchar(50),
review text
);

create table tables(
id int primary key auto_increment,
floor int not null,
reserved boolean,
capacity int not null
);

create table waiters(
id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(50) not null,
phone varchar(50),
salary decimal(10, 2)
);

create table orders(
id int primary key auto_increment,
table_id int not null,
waiter_id int not null,
order_time time not null,
payed_status boolean,
foreign key (table_id) references tables(id),
foreign key (waiter_id) references waiters(id)
);

create table orders_clients(
order_id int,
client_id int,
foreign key (order_id) references orders(id), 
foreign key (client_id) references clients(id) 
);

create table orders_products(
order_id int,
product_id int,
foreign key (order_id) references orders(id), 
foreign key (product_id) references products(id) 
);


-- Section 2: Data Manipulation Language (DML)
-- 02.	Insert
insert into products(name, type, price)
select
	concat(w.last_name, ' specialty'),
    'Cocktail',
    ceiling(w.salary * 0.01)
from waiters as w
where w.id > 6;

-- 03.	Update
update orders
set table_id = table_id - 1
where id between 12 and 23;

-- 04. Delete
delete w from waiters as w
left join orders as o on w.id = o.waiter_id
where o.waiter_id is null;

-- Section 3: Querying 
-- дропвам и наливам цялата информация наново!!!
-- 05.	Clients
select * from clients
order by birthdate desc, id desc;

-- 06.	Birthdate
select first_name, last_name, birthdate, review
from clients
where card is null and year(birthdate) between 1978 and 1993
order by last_name desc, id
limit 5;

-- 07.	Accounts
select 
concat(last_name, first_name, CHAR_LENGTH(first_name), 'Restaurant') as username,
reverse(substring(email, 2, 12)) as `password`
from waiters 
where salary is not null
order by `password` desc;

-- 08. Top From Menu
select p.id as id, p.name as name, count(*) as count
from products as p
join orders_products as op on p.id = op.product_id
group by p.id
having count >= 5
order by count desc, name;

-- 09. Availability 
select t.id as table_id,
		t.capacity as capacity,
        count(oc.client_id) as count_clients,
        case
			when t.capacity > count(oc.client_id) then 'Free seats'
			when t.capacity = count(oc.client_id) then 'Full'
			else 'Extra seats'
        end as availability
        from tables as t
        join orders as o on t.id = o.table_id
        join orders_clients as oc on o.id = oc.order_id
        where t.floor = 1
        group by t.id
        order by t.id desc;
        
-- Section 4: Programmability – 30 pts
-- 10.	Extract bill
SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';

delimiter $$
create function udf_client_bill(full_name VARCHAR(50)) 
returns decimal(19,2)
deterministic
begin
	declare client_bill decimal(19,2);
    set client_bill := (
		select sum(p.price) as client_bill
		from products as p
		join orders_products as op on p.id = op.product_id
		join orders_clients as oc on op.order_id = oc.order_id
		join clients as c on oc.client_id = c.id
		where concat_ws(' ', c.first_name, c.last_name) = full_name        
    );
return client_bill;
end $$

-- 11.	Happy hour
create procedure udp_happy_hour(product_type VARCHAR (50))
begin 
	update products
    set price = price * 0.8
    where price >= 10 and type = product_type;
end $$
delimiter ;

CALL udp_happy_hour ('Cognac');

select * from products where type = 'Cognac';



