DROP TABLE children;
DROP TABLE employees;
DROP TABLE depart;


CREATE TABLE depart ( 
depno NUMERIC(2) PRIMARY KEY, 
name VARCHAR(180) NOT NULL);

---Заполняем данными таблицу «Отделы»
insert into depart  values(2, 'Бухгалтерия' );
insert into depart  values(3, 'Отдел кадров' );
insert into depart  values(4, 'Отдел технического контроля' );
insert into depart  values(1, 'Плановый отдел' );
insert into depart  values(5, 'Администрация' );

---Создаём таблицу «Сотрудники»
create table employees(  
  tabnum   number(3,0) primary key,
  depno    numeric(2) REFERENCES depart,  	
  ename    varchar2(40) NOT NULL,  
  post     varchar2(40),  
  salary   number(10,1) CHECK (salary > 5000),
  born     date,  
  phone    varchar2 (20));

---Заполняем данными таблицу «Сотрудники» 
insert into employees  values(988, 1, 'Рюмин В.П.', 'начальник отдела', 48500, '01-02-1970','115-26-12');

insert into employees  values(909, 1, 'Серова Т.В.', 'вед. программист', 48500, '20-10-1981', '115-91-19');

insert into employees  values(829, 1, 'Дурова А.В.', 'экономист', 43500, 
'03-10-1978','115-26-12' );

insert into employees  values(819, 1, 'Тамм Л.В.', 'экономист', 43500, 
'13-11-1985','115-91-19');

insert into employees  values(100, 2, 'Волков Л.Д.', 'программист', 46500, 
'16-10-1982', NULL);

insert into employees  values(110, 2, 'Буров Г.О.', 'бухгалтер', 42880, 
'22-05-1975','115-46-32' );

insert into employees  values(023, 2, 'Малова Л.А.', 'гл. бухгалтер', 59240, 
'24-11-1954','114-24-55' );

insert into employees  values(130, 2, 'Лукина Н.Н.', 'бухгалтер', 42880, 
'1-07-1979','115-46-32' );

insert into employees  values(034, 3, 'Перова К.В.', 'делопроизводитель', 32000, '24-04-1988', NULL);

insert into employees  values(002, 3, 'Сухова К.А.', 'начальник отдела', 48500, '08-06-1948','115-12-69' );

insert into employees  values(056, 5, 'Павлов А.А.', 'директор', 80000, 
'05-05-1968','115-33-44');

insert into employees  values(087, 5, 'Котова И.М.', 'секретарь', 35000, 
'16-09-1990','115-33-65' );

insert into employees  values(088, 5, 'Кроль А.П.', 'зам. директора', 70000, 
'18-04-1974','115-33-01' );

---Создаём таблицу «Дети сотрудников»
CREATE TABLE children (
tabnum  number(3,0) REFERENCES employees(tabnum), 
name VARCHAR(50), 
born DATE,
sex CHAR (10), 
PRIMARY KEY (tabnum, name), /* составной первичный ключ */ 
CHECK (sex IN ('м', 'ж')));

---Заполняем данными таблицу «Дети сотрудников»
insert into children  values (988, 'Вадим', '03.MAY.1995' , 'м');
insert into children  values (110, 'Ольга', '18.JUL.2001' , 'ж');
insert into children  values (023, 'Илья', '19.FEB.1987' , 'м');
insert into children  values (023, 'Анна', '26.DEC.1989' , 'ж');
insert into children  values (909, 'Инна', '25.JAN.2008' , 'ж');
insert into children  values (909, 'Роман', '21.NOV.2006' , 'м');
insert into children  values (909, 'Антон', '06.MAR.2009' , 'м');

-- Выводим таблицу «Сотрудники»
select * from employees;

-- Выводим таблицу «Отделы»
select * from depart;

-- Выводим таблицу «Дети сотрудников»
select * from children;

--1) Вывести список сотрудников с указанием должности и зарплаты 
--за вычетом подоходного налога (13%), упорядочить по отделам по 
--возрастанию и фамилиям в алфавитном порядке.
SELECT post, salary*0.87 as salary_after_tax
FROM employees
ORDER BY depno, ename;

--2)	Вывести список должностей с окладом в порядке убывания оклада.
SELECT post, salary
FROM employees
ORDER BY salary DESC;
--3)	Составить список сотрудников второго и третьего отдела, 
--имеющих зарплату выше 40000 рублей после уплаты подоходного налога (13%).
SELECT ename
FROM employees
WHERE depno in (2,3) and salary*0.87 > 40000;
--4)	Составить список сотрудников первого отдела с указанием 
--должности в соответствии с образцом.
 

SELECT ‘должность и ФИО: ‘ || post || ‘ ‘ || ename as Информация
FROM employees;
--5)	Вывести имена и должности директора и его заместителей.
SELECT ename, post
FROM employees
WHERE post LIKE ‘%директор%’;
--6)	Увеличить на 10% оклады начальникам отделов и программистам:
UPDATE employees
SET salary = salary*1.1
WHERE post LIKE ‘%программист%’ or post LIKE ‘%начальник%’;
SELECT * FROM employees;

--7)	Вывести список сотрудников (номер отдела, имя, должность), не имеющих телефонов:

SELECT * FROM employees
WHERE phone is NULL;






