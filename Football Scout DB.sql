-- My SQL Exam - 9 Feb 2020
-- Football Scout Database
create database football_scout;
use football_scout;

-- 1
create table coaches(
id int primary key auto_increment,
first_name varchar(10) not null,
last_name varchar(20) not null, 
salary decimal(10,2) not null default 0,
coach_level int not null default 0
);

create table countries(
id int primary key auto_increment,
name varchar(45) not null
);

create table towns(
id int primary key auto_increment,
name varchar(45) not null,
country_id int not null,
foreign key (country_id) references countries(id)
);

create table stadiums(
id int primary key auto_increment,
name varchar(45) not null,
capacity int not null,
town_id int not null,
foreign key (town_id) references towns(id)
);

create table teams(
id int primary key auto_increment,
name varchar(45) not null,
established date not null, 
fan_base bigint not null default 0,
stadium_id int not null,

foreign key (stadium_id) references stadiums(id)
);

create table skills_data(
id int primary key auto_increment,
dribbling int default 0,
pace int default 0,
passing int default 0,
shooting int default 0,
speed int default 0,
strength int default 0
);

create table players(
id int primary key auto_increment,
first_name varchar(10) not null,
last_name varchar(20) not null,
age int not null default 0,
position char(1) not null, 
salary decimal(10,2) not null default 0,
hire_date datetime,
skills_data_id int not null,
team_id int,

foreign key (skills_data_id) references skills_data(id),
foreign key (team_id) references teams(id)
);

create table players_coaches(
player_id int,
coach_id int,
foreign key (player_id) references players(id),
foreign key (coach_id) references coaches(id)
);

-- 2
insert into coaches(first_name, last_name, salary, coach_level)
select
p.first_name,
p.last_name,
p.salary * 2,
char_length(p.first_name)
from players as p
where p.age >= 45;

-- 3
update coaches as c
set c.coach_level = c.coach_level + 1
where c.id in (select coach_id from players_coaches) and c.first_name like 'A%';

-- 4
delete from players where age >= 45;

-- 5
select first_name, age, salary from players 
order by salary desc;

-- 6
select p.id as id, concat_ws(' ', p.first_name, p.last_name) as full_name, p.age as age, p.position as position, p.hire_date as hire_date
from players as p
join skills_data as sd on p.skills_data_id = sd.id
where p.age < 23 and p.position = 'A' and p.hire_date is null and sd.strength > 50
order by p.salary, p.age;

-- 7
select 	t.name as team_name,
		t.established as established,
        t.fan_base as fan_base,
        count(p.id) as players_count
from teams as t
left join players as p on t.id = p.team_id
group by t.id
order by players_count desc, t.fan_base desc;

-- 8
select max(sd.speed) as max_speed,
	towns.name as town_name
    from players as p
    right join skills_data as sd on p.skills_data_id = sd.id
    right join teams as t on p.team_id = t.id
    right join stadiums as s on s.id = t.stadium_id
    right join towns on towns.id = s.town_id
    where t.name != 'Devify'
    group by towns.id
    order by max_speed desc, town_name;
    
-- 9    
select c.name as name,
	count(p.id) as total_count_of_players,
	sum(p.salary) as total_sum_of_salaries
    from countries as c
    left join towns as t on t.country_id = c.id
    left join stadiums as s on s.town_id = t.id
    left join teams as tm on tm.stadium_id = s.id
    left join players as p on p.team_id = tm.id
    group by c.id
    order by total_count_of_players desc, name;
    
-- 10
delimiter $$
create function udf_stadium_players_count (stadium_name VARCHAR(30)) 
returns int deterministic
begin
return (select count(p.id)
	from players as p
	right join teams as t on p.team_id = t.id
	right join stadiums as s on t.stadium_id = s.id
	where s.name = stadium_name
	group by s.id);   
end $$

-- 11
create procedure udp_find_playmaker(min_dribble_points int, team_name varchar(45))
begin
select 
	concat_ws(' ', p.first_name, p.last_name) as full_name,
	p.age as age,
	p.salary as salary,
	sd.dribbling as dribbling,
	sd.speed as speed,
	t.name as team_name
	from players as p
	join skills_data as sd on p.skills_data_id = sd.id
	join teams as t on p.team_id = t.id
	where sd.dribbling > min_dribble_points 
	and t.name = team_name
	and sd.speed > (select avg(speed) from skills_data)
	order by sd.speed desc
	limit 1;
end $$    
delimiter ;  


 


    
