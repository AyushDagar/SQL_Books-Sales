-- Create Database
CREATE DATABASE OnlineBookstore;

USE OnlineBookstore;
-- Create Tables
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




-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';


-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
     SELECT b.Genre ,  sum(o.Quantity) AS TotalBooks
     FROM Books b
     JOIN Orders o
     ON b.Book_ID = o.Book_ID
     GROUP BY Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
     SELECT AVG (Price)  AS averageprice 
     FROM Books 
     WHERE Genre ="Fantasy";
     
-- 3) List customers who have placed at least 2 orders:
     SELECT  c.Name , o. Customer_ID, COUNT(o.Order_id) AS TotalQuantity
     FROM Orders o
     Join  Customers c ON   o.Customer_id =  c.Customer_id
     GROUP BY  o.Customer_id , c.Name
     HAVING COUNT(Order_id) >= 2;
     
  -- 4) Find the most frequently ordered book:
       SELECT b.Book_ID , b.Title,  COUNT(o.Order_id) as Total_Quantity
       FROM Orders o
       Join Books b ON o.Book_ID =b.Book_ID
       GROUP by Book_ID ,b.Title 
       ORDER BY  Total_Quantity DESC; 
  
   -- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
        SELECT * FROM Books 
        WHERE genre ="fantasy"
        ORDER BY Price DESC ;
        
        
--  6) Retrieve the total quantity of books sold by each author:
          
           SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
		   FROM orders o
           JOIN books b ON o.book_id=b.book_id
           GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
       select  DISTINCT c.city , o.Total_Amount
       from Orders o
       JOIN Customers c ON c.Customer_ID = o.Customer_ID
       WHERE Total_Amount > 30 
       ORDER BY O.Total_Amount DESC ;
       
-- 8) Find the customer who spent the most on orders:
       SELECT o.Customer_ID , c.Name , SUM(o.Total_Amount) as MONET_SPENT
       FROM Customers c
       JOIN Orders o ON c.Customer_id = o.Customer_ID
        GROUP BY c.customer_ID , c.Name 
        ORDER BY MONET_SPENT DESC ;
        
-- 9) Calculate the stock remaining after fulfilling all orders:
       SELECT b.book_id , b.title, b.stock , count(o.order_id) as times_ordered ,  coalesce( SUM(o.Quantity) , 0 ) as ORDER_QUANTITY ,
       b.stock - coalesce( SUM(o.Quantity) , 0 ) as REMAINING_BOOKS
        FROM books b
       LEFT join Orders o ON b.Book_id = o.Book_id
       GROUP BY b.BooK_ID 
       order by REMAINING_BOOKS DESC ;
       
       
            
