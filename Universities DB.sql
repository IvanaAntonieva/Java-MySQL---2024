-- MySQL Exam Preparation – 2 February 2024
-- Universities DB
create database universities;
use universities;

-- 1. Table Design
create table countries(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table cities(
id int primary key auto_increment,
name varchar(40) not null unique,
population int,
country_id int not null,

foreign key (country_id) references countries(id)
);

create table students(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
age int,
phone varchar(20) not null unique,
email varchar(255) not null unique,
is_graduated tinyint(1) not null,
city_id int,

foreign key (city_id) references cities(id)
);

create table universities(
id int primary key auto_increment,
name varchar(60) not null unique,
address varchar(80) not null unique,
tuition_fee decimal(19,2) not null,
number_of_staff int,
city_id int,

foreign key (city_id) references cities(id)
);

create table courses(
id int primary key auto_increment,
name varchar(40) not null unique,
duration_hours decimal(19,2),
start_date date,
teacher_name varchar(60) not null unique,
description text,
university_id int,

foreign key (university_id) references universities(id)
);

create table students_courses(
grade decimal(19,2) not null,
student_id int not null,
course_id int not null,

foreign key (student_id) references students(id),
foreign key (course_id) references courses(id)
);

-- 2. Insert
insert into courses(name, duration_hours, start_date, teacher_name, description, university_id)
select  concat(teacher_name, ' course'),
		length(name) / 10,
        date_add(start_date, interval 5 day),
        reverse(teacher_name),
        concat('Course ', teacher_name, reverse(description)),
        day(start_date)
from courses
where id <= 5;

-- 3. Update
update universities
set tuition_fee = tuition_fee + 300
where id between 5 and 12;

-- 4. Delete
delete from universities where number_of_staff is null;

-- 5. Cities
drop database universities;
create database universities;
use universities;
-- правя си наново таблиците и инсъртвам информацията от дадения файл;

select * from cities order by population desc;

-- 6. Students age 
select first_name, last_name, age, phone, email
from students
where age >= 21
order by first_name desc, email, id
limit 10;

-- 7. New students
select  concat(s.first_name, ' ', s.last_name) as full_name,
		substring(s.email, 2, 10) as username,
        reverse(s.phone) as password
from students as s
left join students_courses as sc
on s.id = sc.student_id
where sc.course_id is null
order by password desc;

-- 8. Students count
select  count(*) as students_count,
		u.name as university_name 
from universities as u 
join courses as c on u.id = c.university_id
join students_courses as sc on c.id = sc.course_id
group by university_name
having students_count >= 8
order by students_count desc, university_name desc;

-- 9. Price rankings
select 	u.name as university_name, 
		c.name as city_name, 
        u.address, 
			case
				when u.tuition_fee < 800 then 'cheap'
                when u.tuition_fee < 1200 then 'normal'
                when u.tuition_fee < 2500 then 'high'
                else 'expensive'                
			end as price_rank, 
        u.tuition_fee
from universities as u
join cities as c on u.city_id = c.id
order by u.tuition_fee;

-- 10. Average grades
delimiter $$
create function udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
returns decimal(19,2)
deterministic
begin
	declare result decimal(19,2);
    set result := (
    select avg(sc.grade) as average_alumni_grade
	from courses as c
	join students_courses as sc on c.id = sc.course_id
	join students as s on sc.student_id = s.id
	where s.is_graduated = 1 and c.name = course_name
	group by c.id);
    return result;
end $$
delimiter ;

select udf_average_alumni_grade_by_course_name('Quantum Physics');

-- 11. Graduate students
delimiter $$
create procedure udp_graduate_all_students_by_year(year_started int) 
begin
	update students as s
    join students_courses as sc on s.id = sc.student_id
    join courses as c on sc.course_id = c.id
    set s.is_graduated = 1
    where year(c.start_date) = year_started;
end $$
delimiter ;

drop procedure udp_graduate_all_students_by_year;

call udp_graduate_all_students_by_year(2017);