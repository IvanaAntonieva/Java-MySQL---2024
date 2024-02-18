-- MySQL Exam Preparation – 5 February 2024
-- Real Estate DB
create database real_estate_db;
use real_estate_db;

-- 1. Table Design
create table cities(
id int primary key auto_increment,
name varchar(60) not null unique
);

create table property_types(
id int primary key auto_increment,
type varchar(40) not null unique, 
description text 
);

create table properties(
id int primary key auto_increment,
address varchar(80) unique not null,
price decimal(19, 2) not null,
area decimal(19, 2),
property_type_id int,
city_id int,
foreign key (property_type_id) references property_types(id),
foreign key (city_id) references cities(id)
);

create table agents(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
phone varchar(20) not null unique,
email varchar(50) not null unique,
city_id int,
foreign key (city_id) references cities(id)
);

create table buyers(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
phone varchar(20) not null unique,
email varchar(50) not null unique,
city_id int,
foreign key (city_id) references cities(id)
);


create table property_offers(
property_id int not null,
agent_id int not null,
price decimal(19, 2) not null,
offer_datetime datetime,
foreign key (property_id) references properties(id),
foreign key (agent_id) references agents(id)
);

create table property_transactions(
id int primary key auto_increment,
property_id int not null, 
buyer_id int not null, 
transaction_date date,
bank_name varchar(30),
iban varchar(40) unique,
is_successful boolean,
foreign key (property_id) references properties(id),
foreign key (buyer_id) references buyers(id)
);

-- 2. Insert
insert into property_transactions(property_id, buyer_id, transaction_date, bank_name, iban, is_successful)
select 
	po.agent_id + day(po.offer_datetime),
	po.agent_id + month(po.offer_datetime),
    date(po.offer_datetime),
    concat('Bank ', po.agent_id),
    concat('BG', po.price, po.agent_id),
    true
from property_offers as po 
where po.agent_id <= 2;

-- 3. Update
update properties as p
set p.price = p.price - 50000
where p.price >= 800000;

-- 4
delete from property_transactions where is_successful is false;

-- 5
select * from agents 
order by city_id desc, phone desc; 

-- 6
select * from property_offers
where year(offer_datetime) = 2021
order by price
limit 10;

-- 7
select 
substring(p.address, 1, 6) as agent_name, 
char_length(p.address) * 5430 as price 
from properties as p
left join property_offers as po on p.id = po.property_id
where po.agent_id is null
order by agent_name desc, price desc;

-- 8 
select bank_name, count(*) as count		
from property_transactions
group by bank_name
having count >= 9
order by count desc, bank_name;

-- 9 
select address, area,
	(case
		when area <= 100 then 'small'
        when area <= 200 then 'medium'
        when area <= 500 then 'large'
        else 'extra large'
	end)
as size 
from properties
order by area, address desc;

-- 10 
delimiter $$
create function udf_offers_from_city_name (cityName VARCHAR(50)) 
	returns int
	deterministic
begin
	declare offers_count int;
    set offers_count := (
		select count(*) from property_offers as po 
		join properties as p on po.property_id = p.id
		join cities as c on p.city_id = c.id
        where c.name = cityName
    );
    return offers_count;
end $$
delimiter ;

-- 11
delimiter $$
create procedure udp_special_offer(first_name VARCHAR(50))
begin
	update property_offers as po
    join agents as a on po.agent_id = a.id
    set po.price = po.price * 0.9
    where a.first_name = first_name;    
end $$
delimiter ;