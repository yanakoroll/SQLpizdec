CREATE TABLE schools (
  snum NUMERIC(1) PRIMARY KEY, 
  sname VARCHAR(20) 
);

INSERT INTO schools VALUES(1, 'Школа № 763' );
INSERT INTO schools VALUES(2, 'Школа № 123' );
INSERT INTO schools VALUES(3, 'Школа № 245' );

CREATE TABLE pupils (
  pupnum INT PRIMARY KEY, 
  snum INT REFERENCES schools, 
  pupname VARCHAR(50) NOT NULL,
  birth DATE, 
  score NUMERIC(3)
);

INSERT INTO pupils VALUES(1, 1, 'Петров Юрий Борисович', '01-FEB-2004', 99);
INSERT INTO pupils VALUES(2, 1, 'Козлов Иван Петрович', '12-MAR-2002', 85);
INSERT INTO pupils VALUES(3, 2, 'Иванова Анна Сергеевна', '23-APR-2004', 83);
INSERT INTO pupils VALUES(4, 3, 'Селиванова Ольга Петровна', '12-MAY-2005', 100);
INSERT INTO pupils VALUES(5, 3, 'Барсуков Илья Борисович', '13-JUL-2003', 34);
INSERT INTO pupils VALUES(6, 3, 'Сидорова Мария Викторовна', '02-JUN-2001', 56);

CREATE TABLE parents (
  pupnum INT REFERENCES pupils, 
  parname VARCHAR(50),
  sex CHAR(2), 
  CHECK (sex IN ('м','ж'))
);

INSERT INTO parents VALUES (1, 'Петров Борис' , 'м');
INSERT INTO parents VALUES (1, 'Петрова Ольга' , 'ж');
INSERT INTO parents VALUES (2, 'Козлов Пётр' , 'м');
INSERT INTO parents VALUES (2, 'Козлова Инна' , 'ж');
INSERT INTO parents VALUES (3, 'Иванов Сергей' , 'м');
INSERT INTO parents VALUES (3, 'Иванова Алла' , 'ж');
INSERT INTO parents VALUES (4, 'Селиванова Инна' , 'ж');
INSERT INTO parents VALUES (5, 'Барсуков Борис' , 'м');
INSERT INTO parents VALUES (5, 'Кузнецова Ольга' , 'ж');
INSERT INTO parents VALUES (6, 'Сидорова Анна' , 'ж');

--- Таблица с составным первичным ключом, внешним ключом и двумя правилами проверки значения атрибутов. 

CREATE TABLE teachers (
  subject VARCHAR(50),
  snum INT REFERENCES schools,
  PRIMARY KEY (snum, subject),
  teachname VARCHAR(70) NOT NULL,
  category VARCHAR(12),
  CHECK (category IN ('первая','высшая')),
  salary NUMBER(10,1)
); 

--- Заполнить таблицы данными

INSERT INTO teachers VALUES ('Английский язык', 1, 'Незнакомова Инна Геннадьевна' , 'высшая', 100000);
INSERT INTO teachers VALUES ('Математика', 1, 'Терская Светлана Геннадьевна' , 'высшая', 145000);
INSERT INTO teachers VALUES ('Право', 1, 'Овчинников Андрей Алексеевич' , 'высшая', 120000);
INSERT INTO teachers VALUES ('Русский язык', 1, 'Александрова Ирина Адольфовна' , 'высшая', 139000);
INSERT INTO teachers VALUES ('Английский язык', 2, 'Волынец Юлия Павловна' , 'высшая', 160000);
INSERT INTO teachers VALUES ('Математика', 2, 'Кийко Светлана Ивановна' , 'высшая', 150000);
INSERT INTO teachers VALUES ('Право', 2, 'Петров Сергей Иванович' , 'первая', 94000);
INSERT INTO teachers VALUES ('Русский язык', 2, 'Ермолюк Наталья Анатольевна' , 'высшая', 139000);
INSERT INTO teachers VALUES ('Английский язык', 3, 'Барменкова Ольга Ивановна' , 'высшая', 114000);
INSERT INTO teachers VALUES ('Математика', 3, 'Алимова Анна Васильевна' , 'высшая', 84000);
INSERT INTO teachers VALUES ('Право', 3, 'Овчаренко Лина Сергеевна' , 'первая', 90000);
INSERT INTO teachers VALUES ('Русский язык', 3, 'Фурина Елена Викторовна' , 'первая', 73000);

--- Придумать 10 запросов с оператором SELECT

--- 1. Вывести имена всех преподавателей, кто ведет математику

SELECT teachname AS ФИО_Учителя
FROM teachers
WHERE subject LIKE '%Математика%';

--- 2. Вывести имена всех преподавателей высшей категории с сортировкой по заработной плате в порядке убывания

SELECT teachname AS ФИО_учителя, salary AS Заработная_плата
FROM teachers
WHERE category LIKE '%высшая%'
ORDER BY salary DESC;

--- 3. Вывести имена всех учеников, кто учится в 1 школе

SELECT pupname AS ФИО_ученика
FROM pupils
WHERE snum = 1;

--- 4. Вывести имена учителей, преподаваемый ими предмет и номер школы, в которых они работают при условии, что категория учителей - первая.

SELECT t.teachname AS ФИО_учителя, t.subject AS Предмет, t.snum AS Номер_школы
FROM teachers t
JOIN schools s ON s.snum = t.snum
WHERE t.category LIKE '%первая%';

--- 5. Выбор средний балл учеников по школе

SELECT p.snum AS Номер_школы,
    AVG(score) AS Средний_балл
FROM pupils p
GROUP BY p.snum;

--- 6. Вывести минимальный и наибольший день рождения в каждой из школ

SELECT MIN(birth) AS Минимальный_день_рождения, MAX(birth) AS Максимальный_день_рождения, snum AS Номер_школы
FROM pupils
GROUP BY snum;

--- 7. Вывести минимальный и наибольший балл в каждой из школ

SELECT MIN(score) AS Минимальный_балл, MAX(score) AS Максимальный_балл, snum AS Номер_школы
FROM pupils
GROUP BY snum;

--- 8. Вывести сумму выплаченных заработных плат по школам (после налога)

SELECT SUM(salary*0.87) AS Чистая_ЗП, snum AS Номер_школы
FROM teachers
GROUP BY snum;

--- 9. Вывести ФИО ученика и имя его отца

SELECT pup.pupname AS Имя_ученика, par.parname AS Имя_отца
FROM pupils pup
JOIN parents par ON pup.pupnum = par.pupnum
WHERE par.sex = 'м';

--- 10. Вывести ФИО ученика, название школы, в котором он учится и балл в порядке его возрастания

SELECT pup.pupname AS Имя_ученика, pup.score AS Баллы, s.sname AS Название_школы
FROM pupils pup
JOIN schools s ON pup.snum = s.snum
ORDER BY pup.score;


SELECT pupname
FROM pupils
WHERE snum == 111

