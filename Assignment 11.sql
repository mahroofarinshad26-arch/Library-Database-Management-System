CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(200),
    Contact_no VARCHAR(15)
);

DESC Branch;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no)
    REFERENCES Branch(Branch_no)
);
DESC Employee;

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(200),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10,2),
    Status VARCHAR(5),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
DESC Books;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(200),
    Reg_date DATE
);
DESC Customer;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(200),
    Issue_date DATE,
    Isbn_book VARCHAR(20),

    FOREIGN KEY (Issued_cust)
    REFERENCES Customer(Customer_Id),

    FOREIGN KEY (Isbn_book)
    REFERENCES Books(ISBN)
);
DESC IssueStatus;


CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust VARCHAR(100),
    Return_book_name VARCHAR(200),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),

    FOREIGN KEY (Isbn_book2)
    REFERENCES Books(ISBN)
);
DESC ReturnStatus;

INSERT INTO Branch VALUES
(1,101,'Kochi','9876543210'),
(2,102,'Thrissur','9876543211'),
(3,103,'Calicut','9876543212');
SELECT * FROM Branch;

INSERT INTO Employee VALUES
(101,'Rahul','Manager',70000,1),
(102,'Anjali','Manager',68000,2),
(103,'Arun','Manager',72000,3),
(104,'Nikhil','Assistant',45000,1),
(105,'Meera','Librarian',55000,1),
(106,'Akhil','Assistant',40000,2),
(107,'Sneha','Librarian',52000,2),
(108,'Vivek','Assistant',48000,3),
(109,'Neethu','Librarian',60000,3);
SELECT * FROM Employee;

INSERT INTO Books VALUES
('ISBN001','History of India','History',30,'yes','R.S Sharma','NCERT'),
('ISBN002','Database Systems','Education',40,'yes','Korth','McGraw Hill'),
('ISBN003','Python Basics','Education',35,'no','John Smith','Tech Press'),
('ISBN004','World History','History',28,'yes','Peter John','Oxford'),
('ISBN005','Science Today','Science',20,'yes','David Lee','Pearson'),
('ISBN006','Physics Concepts','Science',22,'no','Albert Ray','Pearson'),
('ISBN007','Ancient History','History',32,'yes','R.K Gupta','NCERT');
SELECT * FROM Books;

INSERT INTO Customer VALUES
(1,'Asha','Kochi','2021-05-10'),
(2,'Ravi','Thrissur','2023-01-15'),
(3,'Maya','Calicut','2020-08-20'),
(4,'Arjun','Kochi','2022-09-01'),
(5,'Diya','Kannur','2021-12-15');
SELECT * FROM Customer;

INSERT INTO IssueStatus VALUES
(1,1,'History of India','2023-06-10','ISBN001'),
(2,2,'Database Systems','2023-05-20','ISBN002'),
(3,3,'World History','2023-06-18','ISBN004'),
(4,4,'Python Basics','2024-01-05','ISBN003');
SELECT * FROM IssueStatus;

INSERT INTO ReturnStatus VALUES
(1,'Asha','History of India','2023-07-01','ISBN001'),
(2,'Ravi','Database Systems','2023-06-01','ISBN002');
SELECT * FROM ReturnStatus;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status='yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title,
       c.Customer_name
FROM IssueStatus i
JOIN Books b
ON i.Isbn_book=b.ISBN
JOIN Customer c
ON i.Issued_cust=c.Customer_Id;

SELECT Category,
       COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

SELECT Emp_name,
       Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN
(
SELECT Issued_cust
FROM IssueStatus
);

SELECT Branch_no,
       COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i
ON c.Customer_Id=i.Issued_cust
WHERE MONTH(i.Issue_date)=6
AND YEAR(i.Issue_date)=2023;

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%History%';

SELECT Branch_no,
       COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT e.Emp_name,
       b.Branch_address
FROM Employee e
JOIN Branch b
ON e.Emp_Id=b.Manager_Id;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i
ON c.Customer_Id=i.Issued_cust
JOIN Books b
ON i.Isbn_book=b.ISBN
WHERE b.Rental_Price > 25;