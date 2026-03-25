# Personal Finance Tracker (SQL Project)

## Project Description
The Personal Finance Tracker is a database project designed to manage and track personal financial activities such as income and expenses. It helps users record their transactions, categorize spending, and analyze their financial data using SQL queries.

## Objectives
- Store financial transaction data
- Track income and expenses
- Analyze spending patterns
- Generate financial summaries using SQL

## Database Tables

### 1. Users
Stores information about users.

Columns:
- user_id (Primary Key)
- user_name
- email

### 2. Categories
Stores different income and expense categories.

Columns:
- category_id (Primary Key)
- category_name
- type (Income / Expense)

### 3. Income
Stores income transactions.

Columns:
- income_id (Primary Key)
- user_id (Foreign Key)
- category_id (Foreign Key)
- amount
- income_date

### 4. Expenses
Stores expense transactions.

Columns:
- expense_id (Primary Key)
- user_id (Foreign Key)
- category_id (Foreign Key)
- amount
- expense_date

## SQL Features Used
- SELECT queries
- JOIN operations
- Aggregate functions (SUM)
- GROUP BY
- Subqueries
- Views
- Stored Procedures
- Functions

## Example Queries
- Total income of each user
- Total expenses of each user
- Monthly income summary
- Category-wise spending
- User balance calculation

## View Example
Monthly financial summary view showing total income and expenses of each user.

## Stored Procedure
A procedure to fetch expenses of a specific user.

## Function
A function to calculate user balance (income - expenses).

## Tools Used
- MySQL Workbench
- GitHub
