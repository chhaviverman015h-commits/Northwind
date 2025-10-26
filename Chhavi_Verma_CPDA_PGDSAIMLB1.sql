/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

SELECT CustomerName FROM Customers;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

SELECT ProductName, Price FROM Products where Price < 15;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

SELECT FirstName, LastName FROM Employees;


-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

SELECT OrderID, OrderDate FROM Orders WHERE YEAR(OrderDate) = 1997;

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

SELECT ProductName, Price FROM Products WHERE Price > 50;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

SELECT DISTINCT
  c.CustomerName,
  e.FirstName,
  e.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;

-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

SELECT
  Country,
  COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Country
ORDER BY CustomerCount DESC;

-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

SELECT
  cat.CategoryName,
  ROUND(AVG(p.Price), 2) AS AvgPrice
FROM Products p
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

SELECT
  EmployeeID,
  COUNT(*) AS OrderCount
FROM Orders
GROUP BY EmployeeID
ORDER BY OrderCount DESC;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

SELECT p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Exotic Liquid';

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

SELECT
  od.ProductID,
  SUM(od.Quantity) AS TotalOrdered
FROM OrderDetails od
GROUP BY od.ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

SELECT
  c.CustomerName,
  SUM(od.Quantity * p.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING TotalSpent > 10000
ORDER BY TotalSpent DESC;

-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

SELECT
  o.OrderID,
  SUM(od.Quantity * p.Price) AS OrderValue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING OrderValue > 2000
ORDER BY OrderValue DESC;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

SELECT
  c.CustomerName,
  t.OrderID,
  t.TotalValue
FROM (
  SELECT
    o.OrderID,
    o.CustomerID,
    SUM(od.Quantity * p.Price) AS TotalValue
  FROM Orders o
  JOIN OrderDetails od ON o.OrderID = od.OrderID
  JOIN Products p ON od.ProductID = p.ProductID
  GROUP BY o.OrderID, o.CustomerID
) t
JOIN Customers c ON t.CustomerID = c.CustomerID
WHERE t.TotalValue = (
  SELECT MAX(s.TotalValue) FROM (
    SELECT SUM(od2.Quantity * p2.Price) AS TotalValue
    FROM Orders o2
    JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
    JOIN Products p2 ON od2.ProductID = p2.ProductID
    GROUP BY o2.OrderID
  ) s
);

-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

SELECT
  p.ProductName
FROM Products p
WHERE p.ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails)
ORDER BY p.ProductName;

