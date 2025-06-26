# Online Bookstore Sales Analysis

This project analyzes sales data for an online bookstore using SQL. By working with books, orders, and customer data, I extracted key business insights such as most popular genres, top-spending customers, remaining stock, and more. The aim was to simulate real-world data analysis that businesses might use to optimize inventory and marketing.

---

## Project Overview

**Objective:**  
To explore and analyze book sales and customer patterns using structured SQL queries.

**Tools Used:**  
- MySQL  
- CSV files (Books, Customers, Orders)  
- SQL (Joins, Aggregations, Filtering, Grouping)

---

## Database Schema

Three tables are created: `Books`, `Customers`, and `Orders`. Each represents a core business entity.

```sql
-- Drop tables if they already exist
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;

-- Books Table
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

-- Customers Table
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- Orders Table
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


# Business Problems and Solutions – Bookstore SQL Project

---

### 1. List All Fiction Books

```sql
SELECT * FROM Books WHERE Genre = 'Fiction';

### 3. List All Movies Released in a Specific Year (e.g., 2020)


---

### **1. All Fiction Books**
```sql
SELECT * FROM Books WHERE Genre = 'Fiction';

**2. Books Published After 1950**

SELECT * FROM Books WHERE Published_Year > 1950;

**3. Customers from Canada**

SELECT * FROM Customers WHERE Country = 'Canada';

#4. Orders Placed in November 2023

SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';
**
5. Total Book Stock Available**

SELECT SUM(Stock) AS Total_Stock FROM Books;

**6. Most Expensive Book**

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

**7. Customers Who Ordered More Than 1 Quantity**

SELECT * FROM Orders WHERE Quantity > 1;
**
8. Orders with Total Amount Over $20**

SELECT * FROM Orders WHERE Total_Amount > 20;

**9. All Available Genres**

SELECT DISTINCT Genre FROM Books;

**10. Book with the Lowest Stock**

SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;

11. Total Revenue Generated from All Orders

SELECT SUM(Total_Amount) AS Revenue FROM Orders;
Advanced Insights

**1. Total Number of Books Sold per Genre**

SELECT b.Genre, SUM(o.Quantity) AS TotalBooks
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY Genre;

**2. Average Price of Fantasy Genre Books**

SELECT AVG(Price) AS averageprice 
FROM Books 
WHERE Genre = 'Fantasy';

**3. Customers Who Placed at Least 2 Orders**grgrgr

SELECT c.Name, o.Customer_ID, COUNT(o.Order_ID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

**4. Most Frequently Ordered Book**

SELECT b.Book_ID, b.Title, COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Orders DESC;

**5. Top 3 Most Expensive Fantasy Books**

SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

**6. Total Quantity of Books Sold by Each Author**

SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

**7. Cities Where Customers Spent Over $30**

SELECT DISTINCT c.City, o.Total_Amount
FROM Orders o
JOIN Customers c ON c.Customer_ID = o.Customer_ID
WHERE Total_Amount > 30 
ORDER BY o.Total_Amount DESC;

**8. Customer Who Spent the Most**

SELECT o.Customer_ID, c.Name, SUM(o.Total_Amount) AS Money_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Money_Spent DESC;

**9. Stock Remaining After Fulfilling Orders**

SELECT b.Book_ID, b.Title, b.Stock,
       COUNT(o.Order_ID) AS Times_Ordered,
       COALESCE(SUM(o.Quantity), 0) AS Order_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Books
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY Remaining_Books DESC;




