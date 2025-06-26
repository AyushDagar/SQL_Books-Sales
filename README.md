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



