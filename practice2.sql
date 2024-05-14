CREATE TABLE schools (
  snum INT PRIMARY KEY, 
  sname VARCHAR(20), 
);

CREATE TABLE pupils (
  pupnum INT PRIMARY KEY, 
  snum INT REFERENCES schools, 
  pupname VARCHAR(50) NOT NULL,
  birth DATE, 
  score NUMERIC(100)
);

CREATE TABLE parents (
  pupnum INT REFERENCES pupils, 
  parname VARCHAR(50),
  sex CHAR(1), 
  CHECK (sex IN ('м', 'ж'))
);


--- Таблица с составным первичным ключом, внешним ключом и двумя правилами проверки значения атрибутов. 
--- Заполнить таблицу данными!!!

CREATE TABLE teachers (
  subject VARCHAR(50),
  snum INT REFERENCES schools,
  PRIMARY KEY (snum, subject),
  teachname VARCHAR(50) NOT NULL,
  category VARCHAR(7),
  CHECK (category IN ('первая', 'высшая')),
  salary NUMBER(10,1)
); 

--- Заполнить таблицы данными (Миша, на тебе)


--- Придумать 10 запросов с оператором SELECT (осталось 7)

SELECT teachname 
FROM teachers
WHERE subject LIKE '%математика%'

SELECT teachname, salary 
FROM teachers
WHERE category LIKE '%высшая%'
ORDER BY salary DESC

SELECT pupname
FROM pupils
WHERE snum == 111

