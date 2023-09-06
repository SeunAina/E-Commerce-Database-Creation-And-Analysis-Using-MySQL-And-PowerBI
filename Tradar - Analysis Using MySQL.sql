-- SECTION A --

-- Q1 Select customer name together with each order the customer made.
SELECT c.CustomerName, o.OrderID
FROM customers AS c
INNER JOIN orders AS o ON c.CustomerID = o.CustomerID;

-- Q2 Select order id together with name of employee who handled the order.
SELECT concat(FirstName, " ", LastName) AS "Employee's Name", o.OrderID
FROM employees AS e
INNER JOIN orders AS o ON e.EmployeeID = o.EmployeeID;

-- Q3 Select customers who did not placed any order yet.
SELECT c.CustomerName, o.OrderID
FROM customers AS c 
INNER JOIN orders AS o ON c.CustomerID = o.CustomerID
where o.OrderID = null;

-- Q4 Select order id together with the name of products.
SELECT p.ProductName, od.OrderID
FROM products AS p
INNER JOIN order_details AS od ON p.ProductID = od.ProductID;

-- Q5 Select products that no one bought.
SELECT p.ProductName,  od.OrderID
FROM products AS p
INNER JOIN order_details AS od ON p.ProductID = od.ProductID
WHERE  od.OrderID = null;

-- Q6 Select customer together with the products that they bought.
SELECT c.CustomerName, p.ProductName
FROM customers AS c
INNER JOIN orders AS o ON o.CustomerID = c.CustomerID
INNER JOIN order_details AS od ON od.OrderID = o.OrderID
INNER JOIN products AS p ON p.ProductID = od.ProductID;

-- Q7 Select product names together with the name of corresponding category.
SELECT p.ProductName, c.CategoryName
from products AS p 
inner join categories AS c ON p.CategoryID = c.CategoryID;

-- Q8 Select orders together with the name of the shipping company.
SELECT o.OrderID, s.ShipperName
FROM orders AS o 
INNER JOIN shippers AS s ON o.ShipperID = s.ShipperID;

-- Q9 Select customers with id greater than 50 together with each order they made.
SELECT c.CustomerName, c.CustomerID, o.OrderID
FROM customers AS c
INNER JOIN orders AS o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID > 50;

-- Q10 Select employees together with orders with order id greater than 10400.
SELECT concat(FirstName, " ", LastName) as "Employee's Name", e.EmployeeID, o.OrderID
FROM employees AS e 
INNER JOIN orders AS o ON o.EmployeeID = e.EmployeeID
WHERE o.OrderID > 10400;

-- Q11 Select the most expensive product.
SELECT ProductName, ProductID, Price
FROM products
ORDER BY Price desc
LIMIT 1;

-- Q12 Select the second most expensive product
SELECT ProductName, ProductID, Price
FROM products
ORDER BY Price desc
LIMIT 1, 1;

-- Q13 Select name and price of each product, sort the result by price in decreasing order.
SELECT ProductName, Price
FROM products
ORDER BY Price desc;

-- Q14 Select 5 most expensive products.
SELECT ProductName, ProductID, Price
FROM products
ORDER BY Price desc
LIMIT 5;

-- Q15  Select 5 most expensive products without the most expensive (in final 4 products).
SELECT ProductName, ProductID, Price
FROM products
ORDER BY Price desc
LIMIT 1, 4;

-- Q16 . Select name of the cheapest product (only name) without using LIMIT and OFFSET.
SELECT ProductName
FROM products
WHERE price = (SELECT MIN(price) FROM products);

-- Q17 Select name of the cheapest product (only name) using subquery
SELECT ProductName
FROM products
WHERE price = (SELECT MIN(price) FROM products);

-- Q18 Select number of employees with LastName that starts with 'D'.
SELECT count(EmployeeID) AS "Employees"
FROM employees
WHERE LastName LIKE "%D%";

-- Q19 Select customer name together with the number of orders made by the corresponding 
-- customer, sort the result by number of orders in decreasing order.
SELECT c.CustomerName, count(o.OrderID) AS "Numbers Of Orders"
FROM customers AS c
INNER JOIN orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY count(o.OrderID) desc;

-- Q20 Add up the price of all products
SELECT ROUND(SUM(Price)) AS "Total Price Of Products"
FROM products;

-- Q21 Select orderID together with the total price of that Order, order the result by total 
 -- price of order in increasing order.
 SELECT o.OrderID, ROUND(SUM(p.Price)) AS "Total Price Of Order"
 FROM orders AS o
 INNER JOIN order_details AS od ON o.OrderID = od.OrderID
 INNER JOIN products AS p ON od.ProductID = p.ProductID
 GROUP BY 1
 ORDER BY 2 ASC;
 
 -- Q22 Select customer who spend the most money
 SELECT c.ContactName, o.OrderID, ROUND(SUM(p.Price)) as "Money Spent", Country
 FROM customers as c
 INNER JOIN orders as o on o.CustomerID = c.CustomerID
 INNER JOIN order_details as od on o.OrderID = od.OrderID
 INNER JOIN products as p on p.ProductID = od.ProductID
 GROUP BY  2
 ORDER BY 3 DESC
 LIMIT 1;
 
 -- Q23 Select customer who spend the most money and lives in Canada.
 SELECT c.ContactName, o.OrderID, ROUND(SUM(p.Price)) as "Money Spent", c.Country
 FROM customers AS c
 INNER JOIN orders AS o ON o.CustomerID = c.CustomerID
 INNER JOIN order_details AS od ON o.OrderID = od.OrderID
 INNER JOIN products AS p ON p.ProductID = od.ProductID
 WHERE c.Country like "%Canada%"
 GROUP BY 2
 ORDER BY 3 DESC
 LIMIT 1;
 
 -- Q24  Select customer who spend the second most money.
SELECT c.ContactName, o.OrderID, ROUND(SUM(p.Price)) as "Money Spent", Country
 FROM customers as c
 INNER JOIN orders as o on o.CustomerID = c.CustomerID
 INNER JOIN order_details as od on o.OrderID = od.OrderID
 INNER JOIN products as p on p.ProductID = od.ProductID
 GROUP BY 2
 ORDER BY 3 desc
 LIMIT 1, 1;
 
 -- Q25 Select shipper together with the total price of proceed orders
 SELECT s.ShipperName,ROUND(SUM(Price)) as "Total Price Of Proceed Orders"
 FROM shippers  as s
 INNER JOIN orders as o on o.ShipperID = s.ShipperID
 INNER JOIN order_details as od on od.OrderID = o.OrderID
 INNER JOIN products as p on p.ProductID = od.ProductID
 GROUP BY 1
 ORDER BY 2;
 
 -- SECTION B
 
 -- Q1 Total number of products sold so far.
 SELECT count(Quantity) as "Total Products Sold So Far"
 FROM order_details;
 
 -- Q2 Total Revenue So far.
 SELECT SUM(p.Price * od.Quantity) as "Total Revenue So Far"
 FROM products as p
 INNER JOIN order_details as od on p.ProductID = od.ProductID;
 
 -- Q3 Total Unique Products sold based on category.
 SELECT c.CategoryName, count(DISTINCT ProductName) as "Unique Product"
 FROM products as p
 INNER JOIN categories as c on c.CategoryID = p.CategoryID
 GROUP BY 1;
 
 -- Q4 Total Number of Purchase Transactions from customers.
 SELECT count(DISTINCT CustomerID) as "Number Of Purchase"
 FROM customers;
 
 -- Q5 Compare Orders made between 2021 – 2022
SELECT
    COUNT(*) as "Total Orders 2021",
    COUNT(CASE WHEN OrderDate BETWEEN '2022-01-01' AND '2022-12-31' THEN 1 END) as "Total Orders 2022"
FROM orders;

-- Q6 What is total number of customers? Compare those that have made transaction and 
-- those that haven’t at all.
SELECT COUNT(DISTINCT c.CustomerID) as "Total Customer",
COUNT(DISTINCT o.CustomerID) as "Transaction Customer",
COUNT(DISTINCT c.CustomerID) - COUNT(DISTINCT o.CustomerID) AS "Non-Transaction Customer"
FROM customers AS c
LEFT JOIN orders as o on o.CustomerID = c.CustomerID;

-- Q7 Who are the Top 5 customers with the highest purchase value?
SELECT c.CustomerName, ROUND(SUM(p.Price * od.Quantity)) "Total Revenue Generated"
FROM customers AS c 
INNER JOIN orders AS o ON c.CustomerID = o.CustomerID
INNER JOIN order_details AS od ON od.OrderID = o.OrderID
INNER JOIN products AS p ON p.ProductID = od.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q8 Top 5 best-selling products.
SELECT ProductName, SUM(p.Price * od.Quantity) "Total Revenue Generated"
FROM products AS p
JOIN order_details AS od ON od.ProductID = p.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9 What is the Transaction value per month?
SELECT MONTH(OrderDate) AS "Month", ROUND(SUM(p.Price * od.Quantity)) "Toatl Transaction Value"
FROM orders AS o
INNER JOIN order_details AS od ON od.OrderID = o.OrderID
INNER JOIN products AS p ON p.ProductID = od.ProductID
GROUP BY 1
ORDER BY 2 DESC;			

-- Q10  Best Selling Product Category?
 SELECT c.CategoryName, ROUND(SUM(p.Price * od.Quantity)) "Total Revenue Generated"
 FROM products as p
 INNER JOIN categories as c on c.CategoryID = p.CategoryID
 INNER JOIN order_details AS od ON od.ProductID = p.ProductID
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 1;
 

-- Q11 Buyers who have Transacted more than two times.
SELECT CustomerName
FROM customers
GROUP BY 1
HAVING COUNT(CustomerID) > 2;
 
 -- Q12 Most Successful Employee.
SELECT CONCAT(FirstName, " ", LastName) AS "Employee Name", e.EmployeeID, ROUND(SUM(p.Price) AS "Total Sales")
FROM employees AS e
JOIN orders AS o ON o.EmployeeID = e.EmployeeID
JOIN order_details AS od ON od.OrderID = o.OrderID
JOIN products AS p ON p.ProductID = od.ProductID
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;
 
 -- Q13 Most Used Shipper
SELECT s.ShipperName, COUNT(*) AS "Total Order Count"
FROM shippers AS s
JOIN orders AS o ON o.ShipperID = s.ShipperID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
 
 -- Q14 Most Used Supplier
SELECT s.SupplierName,  COUNT(*) AS "Total Order Count"
FROM suppliers AS s
JOIN products AS p ON p.SupplierID =s.SupplierID
JOIN order_details AS od ON od.ProductID = p.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Q15 Revenue By Region
SELECT c.Country,  ROUND(SUM(p.Price * od.Quantity)) "Total Revenue Generated"
FROM customers as c
JOIN orders AS o ON o.CustomerID = c.CustomerID
JOIN order_details AS od ON od.OrderID = o.OrderID
JOIN products AS p ON p.ProductID = od.ProductID
GROUP BY 1
ORDER BY 2 DESC;

-- Q16 Revenue By product Category
SELECT c.CategoryName, ROUND(SUM(p.Price * od.Quantity)) "Total Revenue Generated"
FROM products as p
INNER JOIN categories as c on c.CategoryID = p.CategoryID
INNER JOIN order_details AS od ON od.ProductID = p.ProductID
GROUP BY 1
ORDER BY 2 DESC;

-- Q17 Best Supplier
SELECT s.SupplierName,  SUM(p.Price * od.Quantity) "Total Revenue Generated"
FROM suppliers AS s
JOIN products AS p ON p.SupplierID =s.SupplierID
JOIN order_details AS od ON od.ProductID = p.ProductID
GROUP BY 1
ORDER BY 2 DESC;

-- Q18 Best Shipper
SELECT s.ShipperName,  SUM(p.Price * od.Quantity) "Total Revenue Generated"
FROM shippers AS s
JOIN orders AS o ON o.ShipperID =s.ShipperID
JOIN order_details AS od ON od.OrderID = o.OrderID
JOIN products AS p ON p.ProductID = od.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;











 