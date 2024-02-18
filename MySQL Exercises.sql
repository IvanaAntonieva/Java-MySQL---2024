-- 01.Data Definition and Data Types - Exercise
create database minions;
use minions;

-- 1
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT
);

CREATE TABLE towns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- 2
-- alter table towns rename column town_id to id;

alter table minions add column town_id int; 

alter table minions add constraint fk_minions_towns
foreign key minions(town_id)
references towns(id);

-- 3
insert into towns
values (1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

insert into minions
values (1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3), 
(3, 'Steward', null, 2);

-- select * from minions;

-- 4
 truncate table minions;
 
 -- 5
 drop table minions;
 drop table towns;
 
 -- 6
CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10 , 2 ),
    weight DOUBLE(10 , 2 ),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

insert into people (name, gender, birthdate)
values ('ivana', 'f', '1989-07-24'),
('kolio', 'm', '1989-11-29'),
('mati', 'm', '2018-05-24'),
('ogi', 'm', '2022-08-23'),
('petra', 'f', '2024-11-25');

-- 7
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

insert into users (username, password)
values ('ivana', 'rghkkf'),
('kolio', 'mfsdfsdgh'),
('mati', 'dsm'),
('ogi', 'msdf'),
('petra', 'fdfsdf');

-- 8
alter table users
drop primary key,
add constraint pk_users
primary key users(id, username);

-- 9
alter table users
change column last_login_time 
last_login_time datetime default now();

-- 10
alter table users
drop primary key,
add constraint pk_users primary key users(id),
change column username username varchar(30) unique;

-- 11
create database movies;
use movies;

CREATE TABLE directors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(40) NOT NULL,
    notes TEXT
);

insert into directors (director_name)
values ('kolio'),
('ivana'),
('mati'),
('ogi'),
('petra');

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL,
    notes TEXT
);

insert into genres (genre_name)
values ('horror'),
('comedy'),
('scifi'),
('romance'),
('thriller');

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(20) NOT NULL,
    notes TEXT
);

insert into categories (category_name)
values ('horror'),
('comedy'),
('scifi'),
('romance'),
('thriller');

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT NOT NULL,
    copyright_year YEAR,
    length DOUBLE(10 , 2 ) NOT NULL DEFAULT 0.0,
    genre_id INT NOT NULL,
    category_id INT NOT NULL,
    rating DOUBLE(3 , 2 ) NOT NULL DEFAULT 0.0,
    notes TEXT
);

insert into movies (title, director_id, genre_id, category_id)
values ('Kill Bill', 1, 2, 3),
('Texas Masacre', 1, 2, 3),
('Paranormal Activities', 1, 2, 5),
('Nothing Hill', 1, 2, 4),
('Fast and Furious', 1, 2, 3);

-- 12
create database car_rental;
use car_rental;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    daily_rate INT NOT NULL,
    weekly_rate INT NOT NULL,
    monthly_rate INT NOT NULL,
    weekend_rate INT NOT NULL
);

insert into categories 
values (1, 'car', 1, 2, 3, 4),
(2, 'bus', 10, 20, 30, 40),
(3, 'caravan', 20, 50, 50, 60);

CREATE TABLE cars (
    id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number VARCHAR(10) NOT NULL,
    make VARCHAR(30) NOT NULL,
    model VARCHAR(30) NOT NULL,
    car_year YEAR NOT NULL,
    category_id INT NOT NULL,
    doors INT NOT NULL,
    picture BLOB,
    car_condition VARCHAR(20) NOT NULL,
    available BOOL
);

insert into cars
values (1, 'CB2030PK', 'renault', 'clio', 2007, 1, 5, null, 'new', 1),
(2, 'CB3117PK', 'bmw', '330', 2000, 1, 5, null, 'new', 1),
(3, 'CB4230PK', 'opel', 'vectra', 1995, 1, 5, null, 'old', 1);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title VARCHAR(20) NOT NULL,
    notes TEXT
);

insert into employees
values (1, 'kolio', 'vasilev', 'sales manager', 'some text'),
(2, 'ivana', 'vasileva', 'sales manager', 'some text'),
(3, 'mati', 'vasilev', 'sales manager', 'some text');

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number VARCHAR(30) NOT NULL,
    full_name VARCHAR(60) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    notes TEXT
);

insert into customers
values (1, '12hreh21', 'kolio vasilev', 'mladost', 'sofia', '1715', 'some text'),
(2, '12hrdsf21', 'ivana vasileva', 'mladost', 'sofia', '1715', 'some text'),
(3, '12hre41', 'mati vasilev', 'mladost', 'sofia', '1715', 'some text');

CREATE TABLE rental_orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(10) NOT NULL,
    tank_level VARCHAR(10) NOT NULL,
    kilometrage_start INT NOT NULL,
    kilometrage_end INT NOT NULL,
    total_kilometrage INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    rate_applied INT NOT NULL,
    tax_rate FLOAT NOT NULL,
    order_status VARCHAR(10) NOT NULL,
    notes TEXT
);

insert into rental_orders
values (1, 1, 1, 1, 'NEW', 'FULL', 1000, 1000, 200000, '2023-01-01', '2023-10-01', 10, 100, 100, 'rent', NULL),
(2, 1, 1, 1, 'NEW', 'FULL', 1000, 1000, 200000, '2023-01-01', '2023-10-01', 10, 100, 100, 'rent', NULL),
(3, 1, 1, 1, 'NEW', 'FULL', 1000, 1000, 200000, '2023-01-01', '2023-10-01', 10, 100, 100, 'rent', NULL);

-- 13
create database soft_uni;
use soft_uni;

CREATE TABLE towns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL
);

CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    address_text VARCHAR(80) NOT NULL,
    town_id INT NOT NULL,
    CONSTRAINT fk_addresses_towns FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    job_title VARCHAR(30) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10 , 2 ),
    address_id INT,
    CONSTRAINT fk_employees_departments FOREIGN KEY (department_id)
        REFERENCES departments (id),
    CONSTRAINT fk_employees_adresses FOREIGN KEY (address_id)
        REFERENCES addresses (id)
);

drop table employees;

insert into towns(name)
values ('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

insert into departments(name)
values ('Engineering'), 
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

insert into employees
values 
(1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, null),
(2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, null),
(3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, null),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, null),
(5, 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, null);

-- 14
select * from towns;
select * from departments;
select * from employees;

-- 15
select * from towns as t order by t.name;
select * from departments as d order by d.name;
select * from employees as e order by e.salary desc;

-- 16
select t.name from towns as t order by t.name;
select d.name from departments as d order by d.name;
select e.first_name, e.last_name, e.job_title, e.salary from employees as e order by e.salary desc;

-- 17
update employees
set salary = salary * 1.1;
select salary from employees;

-- 02.Basic CRUD - Exercise
-- 1
SELECT 
    *
FROM
    departments
ORDER BY department_id;

-- 2
SELECT 
    name
FROM
    departments
ORDER BY department_id;

-- 3
SELECT 
    e.first_name, e.last_name, e.salary
FROM
    employees AS e
ORDER BY e.employee_id;

-- 4
SELECT 
    e.first_name, e.middle_name, e.last_name
FROM
    employees AS e
ORDER BY e.employee_id;

-- 5
SELECT 
    CONCAT(e.first_name,
            '.',
            e.last_name,
            '@softuni.bg') AS full_email_address
FROM
    employees AS e;
    
-- 6
SELECT DISTINCT
    salary
FROM
    employees;
    
-- 7
SELECT 
    *
FROM
    employees
WHERE
    job_title = 'Sales Representative'
ORDER BY employee_id;

-- 8
SELECT 
    first_name, last_name, job_title
FROM
    employees
WHERE
    salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

-- 9
SELECT 
    CONCAT_WS(' ', first_name, middle_name, last_name) AS 'Full Name'
FROM
    employees
WHERE
    salary = 25000 OR salary = 14000
        OR salary = 12500
        OR salary = 23600;
        
-- 10
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    manager_id IS NULL;
    
-- 11
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary > 50000
ORDER BY salary DESC;

-- 12
SELECT 
    first_name, last_name
FROM
    employees
ORDER BY salary DESC
LIMIT 5;

-- 13
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    department_id != 4;
    
-- 14
SELECT 
    *
FROM
    employees
ORDER BY salary DESC , first_name ASC , last_name DESC , middle_name ASC;

-- 15
CREATE VIEW v_employees_salaries AS
    SELECT 
        first_name, last_name, salary
    FROM
        employees;
        
-- 16
CREATE VIEW v_employees_job_titles AS
    SELECT 
        CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name,
        job_title
    FROM
        employees;
        
-- 17
SELECT DISTINCT
    job_title
FROM
    employees
ORDER BY job_title;

-- 18
SELECT 
    *
FROM
    projects
ORDER BY start_date , name , project_id
LIMIT 10;

-- 19
SELECT 
    first_name, last_name, hire_date
FROM
    employees
ORDER BY hire_date DESC
LIMIT 7;

-- 20
UPDATE employees AS e 
SET 
    salary = salary * 1.12
WHERE
    department_id IN (1 , 2, 4, 11);
SELECT 
    salary
FROM
    employees;
    
use geography;
-- 21
SELECT 
    peak_name
FROM
    peaks
ORDER BY peak_name;

-- 22
SELECT 
    country_name, population
FROM
    countries
WHERE
    continent_code = 'EU'
ORDER BY population DESC , country_name ASC
LIMIT 30;

-- 23
SELECT 
    country_name,
    country_code,
    IF(currency_code = 'EUR',
        'Euro',
        'Not Euro') AS currency
FROM
    countries
ORDER BY country_name;

-- 24
SELECT 
    name
FROM
    characters
ORDER BY name;

-- 03.Built-in Functions - Exercises
use soft_uni;
-- 1
SELECT 
    first_name, last_name
FROM
    employees
WHERE
   -- LOWER(first_name) LIKE 'sa%'
	first_name REGEXP '^sa'
ORDER BY employee_id;

-- 2
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name REGEXP 'ei'
ORDER BY employee_id;

-- 3 
SELECT 
    first_name
FROM
    employees
WHERE
    department_id IN (3 , 10)
        AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- 4
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- 5
SELECT 
    name
FROM
    towns
WHERE
    LENGTH(name) = 5 OR LENGTH(name) = 6
ORDER BY name;

-- 6 
SELECT 
    *
FROM
    towns
WHERE
    LOWER(LEFT(name, 1)) IN ('m' , 'k', 'b', 'e')
ORDER BY name;

-- 7
SELECT 
    *
FROM
    towns
WHERE
    name REGEXP '^[^RrBbDd]'
ORDER BY name;

-- 8
CREATE VIEW v_employees_hired_after_2000 AS
    SELECT 
        first_name, last_name
    FROM
        employees
    WHERE
        YEAR(hire_date) > 2000;
        
-- 9
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    CHAR_LENGTH(last_name) = 5;
    
use geography;
-- 10
SELECT 
    country_name, iso_code
FROM
    countries
WHERE
    -- country_name LIKE '%a%a%a%'
    (char_length(country_name) - char_length(replace(lower(country_name), 'a', ''))) >= 3
ORDER BY iso_code;

-- 11
SELECT 
    p.peak_name,
    r.river_name,
    LOWER(CONCAT(LEFT(p.peak_name,
                        LENGTH(p.peak_name) - 1),
                    r.river_name)) AS mix
FROM
    peaks AS p,
    rivers AS r
WHERE
    UPPER(RIGHT(p.peak_name, 1)) = UPPER(LEFT(r.river_name, 1))
ORDER BY mix;

use diablo;
-- 12
SELECT 
    name, DATE_FORMAT(start, '%Y-%m-%d')
FROM
    games
WHERE
    YEAR(start) IN (2011 , 2012)
ORDER BY start, name
LIMIT 50;

-- 13
SELECT 
    user_name,
    regexp_replace(email, '.*@', '') as `email provider`
    -- SUBSTRING_INDEX(email, '@', - 1) AS `email provider`
FROM
    users
ORDER BY `email provider` , user_name;

-- 14
SELECT 
    user_name, ip_address
FROM
    users
WHERE
    ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

-- 15
SELECT 
    name AS games,
    CASE
        WHEN HOUR(start) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(start) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN duration <= 3 THEN 'Extra Short'
        WHEN duration BETWEEN 4 AND 6 THEN 'Short'
        WHEN duration BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    games;
    
use orders;
-- 16
SELECT 
    product_name,
    order_date,
    DATE_ADD(order_date, INTERVAL 3 DAY) AS pay_due,
    DATE_ADD(order_date, INTERVAL 1 MONTH) deliver_due
FROM
    orders;
    
-- 04.Data-Agregation-Exercises
use gringotts;
-- 1
SELECT 
    COUNT(*)
FROM
    wizzard_deposits;

-- 2
SELECT 
    MAX(magic_wand_size) AS longest_magic_wand
FROM
    wizzard_deposits;
    
-- 3
SELECT 
    deposit_group, MAX(magic_wand_size) AS longest_magic_wand
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand , deposit_group;

-- 4
SELECT 
    deposit_group
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

-- 5
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

select * from wizzard_deposits;

-- 6
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
WHERE
    magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

-- 7
SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
WHERE
    magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;

-- 8
SELECT 
    deposit_group,
    magic_wand_creator,
    MIN(deposit_charge) AS min_deposit_charge
FROM
    wizzard_deposits
GROUP BY deposit_group , magic_wand_creator
ORDER BY magic_wand_creator , deposit_group;

-- 9
SELECT 
    (CASE
        WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
        WHEN age >= 61 THEN '[61+]'
    END) AS age_group,
    COUNT(first_name) AS 'wizard_count'
FROM
    wizzard_deposits
GROUP BY age_group
ORDER BY wizard_count;

-- 10
SELECT 
    LEFT(first_name, 1) AS first_letter
FROM
    wizzard_deposits
WHERE
    deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

-- 11
SELECT 
    deposit_group,
    is_deposit_expired,
    AVG(deposit_interest) AS average_interest
FROM
    wizzard_deposits
WHERE
    deposit_start_date > '1985-01-01'
GROUP BY deposit_group , is_deposit_expired
ORDER BY deposit_group DESC , is_deposit_expired;

use soft_uni;
-- 12
SELECT 
    department_id, MIN(salary) AS minimum_salary
FROM
    employees
WHERE
    department_id IN (2 , 5, 7)
        AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id;

-- 13
CREATE TABLE employees_with_salary_more_than_30000 AS SELECT * FROM
    employees
WHERE
    salary > 30000;
    
DELETE FROM employees_with_salary_more_than_30000 
WHERE
    manager_id = 42;

UPDATE employees_with_salary_more_than_30000 
SET 
    salary = salary + 5000
WHERE
    department_id = 1;
    
SELECT 
    department_id, AVG(salary) AS avg_salary
FROM
    employees_with_salary_more_than_30000
GROUP BY department_id
ORDER BY department_id;
    
-- 14
SELECT 
    department_id, MAX(salary) AS max_salary
FROM
    employees
GROUP BY department_id
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

-- 15
SELECT 
    COUNT(*) AS ''
FROM
    employees
WHERE
    manager_id IS NULL;
    
-- 16
SELECT 
    e.department_id,
    (SELECT DISTINCT
            e1.salary
        FROM
            employees AS e1
        WHERE
            e1.department_id = e.department_id
        ORDER BY e1.salary DESC
        LIMIT 1 OFFSET 2) AS third_highest_salary
FROM
    employees AS e
GROUP BY e.department_id
HAVING third_highest_salary IS NOT NULL
ORDER BY e.department_id;

-- 17
SELECT 
    first_name, last_name, department_id
FROM
    employees employee1
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees employee2
        WHERE
            employee1.department_id = employee2.department_id)
ORDER BY department_id , employee_id
LIMIT 10;

-- 18
SELECT 
    department_id, SUM(salary) AS total_salary
FROM
    employees
GROUP BY department_id
ORDER BY department_id;

-- 05.Table Relations-Exercises
-- 1
CREATE TABLE people (
    person_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10 , 2 ) DEFAULT 0,
    passport_id INT UNIQUE
);

CREATE TABLE passports (
    passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) UNIQUE
);

alter table passports auto_increment = 101;

alter table people
add constraint pk_people
primary key (person_id),
add constraint fk_people_passports
foreign key (passport_id)
references passports(passport_id);

insert into passports(passport_number)
values ('N34FG21B'), ('K65LO4R7'), ('ZE657QP2');

insert into people(first_name, salary, passport_id)
values ('Roberto', 43300.00, 102), ('Tom', 56100.00, 103), ('Yana', 60200.00, 101);

-- 2
CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    established_on DATE NOT NULL
);

CREATE TABLE models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    manufacturer_id INT,
    CONSTRAINT fk_models_manufacturers FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturers (manufacturer_id)
);

alter table models auto_increment = 101;

insert into manufacturers(name, established_on)   
values ('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

insert into models (name, manufacturer_id)
values ('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3',	2),
('Nova', 3);

-- 3
create table exams(
exam_id int primary key auto_increment,
name varchar(50) not null
) auto_increment = 101;

create table students(
student_id int primary key auto_increment,
name varchar(50) not null
);

create table students_exams(
student_id int,
exam_id int,
constraint pk_students_exams primary key(student_id, exam_id),
constraint fk_students_exams foreign key (exam_id) references exams(exam_id),
constraint fk_exams_students foreign key (student_id) references students(student_id)
);

insert into students (name)
values ('Mila'), ('Toni'), ('Ron');

insert into exams (name) 
values ('Spring MVC'), ('Neo4j'), ('Oracle 11g');

insert into students_exams (student_id, exam_id)
values (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103);

-- 4
CREATE TABLE teachers (
    teacher_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    manager_id INT UNSIGNED DEFAULT NULL
)  AUTO_INCREMENT=101;

insert into teachers (name, manager_id) 
values ('John', NULL), ('Maya', 106), ('Silvia', 106), ('Ted', 105), ('Mark', 101), ('Greta', 101);

alter table teachers 
add constraint pk_teachers primary key (teacher_id),
add constraint fk_teachers_manager_id foreign key (manager_id) references teachers(teacher_id);

-- 5
CREATE TABLE item_types (
    item_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    item_type_id INT,
    CONSTRAINT items FOREIGN KEY (item_type_id)
        REFERENCES item_types (item_type_id)
);

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    birthday DATE,
    city_id INT,
    CONSTRAINT customers FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    CONSTRAINT orders FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id , item_id),
    CONSTRAINT fk_order_items FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_item_order FOREIGN KEY (item_id)
        REFERENCES items (item_id)
);

-- 6
create table subjects(
subject_id int primary key auto_increment,
subject_name varchar(50)
);

create table majors(
major_id int primary key auto_increment,
name varchar(50)
);

create table students(
student_id int primary key auto_increment,
student_number varchar(12),
student_name varchar(50),
major_id int,
constraint fk_students_majors foreign key (major_id) references majors(major_id)
);

create table payments(
payment_id int primary key auto_increment,
payment_date date,
payment_amount decimal(8, 2),
student_id int,
constraint fk_payments_students foreign key (student_id) references students(student_id)
);

create table agenda(
student_id int,
subject_id int,
constraint pk_agenda primary key (student_id, subject_id),
constraint fk_agenda_students foreign key (student_id) references students(student_id),
constraint fk_agenda_subjects foreign key (subject_id) references subjects(subject_id)
);

-- 9
SELECT 
    m.mountain_range, p.peak_name, p.elevation AS peak_elevation
FROM
    mountains AS m
        JOIN
    peaks AS p ON m.id = p.mountain_id
WHERE
    m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;

-- Subqueries and JOINs - Exercises
-- 1
SELECT 
    e.employee_id, e.job_title, a.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

-- 2
SELECT 
    e.first_name, e.last_name, t.name AS town, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
        JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name , e.last_name
LIMIT 5;

-- 3 
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.name = 'Sales'
ORDER BY e.employee_id DESC;

-- 4
SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

-- 5
SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
        LEFT JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE
    ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

-- 6
SELECT 
    e.first_name, e.last_name, e.hire_date, d.name AS dept_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.hire_date > 1999 - 01 - 01
        AND d.name IN ('Sales' , 'Finance')
ORDER BY e.hire_date;

-- 7
SELECT 
    e.employee_id, e.first_name, p.name AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON ep.project_id = p.project_id
WHERE
    DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY e.first_name , p.name
LIMIT 5;

-- 8
SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name) AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON ep.project_id = p.project_id
WHERE
    ep.employee_id = 24
ORDER BY p.name;

-- 9
SELECT 
    e.employee_id,
    e.first_name,
    e.manager_id,
    m.first_name AS manager_name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
WHERE
    m.employee_id IN (3 , 7)
ORDER BY e.first_name;

-- 10
SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS employee_name,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;

-- 11
SELECT 
    AVG(e.salary) AS min_average_salary
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY min_average_salary
LIMIT 1;

use geography;
-- 12
SELECT 
    mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    mountains_countries AS mc
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON m.id = p.mountain_id
WHERE
    mc.country_code = 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;

-- 13
SELECT 
    mc.country_code, COUNT(mc.mountain_id) AS mountain_range
FROM
    mountains_countries AS mc
        JOIN
    mountains AS m ON mc.mountain_id = m.id
GROUP BY mc.country_code
HAVING mc.country_code IN ('BG' , 'US', 'RU')
ORDER BY mountain_range DESC;

-- 14
SELECT 
    c.country_name, r.river_name
FROM
    countries AS c
        LEFT JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        LEFT JOIN
    rivers AS r ON cr.river_id = r.id
WHERE
    c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

-- 15
SELECT 
    continent_code, currency_code, COUNT(*) AS currency_usage
FROM
    countries AS c
GROUP BY continent_code , currency_code
HAVING currency_usage > 1
    AND currency_usage = (SELECT 
        COUNT(*) AS count
    FROM
        countries AS c2
    WHERE
        c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY count DESC
    LIMIT 1)
ORDER BY c.continent_code , c.currency_code;

-- 16
SELECT 
    COUNT(*) AS country_count
FROM
    (SELECT 
        mc.country_code AS mc_country_code
    FROM
        mountains_countries AS mc
    GROUP BY mc.country_code) AS d
        RIGHT JOIN
    countries AS c ON c.country_code = d.mc_country_code
WHERE
    d.mc_country_code IS NULL;
    
-- 17
SELECT 
    c.country_name,
    MAX(p.elevation) AS highest_peak_elevation,
    MAX(r.length) AS longest_river_length
FROM
    countries AS c
        LEFT JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        LEFT JOIN
    peaks AS p ON mc.mountain_id = p.mountain_id
        LEFT JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        LEFT JOIN
    rivers AS r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC , longest_river_length DESC , c.country_name
LIMIT 5;

-- Lab: Database Programmability and Transactions
-- 1
DELIMITER $$
create function ufn_count_employees_by_town(town_name varchar(40))
returns integer
deterministic
begin 

return (select count(*) from employees as e
join addresses as a using (address_id)
join towns as t using (town_id)
where t.name = town_name);
end$$

DELIMITER ;

SELECT UFN_COUNT_EMPLOYEES_BY_TOWN('Sofia');

-- 2
use soft_uni;
drop procedure usp_raise_salaries;
DELIMITER $$
create procedure usp_raise_salaries(`department_name` varchar(50)) 
begin
update employees set salary = salary * 1.05
where department_id = (
select deparrtment_id from departments where `name` = department_name
);
end$$
DELIMITER ;

call usp_raise_salaries('Finance'); 

-- 3
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
START transaction;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id LIKE id)<>1) THEN 
    rollback;
    else
		update employees as e set salary = salary * 1.05
		where e.employee_id = id;
	end if;
end$$

delimiter ;
call usp_raise_salary_by_id(17);
select employee_id, salary from employees
where employee_id = 17;

-- 4
CREATE TABLE IF NOT EXISTS deleted_employees (
    employee_id INT(10) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) DEFAULT NULL,
    job_title VARCHAR(50) NOT NULL,
    department_id INT(10) NOT NULL,
    salary DECIMAL(19 , 4 ) NOT NULL,
    PRIMARY KEY (employee_id)
);

-- Trigger 
DELIMITER $$
create trigger employees_BEFORE_DELETE before delete on employees for each row
begin 
insert into deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
values (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END$$
DELIMITER ;

-- Exercises: Database Programmability and Transactions
set global log_bin_trust_function_creators = 1;
set sql_safe_updates = 0;

-- 1
delimiter $$
create procedure usp_get_employees_salary_above_35000()
begin
	select first_name, last_name 
    from employees
	where salary > 35000
	order by first_name, last_name, employee_id;
end $$
delimiter ;

call usp_get_employees_salary_above_35000();

-- 2
delimiter $$
create procedure usp_get_employees_salary_above(salary_limit double(19,4))
begin 
	select first_name, last_name
    from employees
    where salary >= salary_limit
    order by first_name, last_name, employee_id;
end $$
delimiter ;

call usp_get_employees_salary_above(45000);

-- 3
delimiter $$
create procedure usp_get_towns_starting_with(name_starts_with varchar(50))
begin
select name from towns
where name like concat(name_starts_with, '%')
order by name;
end$$
delimiter ;

call usp_get_towns_starting_with('b');
call usp_get_towns_starting_with('be');
call usp_get_towns_starting_with('ber');

-- 4
DELIMITER $$
create procedure usp_get_employees_from_town(town_name varchar(50))
begin
SELECT first_name, last_name 
from employees as e
join addresses as a on e.address_id = a.address_id
join towns as t on a.town_id = t.town_id
where t.name = town_name
order by e.first_name, e.last_name, e.employee_id;
end $$
DELIMITER ;

call usp_get_employees_from_town('Sofia');

DROP PROCEDURE IF EXISTS usp_get_employees_from_town;

-- 5
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19,4))
RETURNS VARCHAR(7)
return (
	CASE
		WHEN salary < 30000 THEN 'Low'
		WHEN salary <= 50000 THEN 'Average'
        ELSE 'High'
	END
);

SELECT ufn_get_salary_level(13500);
SELECT ufn_get_salary_level(43300);
SELECT ufn_get_salary_level(125000);

drop function if exists ufn_get_salary_level;

-- 6
delimiter $$
create procedure usp_get_employees_by_salary_level(salary_level varchar(7))
begin
select first_name, last_name
from employees 
where (salary < 30000 and salary_level = 'Low')
or (salary >= 30000 and salary <= 50000 and salary_level = 'Average')
or (salary > 50000 and salary_level = 'High')
order by first_name desc, last_name desc;
end $$
delimiter ;

drop procedure usp_get_employees_by_salary_level;
------------------------------------------------

delimiter $$
create procedure usp_get_employees_by_salary_level(salary_level varchar(7))
begin
select first_name, last_name
from employees
where ufn_get_salary_level(salary) = salary_level
order by first_name desc, last_name desc;
end $$
delimiter ;

call usp_get_employees_by_salary_level('High');

-- 7
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
returns bit
return word regexp (concat('^[', set_of_letters, ']+$'));

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');
SELECT ufn_is_word_comprised('oistmiahf', 'halves');
SELECT ufn_is_word_comprised('bobr', 'Rob');
SELECT ufn_is_word_comprised('pppp', 'Guy');

-- 8
delimiter $$
create procedure usp_get_holders_full_name()
begin
select concat_ws(' ', first_name, last_name) as full_name
from account_holders
order by full_name;
end $$
delimiter ;

call usp_get_holders_full_name;

-- 9
delimiter $$
create procedure usp_get_holders_with_balance_higher_than(money_to_compare decimal(19, 4))
begin
select ah.first_name, ah.last_name
from account_holders as ah
join accounts as a on ah.id = a.account_holder_id
group by ah.id
having sum(a.balance) > money_to_compare
order by ah.id;
end $$
delimiter ;

call usp_get_holders_with_balance_higher_than(7000);

drop procedure usp_get_holders_with_balance_higher_than;

-- 10
create function ufn_calculate_future_value(	initial_money decimal(19, 4), 
											interest_per_year decimal(19, 4), 
                                            years int)
returns decimal(19, 4)
return initial_money * pow((1 + interest_per_year), years);

select ufn_calculate_future_value(1000, 0.5, 5);

-- 11
delimiter $$
create procedure usp_calculate_future_value_for_account(account_id int, interest_rate decimal(19, 4))
begin
select 	a.id,
		ah.first_name, 
        ah.last_name, 
        a.balance as current_balance, 
        ufn_calculate_future_value(a.balance, interest_rate, 5) as balance_in_five_years
from accounts as a
join account_holders as ah on a.account_holder_id = ah.id
where a.id = account_id;
end $$
delimiter ;

call usp_calculate_future_value_for_account(1, 0.1);

-- 12
delimiter $$
create procedure usp_deposit_money(account_id int, money_amount decimal(19,4)) 
begin
	if money_amount > 0 then 
    start transaction;
    update accounts as a
    set a.balance = a.balance + money_amount
    where account_id = a.id;
    end if;
end $$
delimiter ;

call usp_deposit_money(1, 10);

select * from accounts where id = 1; 

-- 13
delimiter $$
create procedure usp_withdraw_money(account_id int, money_amount decimal(19, 4)) 
begin
	if money_amount > 0 then
		start transaction;
        
        update accounts as a
        set a.balance = a.balance - money_amount
        where account_id = a.id;
        
        if (select balance from accounts where account_id = id) < 0
        then rollback;
        else commit;
		end if;
	end if;    
end $$
delimiter ;

call usp_withdraw_money(1, 10);

-- 14 
delimiter $$
create procedure usp_transfer_money(from_account_id int, to_account_id int, money_amount decimal(19, 4)) 
begin
	if money_amount > 0
		and from_account_id <> to_account_id
		and (select a.id from accounts as a where a.id = from_account_id) is not null
		and (select a.id from accounts as a where a.id = to_account_id) is not null
		and (select a.balance from accounts as a where a.id = from_account_id) >= money_amount
	then start transaction;
    
    update accounts as a
    set a.balance = a.balance + money_amount
    where a.id = to_account_id;
    
    update accounts as a
    set a.balance = a.balance - money_amount
    where a.id = from_account_id;
    
    if (select a.balance from accounts as a where a.id = from_account_id) < 0
    then rollback;
    else commit;
    end if;
	end if;
end $$
delimiter ;

call usp_transfer_money(1, 2, 10);

select a.id as account_id, a.account_holder_id, a.balance
from accounts as a where a.id in (1, 2);

drop procedure if exists usp_transfer_money;

-- 15
create table logs (
	log_id int unsigned not null primary key auto_increment,
    account_id int(11) not null,
    old_sum decimal(19, 4) not null,
    new_sum decimal(19, 4) not null
);

delimiter $$
create trigger trigger_balance_update
after update on accounts
for each row
begin
	if OLD.balance <> NEW.balance then 
		insert into logs(account_id, old_sum, new_sum)
	values (OLD.id, OLD.balance, NEW.balance);
end if;
end $$
delimiter ;

call usp_transfer_money(1, 2, 10);

select * from logs;

-- 16
create table notification_emails(id int primary key auto_increment,
								recipient int not null,
                                subject varchar(100) not null,
                                body text not null);

delimiter $$
create trigger trigger_notification_emails
after insert on `logs`
for each row
begin
	insert into notification_emails(recipient, `subject`, body)
	values (NEW.account_id,
			concat('Balance change for account: ', new.account_id),
			concat_ws(' ', 
				'On', 
				DATE_FORMAT(NOW(), '%b %d %Y at %r'),
                'your balance was changed from',
                round(NEW.old_sum, 2),
                'to',
                round(NEW.new_sum, 2),
                '.')
			);
end $$
delimiter ;