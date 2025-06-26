#  Online Bookstore Sales Analysis

Welcome to my SQL-powered project where I deep-dived into book sales data for an online bookstore using real-world datasets. From tracking customer habits to uncovering bestselling genres, this project showcases how raw transactional data can be turned into insightful stories 📈.

---

# Project Overview

**Objective:**  
To analyze customer behavior, book sales, and inventory performance of an online bookstore using structured SQL queries.

**Tech Stack:**  
-  MySQL  
-  Excel/CSV datasets  
-  Analytical SQL (joins, group by, aggregate functions, subqueries)

## Database Schema

Three core tables were created:



DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

1️⃣ **Fiction Books**
SELECT * FROM Books WHERE Genre = 'Fiction';

2️⃣ **Books Published After 1950**

SELECT * FROM Books WHERE Published_Year > 1950;

3️⃣ **Customers from Canada**

SELECT * FROM Customers WHERE Country = 'Canada';

4️⃣ **Orders in November 2023**

SELECT * FROM Orders WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

5️⃣ **Total Book Stock Available**

SELECT SUM(Stock) AS Total_Stock FROM Books;

6️⃣ **Most Expensive Book**

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

7️⃣ **Bulk Orders**

SELECT * FROM Orders WHERE Quantity > 1;

8️⃣ **Orders Above $20**

SELECT * FROM Orders WHERE Total_Amount > 20;

9️⃣ **Available Genres**

SELECT DISTINCT Genre FROM Books;

**Advanced Insights**

**1. Books Sold Per Genre**

SELECT b.Genre, SUM(o.Quantity)
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY Genre;

**2. Average Price of Fantasy Books**

SELECT AVG(Price) FROM Books WHERE Genre = 'Fantasy';

**3. Customers with 2+ Orders**

SELECT c.Name, COUNT(o.Order_ID)
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

**4. Most Frequently Ordered Book**

SELECT b.Title, COUNT(*) 
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID
ORDER BY COUNT(*) DESC;

**5. Top Spender**

SELECT c.Name, SUM(o.Total_Amount)
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID
ORDER BY SUM(o.Total_Amount) DESC;

**6. Remaining Inventory**

SELECT b.Title, b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Books
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID;



