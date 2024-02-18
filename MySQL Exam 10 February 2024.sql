-- MySQL Exam 10 February 2024
-- Wildlife preserves around the world
drop database wildlife;
create database wildlife;
use wildlife;

-- 1
create table continents(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table countries(
id int primary key auto_increment,
name varchar(40) not null unique,
country_code varchar(10) not null unique,
continent_id int not null,

foreign key (continent_id) references continents(id)
);

create table preserves(
id int primary key auto_increment,
name varchar(255) not null unique,
latitude decimal(9,6), 
longitude decimal(9,6), 
area int,
type varchar(20),
established_on date
);

create table positions(
id int primary key auto_increment,
name varchar(40) not null unique,
description text,
is_dangerous boolean not null
);

create table workers(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
age int, 
personal_number varchar(20) not null unique,
salary decimal(19,2),
is_armed boolean not null,
start_date date,
preserve_id int,
position_id int,

foreign key (position_id) references positions(id),
foreign key (preserve_id) references preserves(id)
);

create table countries_preserves(
country_id int,
preserve_id int,

foreign key (country_id) references countries(id),
foreign key (preserve_id) references preserves(id)
);

-- 2
insert into preserves(name, latitude, longitude, area, type, established_on)
select  concat(p.name, ' is in South Hemisphere'),
		p.latitude, 
        p.longitude,
        p.area * p.id,
        lower(p.type),
        p.established_on
from preserves as p
where p.latitude < 0;

-- 3
update workers as w
set w.salary = w.salary + 500
where w.position_id in (5, 8, 11, 13);

-- 4
delete from preserves where established_on is null;

-- 5
select  concat_ws(' ', w.first_name, w.last_name) as full_name,
		datediff('2024-01-01', w.start_date) as days_of_experience
from workers as w
where datediff('2024-01-01', w.start_date) / 365.25 > 5
order by days_of_experience desc
limit 10;

-- 6 
select  w.id	as id,
		w.first_name as first_name,
        w.last_name	as last_name,
        p.name as preserve_name,
        c.country_code as country_code
from workers as w
join preserves as p on w.preserve_id = p.id
join countries_preserves as cp on p.id = cp.preserve_id
join countries as c on cp.country_id = c.id
where w.salary > 5000 and w.age < 50
order by country_code;

-- 7
select  p.name as name,
		count(w.id) as armed_workers
from preserves as p
join workers as w on p.id = w.preserve_id
where w.is_armed is true
group by p.id
order by armed_workers desc, name;

-- 8
select  p.name as name,
		c.country_code as country_code,
		year(p.established_on) as founded_in
from preserves as p
join countries_preserves as cp on p.id = cp.preserve_id
join countries as c on cp.country_id = c.id
where month(p.established_on) = 5
order by founded_in 
limit 5; 

-- 9
select  id, name,
		(case
			when area <= 100 then 'very small'
			when area <= 1000 then 'small'
			when area <= 10000 then 'medium'
			when area <= 50000 then 'large'
			else 'very large'
		end)
	as category
from preserves
order by area desc;

-- 10
delimiter $$
create function udf_average_salary_by_position_name(name VARCHAR(40))  
	returns decimal(19, 2)
	deterministic
begin
	declare salary decimal(19, 2);
    set salary := (
		select avg(w.salary) as average_salary
		from workers as w
		join positions as p on w.position_id = p.id
		where p.name = name
    );
    return salary;
end $$
delimiter ;

-- 11
delimiter $$
create procedure udp_increase_salaries_by_country(country_name VARCHAR(40))
begin 
	update workers as w
    join preserves as p on w.preserve_id = p.id
	join countries_preserves as cp on p.id = cp.preserve_id
	join countries as c on cp.country_id = c.id
	set w.salary = w.salary * 1.05
	where c.name = country_name;       
end $$
delimiter ;
