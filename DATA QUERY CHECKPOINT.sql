--CHECKPOINT FOR DATA QUERY LANGUAGE
--creating gomycode_dql database
CREATE DATABASE GOMYCODE_DQL
GO

--access to gomycode_dql database
USE GOMYCODE_DQL
GO

--create table for customer
CREATE TABLE Customers(
  Customer_id INT PRIMARY KEY,
  Name VARCHAR (100) NOT NULL,
  Telephone_No VARCHAR (50) NOT NULL);

--create table for product
CREATE TABLE Products(
  Product_id INT PRIMARY KEY,
  Product_Name VARCHAR (200),
  Category VARCHAR (100),
  Price FLOAT);

--create tables for orders
CREATE TABLE Orders(
  PRIMARY KEY (Customer_id, Product_id),
  Customer_id INT FOREIGN KEY REFERENCES Customers (Customer_id),
  Product_id INT FOREIGN KEY  REFERENCES Products (Product_id),
  Quantity INT NOT NULL,
  Order_Date DATE NOT NULL,
  Unit_Price FLOAT,
  Total_Amount AS (Quantity * Unit_Price)
  );

  --INSERTS 
--Inserts into customer table
INSERT INTO Customers(Customer_id, Name, Telephone_No)
VALUES
(101, 'Alice Johnson', '555-123-4567'),
(102, 'Bob Smith', '555-987-6543'),
(103, 'Carol Lee', '555-555-5555'),
(104, 'David Brown', '555-888-7777'),
(105, 'Eva White', '555-444-3333'),
(106, 'Frank Adams', '555-222-1111'),
(107, 'Grace Miller', '555-666-9999'),
(108, 'Henry Clark', '555-777-8888'),
(109, 'Isabel Garcia', '555-333-2222'),
(110, 'Jack Turner', '555-999-4444'),
(111, 'Karen Hall', '555-111-0000'),
(112, 'Liam Harris', '555-555-7777'),
(113, 'Mia Martinez', '555-888-5555'),
(114, 'Nora Scott', '555-444-7777'),
(115, 'Zara Khan', '555-999-1111');

--Inserts into products table
INSERT INTO Products (Product_id, Product_Name, Category, Price)
VALUES
(201, 'Laptop', 'Gadget', 899.99),
(202, 'Smartphone', 'Gadget', 599.00),
(203, 'Desk Chair', 'Doohickey', 149.99),
(204, 'Headphones', 'Gadget', 79.99),
(205, 'Coffee Maker', 'Widgets', 49.99),
(206, 'Bluetooth Speaker', 'Gadget', 129.99),
(207, 'Fitness Tracker', 'Widgets', 89.99),
(208, 'Wireless Mouse', 'Gadget', 19.99),
(209, 'Plant Pot', 'Doohickey', 24.99),
(210, 'External Hard Drive', 'Widgets', 119.99),
(211, 'Yoga Mat', 'Doohickey', 29.99),
(212, 'Sunglasses', 'Doohickey', 59.99),
(213, 'Cookware Set', 'Doohickey', 199.99),
(214, 'Backpack', 'Widgets', 39.99),
(215, 'Wireless Earbuds', 'Doohickey', 79.99);

--Insert into Orders table
INSERT INTO Orders (Customer_id, Product_id, Order_Date, Quantity, Unit_Price)
VALUES
(101, 201, '2024-05-01', 2, 1799.98),
(102, 202, '2024-05-02', 1, 599.00),
(103, 203, '2024-05-03', 3, 449.97),
(104, 204, '2024-05-04', 2, 159.98),
(105, 205, '2024-05-05', 1, 49.99),
(106, 206, '2024-05-06', 1, 129.99),
(107, 207, '2024-05-07', 2, 179.98),
(108, 208, '2024-05-08', 3, 59.97),
(109, 209, '2024-05-09', 1, 24.99),
(110, 210, '2024-05-10', 1, 119.99),
(111, 211, '2024-05-11', 2, 59.98),
(112, 212, '2024-05-12', 1, 59.99),
(113, 213, '2024-05-13', 1, 199.99),
(114, 214, '2024-05-14', 2, 79.98),
(115, 215, '2024-05-15', 5, 399.95);

--Question 3.
SELECT Name, Category, Total_Amount
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
JOIN Products ON Orders.Product_id = Products.Product_id
WHERE Products.Category IN ('Widgets', 'Gadget') AND Orders.Quantity >= 1
ORDER BY Customers.Name;

--Question 4.
SELECT Name, Category, Total_Amount
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
JOIN Products ON Orders.Product_id = Products.Product_id
WHERE Products.Category IN ('Widgets') AND Orders.Quantity >= 1
ORDER BY Customers.Name;

--Question 5.
SELECT Name, Category, Total_Amount
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
JOIN Products ON Orders.Product_id = Products.Product_id
WHERE Products.Category IN ('Gadget') AND Orders.Quantity >= 1
ORDER BY Customers.Name;

-- Question 6.
SELECT Name, Category, Total_Amount
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
JOIN Products ON Orders.Product_id = Products.Product_id
WHERE Products.Category IN ('Doohickey') AND Orders.Quantity >= 1
ORDER BY Customers.Name;

--Question 7.
SELECT Name, COUNT(Category) AS Category, Total_Amount
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
JOIN Products ON Orders.Product_id = Products.Product_id
WHERE Products.Category IN ('Widgets', 'Gadget')
GROUP BY Name, Total_Amount
ORDER BY Name;

--Question 8.
SELECT Product_Name, SUM(Orders.Product_id) AS Total_id, Quantity
FROM Products
JOIN Orders ON Products.Product_id = Orders.Product_id
WHERE Orders.Product_id >=1
GROUP BY Product_Name, Quantity;

--Question 9.
SELECT Name, COUNT(Orders.Product_id) AS NumberOfOrdersPlaced
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
GROUP BY Name, Product_id
ORDER BY Product_id DESC;

--Question 10.
SELECT Product_Name, COUNT(Orders.Customer_id) AS Number_Of_Orders, Quantity
FROM Products
JOIN Orders ON Products.Product_id = Orders.Product_id
GROUP BY Product_Name, Customer_id, Quantity
ORDER BY Quantity DESC;

--Question 11.
SELECT Customers.Name, COUNT(Order_Date), Product_id
FROM Customers
JOIN Orders ON Customers.Customer_id = Orders.Customer_id
GROUP BY Name, Product_id
HAVING COUNT(Order_Date) = 7;