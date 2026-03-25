CREATE DATABASE Personal_Finance_DB;
USE Personal_Finance_DB;

-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100),
    type VARCHAR(50) CHECK (type IN ('Income', 'Expense'))
);

-- Income Table
CREATE TABLE Income (
    income_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    income_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Expenses Table
CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    expense_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Users (user_name, email) VALUES
('Mansi', 'mansi@gmail.com'),
('Shivi', 'shivi@gmail.com'),
('Rohan', 'rohan@gmail.com'),
('Atharv', 'atharv@gmail.com'),
('Aman', 'aman@gmail.com'),
('Priya', 'priya@gmail.com'),
('Rohit', 'rohit@gmail.com'),
('Sneha', 'sneha@gmail.com'),
('Karan', 'karan@gmail.com'),
('Rahul', 'rahul@gmail.com');

INSERT INTO Categories (category_name, type) VALUES
('Salary', 'Income'),
('Freelancing', 'Income'),
('Bonus', 'Income'),
('Food', 'Expense'),
('Rent', 'Expense'),
('Transport', 'Expense'),
('Entertainment', 'Expense'),
('Medical', 'Expense'),
('Utilities', 'Expense'),
('Shopping', 'Expense');

INSERT INTO Income (user_id, category_id, amount, income_date) VALUES
(1, 1, 50000, '2026-02-01'),
(9, 2, 10000, '2026-02-10'),
(2, 1, 45000, '2026-03-01'),
(3, 1, 52000, '2026-03-01'),
(4, 1, 48000, '2026-03-01'),
(5, 1, 15000, '2026-03-10'),
(6, 1, 40000, '2026-03-01'),
(3, 2, 8000, '2026-03-12'),
(8, 2, 12000, '2026-03-15'),
(10, 1, 6000, '2026-03-20'),
(7, 1, 45000, '2026-02-01');

INSERT INTO Expenses (user_id, category_id, amount, expense_date) VALUES
(1, 6, 5000, '2026-02-05'),
(1, 4, 15000, '2026-02-07'),
(1, 5, 3000, '2026-02-12'),
(2, 8, 3500, '2026-03-05'),
(6, 8, 2000, '2026-03-06'),
(3, 4, 12000, '2026-03-07'),
(8, 9, 2500, '2026-03-09'),
(4, 10, 3000, '2026-03-10'),
(5, 9, 4000, '2026-03-12'),
(6, 10, 2200, '2026-03-14'),
(3, 5, 75000, '2026-03-15'),
(7, 8, 1500, '2026-03-16'),
(5, 9, 2700, '2026-03-18'),
(9, 4, 3200, '2026-03-20'),
(10, 6, 4000, '2026-02-06');

-- Monthly Total Income
SELECT MONTH(income_date) AS Month,
       SUM(amount) AS Total_Income
FROM Income
GROUP BY MONTH(income_date);

-- Monthly Total Expenses
SELECT MONTH(expense_date) AS Month,
       SUM(amount) AS Total_Expenses
FROM Expenses
GROUP BY MONTH(expense_date);

-- Category-wise Expense
SELECT c.category_name,
       SUM(e.amount) AS Total_Spent
FROM Expenses e
JOIN Categories c 
ON e.category_id = c.category_id
GROUP BY c.category_name;

-- Monthly Balance (Income - Expense)
SELECT 
    (SELECT SUM(amount) FROM Income WHERE user_id = 1) -
    (SELECT SUM(amount) FROM Expenses WHERE user_id = 1)
    AS Balance;
    
    -- View for Monthly Summary
    CREATE VIEW Monthly_Summary AS
SELECT 
    u.user_id,
    u.user_name,
    SUM(i.amount) AS Total_Income,
    (SELECT SUM(amount) 
     FROM Expenses 
     WHERE user_id = u.user_id) AS Total_Expenses
FROM Users u
JOIN Income i ON u.user_id = i.user_id
GROUP BY u.user_id, u.user_name;

SELECT * FROM Monthly_Summary;

-- Total Income of Each User
SELECT 
u.user_name,
SUM(i.amount) AS Total_Income
FROM Users u
JOIN Income i ON u.user_id = i.user_id
GROUP BY u.user_name;

-- Total Expenses of Each User
SELECT 
u.user_name,
SUM(e.amount) AS Total_Expenses
FROM Users u
JOIN Expenses e ON u.user_id = e.user_id
GROUP BY u.user_name;

-- Category-wise Spending
SELECT 
c.category_name,
SUM(e.amount) AS Total_Spending
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
GROUP BY c.category_name;

-- User Balance (Income - Expense)
SELECT 
u.user_name,
SUM(i.amount) - 
(SELECT SUM(amount) 
 FROM Expenses e 
 WHERE e.user_id = u.user_id) AS Balance
FROM Users u
JOIN Income i ON u.user_id = i.user_id
GROUP BY u.user_id, u.user_name;

-- Highest Expense Transaction
SELECT *
FROM Expenses
ORDER BY amount DESC
LIMIT 1;

-- Top Spending Category
SELECT 
c.category_name,
SUM(e.amount) AS Total_Spent
FROM Expenses e
JOIN Categories c ON e.category_id = c.category_id
GROUP BY c.category_name
ORDER BY Total_Spent DESC
LIMIT 1;