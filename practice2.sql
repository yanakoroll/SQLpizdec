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
