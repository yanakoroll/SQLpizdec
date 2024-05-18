---Создаём таблицу «Отделы»
CREATE TABLE depart ( 
depno NUMERIC(5) PRIMARY KEY, 
name VARCHAR(180) NOT NULL);

---Заполняем данными таблицу «Отделы»
insert into depart  values(2, 'Бухгалтерия' );
insert into depart  values(3, 'Отдел кадров' );
insert into depart  values(4, 'Отдел технического контроля' );
insert into depart  values(1, 'Плановый отдел' );
insert into depart  values(5, 'Администрация' );
insert into depart  values(6, 'Хозяйственный отдел' );

---Создаём таблицу «Отделы2»
CREATE TABLE depart2 ( 
depno NUMERIC(5) PRIMARY KEY, 
name VARCHAR(180) NOT NULL);

---Заполняем данными таблицу «Отделы2»
insert into depart2  values(2, 'Бухгалтерия' );
insert into depart2  values(3, 'Отдел кадров' );
insert into depart2  values(777, 'Международный отдел' );
insert into depart2  values(888, 'Отдел технического контроля' );
insert into depart2  values(999, 'Отдел мониторинга качества' );

---Создаём таблицу «Сотрудники»
create table employees(  
  tabNum   number(3,0) primary key,
  depno    number(5,0),  	
  ename    varchar2(40) NOT NULL,  
  post     varchar2(40),  
  salary   number(10,1) CHECK (salary > 5000),
  born     date,  
  phone    varchar2 (20));


---Заполняем данными таблицу «Сотрудники» 
insert into employees  values(988, 1, 'Рюмин В.П.', 'начальник отдела', 48500, 
'01-FEB-1970','115-26-12');

insert into employees  values(909, 1, 'Серова Т.В.', 'вед. программист', 48500, 
'20-OCT-1981','115-91-19');

insert into employees  values(829, 1, 'Дурова А.В.', 'экономист', 43500, 
'03-OCT-1978','115-26-12');

insert into employees  values(819, 1, 'Тамм Л.В.', 'экономист', 43500, 
'13-NOV-1985','115-91-19');

insert into employees  values(100, 2, 'Волков Л.Д.', 'программист', 46500, 
'16-OCT-1982', NULL);

insert into employees  values(110, 2, 'Буров Г.О.', 'бухгалтер', 42880, 
'22-MAY-1975','115-46-32');

insert into employees  values(023, 2, 'Малова Л.А.', 'гл. бухгалтер', 59240, 
'24-NOV-1954','114-24-55');

insert into employees  values(130, 2, 'Лукина Н.Н.', 'бухгалтер', 42880, 
'1-JUL-1979','115-46-32');

insert into employees  values(034, 3, 'Перова К.В.', 'делопроизводитель', 32000, 
'24-APR-1988', NULL);

insert into employees  values(002, 3, 'Сухова К.А.', 'начальник отдела', 48500, 
'08-JUN-1948','115-12-69');

insert into employees  values(056, 5, 'Павлов А.А.', 'директор', 80000, 
'05-MAY-1968','115-33-44');

insert into employees  values(087, 5, 'Котова И.М.', 'секретарь', 35000, 
'16-SEP-1990','115-33-65');

insert into employees  values(088, 55555, 'Кроль А.П.', 'зам. директора', 70000, 
'18-APR-1974', '115-33-01');

---Создаём таблицу «Дети сотрудников»
CREATE TABLE children (
tabnum  number(3,0) REFERENCES employees(tabnum), 
name VARCHAR(50), 
born DATE,
sex CHAR (10), 
PRIMARY KEY (tabnum, name), /* составной первичный ключ */ 
CHECK (sex IN ('м', 'ж')));

---Заполняем данными таблицу «Дети сотрудников»
insert into children  values (988, 'Вадим', '03-MAY-1995' , 'м');
insert into children  values (110, 'Ольга', '18-JUL-2001' , 'ж');
insert into children  values (023, 'Илья', '19-FEB-1987' , 'м');
insert into children  values (023, 'Анна', '26-DEC-1989' , 'ж');
insert into children  values (909, 'Инна', '25-JAN-2008' , 'ж');
insert into children  values (909, 'Роман', '21-NOV-2006' , 'м');
insert into children  values (909, 'Антон', '06-MAR-2009' , 'м');

-- Выводим таблицу «Сотрудники»
select * from employees;

-- Выводим таблицу «Отделы»
select * from depart;

-- Выводим таблицу «Отделы2»
select * from depart2;

-- Выводим таблицу «Дети сотрудников»
select * from children;

Задания
1) Сколько сотрудников в базе данных?
SELECT COUNT(*) AS Количество_сотрудников FROM employees;
2) Выведите минимальную и максимальную зарплаты по сотрудникам.
SELECT MIN(salary), MAX(salary) FROM employees;
3) Выведите среднюю зарплату у сотрудников 5-го отдела.
SELECT AVG(salary) FROM employees
WHERE depno = 5;
4) Выведите средние заработные платы по каждому отделу.
SELECT AVG(salary) FROM employees
GROUP BY(depno);
5) Сколько сотрудников в каждом отделе?
SELECT depno, COUNT(*) FROM employees
GROUP BY depno;
6) Выведите названия отделов, в которых работают более 3-х сотрудников.
SELECT DISTINCT d.name
FROM employees e NATURAL JOIN depart d
GROUP BY(d.name)
HAVING COUNT(*)>3;
7) Выведите таблицу с двумя колонками. В первой колонке ФИО сотрудника, а во второй имя его ребенка.
SELECT e.ename, c.name
FROM employees e JOIN children c
ON e.tabnum = c.tabnum;
8) Выведите таблицу с двумя колонками. В первой колонке ФИО сотрудника, а во второй количество детей, по которым есть информация в базе данных.
SELECT e.ename, COUNT(c.name)
FROM employees e JOIN children c
ON e.tabnum = c.tabnum
GROUP BY (e.ename);
9) Соедините таблицы «Отделы» и «Отделы2» на основе декартова произведения таблиц.
SELECT *
FROM depart CROSS JOIN depart2;
10) Соедините таблицы «Отделы» и «Сотрудники» по совпадающим полям.
SELECT DISTINCT *
FROM employees e NATURAL JOIN depart d;
11) Объедините в одну таблицу данные из таблиц «Отделы» и «Отделы2» без дублирования одинаковых записей.
SELECT * FROM depart UNION SELECT * FROM depart2;
12) Отобразите названия отделов, которые есть в таблице «Отделы», но отсутствуют в таблице «Отделы2».
SELECT * FROM depart MINUS SELECT * FROM depart2;
13) Отобразите названия отделов, которые есть и в таблице «Отделы» и в таблице «Отделы2»
SELECT * FROM depart INTERSECT SELECT * FROM depart2;
14) Отобразите в одной таблице информацию из таблиц «Отделы» и «Сотрудники». Если в отделе нет сотрудников, то информация о нем отображается в таблице, а в столбцах про сотрудников стоят пропуски (null). Если у сотрудника отсутствует информация об отделе, в котором он работает, то сотрудник не отображается в таблице.
SELECT * FROM depart LEFT JOIN employees
ON depart.depno = employees.depno;
15) Отобразите в одной таблице информацию из таблиц «Отделы» и «Сотрудники». Если у сотрудника отсутствует информация об отделе, в котором он работает, то информация об этом сотруднике отображается в таблице, а в столбцах, содержащих данные об отделах, стоят пропуски (null). Если в отделе отсутствуют сотрудники, то информация о нем не отображается в таблице.
SELECT * FROM depart RIGHT JOIN employees
ON depart.depno = employees.depno;
16) Отобразите в одной таблице информацию об отделах и сотрудниках. В таблице должны присутствовать и отделы, в которых нет сотрудников, и сотрудники, для которых информация об отделах, в которых они числятся, отсутствует в базе данных. Пропущенные ячейки будут помечены как null.
SELECT * FROM depart FULL OUTER JOIN employees
ON depart.depno = employees.depno;
17) Отобразите названия только тех отделов из таблицы «Отделы», в которых есть сотрудники.
SELECT DISTINCT depart.name FROM employees NATURAL JOIN depart;
