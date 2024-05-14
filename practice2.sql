CREATE TABLE school (
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
  teachnum INT, 
  subject VARCHAR(50),
  PRIMARY KEY (teachnum, subject),
  snum INT REFERENCES school,
  teachname VARCHAR(50) NOT NULL,
  category VARCHAR(7),
  CHECK (category IN ('first', 'primary')),
  
); 


--- Заполнить таблицы данными 
--- Придумать 10 запросов с оператором SELECT
