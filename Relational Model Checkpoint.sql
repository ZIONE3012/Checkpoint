--1.Convert the given entity-relationship diagram into a relational model.
--The relational model (https://docs.google.com/document/d/1jP81JTZKA3iPORNg-WyPktN6ujgDKKVLndQuXRGD6MM/edit?usp=sharing)

--2. Implement the relational model using SQL
--RELATIONAL DATABASE MANAGEMENT
--create the new database
CREATE DATABASE RDM_CKP
GO

--access the new database
--ACCESS TO RELATIONAL DATABASE MANAGEMENT
USE RDM_CKP
GO

CREATE TABLE Wine(
NumW INT PRIMARY KEY,
Category VARCHAR (100) NOT NULL,
Year INT,
Degree FLOAT);

CREATE TABLE Producers(
NumP INT PRIMARY KEY,
First_name VARCHAR (100),
Last_name VARCHAR (100),
Region VARCHAR (100),
);

CREATE TABLE Harvest(
PRIMARY KEY (NumW, NumP),
NumW INT FOREIGN KEY REFERENCES Wine(NumW),
NumP INT FOREIGN KEY REFERENCES Producers(NumP),
Quantity INT);

--3. Insert data into the database tables.
--INSERT INTO WINE TABLE
INSERT INTO Wine(NumW, Category, Year, Degree)
VALUES
(1, 'Red', 2015, 13.5),
(2, 'White', 2016, 12.0),
(3, 'Rosé', 2017, 11.5),
(4, 'Sparkling', 2014, 12.5),
(5, 'Red', 2018, 14.0),
(6, 'White', 2019, 11.0),
(7, 'Rosé', 2020, 10.5),
(8, 'Rose', 2016, 12.3),
(9, 'Sparkling', 2017, 12.7),
(10, 'Dessert', 2018, 13.9),
(11, 'Red', 2013, 13.2),
(12, 'White', 2014, 12.1),
(13, 'Rose', 2015, 11.9),
(14, 'Sparkling', 2016, 12.6),
(15, 'Dessert', 2017, 14.2),
(16, 'Red', 2012, 13.7),
(17, 'White', 2013, 11.6),
(18, 'Rose', 2014, 12.4),
(19, 'Sparkling', 2015, 12.9),
(20, 'Dessert', 2016, 13.8),
(21, 'Red', 2011, 14.1),
(22, 'White', 2012, 12.2),
(23, 'Rose', 2013, 11.7),
(24, 'Sparkling', 2014, 12.8),
(25, 'Dessert', 2015, 13.6),
(26, 'Red', 2010, 13.4),
(27, 'White', 2011, 11.9),
(28, 'Rose', 2012, 12.5),
(29, 'Sparkling', 2013, 12.4),
(30, 'Dessert', 2014, 14.3);

INSERT INTO Producers (NumP, First_Name, Last_Name, Region)
VALUES
(1, 'John', 'Smith', 'North America'),
(2, 'Jane', 'Doe', 'Europe'),
(3, 'Alice', 'Johnson', 'Asia'),
(4, 'Bob', 'Brown', 'Australia'),
(5, 'Charlie', 'Davis', 'Sousse'),
(6, 'Diana', 'Evans', 'Africa'),
(7, 'Edward', 'Wilson', 'North America'),
(8, 'Fiona', 'White', 'Europe'),
(9, 'George', 'Harris', 'Asia'),
(10, 'Hannah', 'Martin', 'Australia'),
(11, 'Ian', 'Clark', 'Sousse'),
(12, 'Jessica', 'Lee', 'Africa'),
(13, 'Kevin', 'Walker', 'North America'),
(14, 'Laura', 'Scott', 'Europe'),
(15, 'Michael', 'Adams', 'Asia'),
(16, 'Nancy', 'Baker', 'Australia'),
(17, 'Oliver', 'Carter', 'Sousse'),
(18, 'Patricia', 'Mitchell', 'Africa'),
(19, 'Quincy', 'Perez', 'North America'),
(20, 'Rachel', 'Roberts', 'Europe'),
(21, 'Steven', 'Turner', 'Asia'),
(22, 'Tracy', 'Phillips', 'Australia'),
(23, 'Uma', 'Campbell', 'Sousse'),
(24, 'Victor', 'Parker', 'Africa'),
(25, 'Wendy', 'Morris', 'North America'),
(26, 'Xander', 'James', 'Europe'),
(27, 'Yvonne', 'Morgan', 'Asia'),
(28, 'Zachary', 'Reed', 'Australia'),
(29, 'Alicia', 'Price', 'Sousse'),
(30, 'Bruce', 'Coleman', 'Africa');

INSERT INTO Harvest (NumW, NumP, Quantity)
VALUES
(1, 1, 500),
(2, 2, 450),
(3, 3, 520),
(4, 4, 480),
(5, 5, 600),
(6, 6, 550),
(7, 7, 620),
(8, 8, 490),
(9, 9, 510),
(10, 10, 470),
(11, 11, 530),
(12, 12, 560),
(13, 13, 540),
(14, 14, 580),
(15, 15, 590),
(16, 16, 610),
(17, 17, 495),
(18, 18, 505),
(19, 19, 465),
(20, 20, 575),
(21, 21, 600),
(22, 22, 615),
(23, 23, 480),
(24, 24, 495),
(25, 25, 530),
(26, 26, 500),
(27, 27, 550),
(28, 28, 470),
(29, 29, 490),
(30, 30, 515);

--4. Give the list the producers
SELECT * FROM Producers;

--5. Give the list of producers sorted by name
SELECT First_name, Last_name FROM Producers
ORDER BY First_name, Last_name ASC;

--6. Give the list the producers of Sousse
SELECT First_name, Last_name, Region FROM Producers
WHERE REGION = 'SOUSSE';

--7. Calculate the total quantity of wine produced having the number 12
SELECT SUM(Quantity) AS Wine_produced FROM Harvest
WHERE NumW = 12;

--8. Calculate the quantity of wine produced by category.
SELECT COUNT (Quantity) AS Total_Quantity, Category
FROM Harvest
JOIN Wine ON Harvest.NumW = Wine.NumW
GROUP BY Category;

--9. Which producers in the Sousse region have harvested at least one wine in quantities greater than 300 liters? We want the names and first names of the producers, sorted in alphabetical order.
SELECT First_name, Quantity, Category
FROM Producers
JOIN Harvest ON Producers. NumP = Harvest.NumP
JOIN Wine ON Harvest.NumW = Wine.NumW
WHERE Harvest.Quantity >=300
ORDER BY First_name ASC;

--10. List the wine numbers that have a degree greater than 12 and that have been produced by producer number 24
SELECT Wine.NumW, Producers.NumP, Degree
FROM Wine
JOIN Harvest on Wine.NumW = Harvest.NumW
JOIN Producers on Harvest.NumP =Producers.NumP
WHERE Producers.NumP = 24 AND Degree > 12;



