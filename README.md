# 🛒 E-Commerce Order Management System

![MySQL](https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge\&logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Advanced-orange?style=for-the-badge)
![Database](https://img.shields.io/badge/Database-E--Commerce-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

> 📦 A practical **E-Commerce Order Management System** built with **MySQL** to manage products, customers, orders, payments, shipping, and sales-related data.

---

## 📌 Project Overview

The **E-Commerce Order Management System** is a relational database project designed to simulate the core operations of an online shopping platform.

The database manages:

* 🏷️ Product categories
* 📦 Products and inventory
* 👤 Customer information
* 🛍️ Customer orders
* 🧾 Order items
* 💳 Payments
* 🚚 Shipping and delivery

The project focuses on applying **real-world SQL concepts** to retrieve, manipulate, analyze, and organize e-commerce data.

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Design a structured relational database
* Establish relationships between multiple tables
* Manage customer and product information
* Track orders and order items
* Monitor payments and shipping
* Analyze sales and customer behavior
* Practice advanced SQL queries
* Generate useful business insights from database records

---

## 🗄️ Database Architecture

The system consists of **7 interconnected tables**:

```text
                    ┌─────────────────┐
                    │    Categories   │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │     Products    │
                    └────────┬────────┘
                             │
                             ▼
┌─────────────────┐   ┌─────────────────┐
│    Customers    │──▶│      Orders     │
└─────────────────┘   └────────┬────────┘
                               │
                  ┌────────────┼────────────┐
                  ▼            ▼            ▼
          ┌─────────────┐ ┌───────────┐ ┌────────────┐
          │ Order_Items │ │ Payments  │ │  Shipping  │
          └─────────────┘ └───────────┘ └────────────┘
```

### 🔗 Table Relationships

| Table            | Purpose                                               |
| ---------------- | ----------------------------------------------------- |
| 🏷️ `Categories` | Stores product category information                   |
| 📦 `Products`    | Stores product details, pricing, and inventory        |
| 👤 `Customers`   | Stores customer information                           |
| 🛍️ `Orders`     | Stores customer orders and order status               |
| 🧾 `Order_Items` | Stores products and quantities associated with orders |
| 💳 `Payments`    | Stores payment information and status                 |
| 🚚 `Shipping`    | Stores shipping and delivery information              |

The project uses **Primary Keys and Foreign Keys** to maintain relationships and data integrity.

---

## 📊 Sample Dataset

The database includes realistic sample data for testing and analysis.

| Entity         | Sample Records |
| -------------- | -------------: |
| 🏷️ Categories |             10 |
| 📦 Products    |   12 initially |
| 👤 Customers   |   11 initially |
| 🛍️ Orders     |   12 initially |
| 🧾 Order Items |             14 |
| 💳 Payments    |             11 |
| 🚚 Shipping    |             10 |

Additional records are also created during the CRUD exercises.

---

# 🚀 Features & SQL Tasks

## 1️⃣ CRUD Operations

Demonstrates fundamental database operations:

* ➕ Adding new products
* 👤 Adding new customers
* 🛍️ Creating orders
* 🔄 Updating product inventory
* 🗑️ Removing old cancelled orders

This section demonstrates practical database management operations.

---

## 2️⃣ SQL Clauses

The project demonstrates:

* `WHERE`
* `HAVING`
* `LIMIT`
* `ORDER BY`
* `GROUP BY`

Example analyses include:

* 📅 Finding recent orders
* 💰 Identifying the highest-priced products
* 👥 Finding customers with multiple orders

---

## 3️⃣ SQL Operators

The project applies:

* `AND`
* `OR`
* `NOT`

These are used to filter data based on multiple business conditions.

Examples include:

* Pending orders with paid payments
* Products that are currently in stock
* Customers meeting registration or purchase conditions

---

## 4️⃣ 📈 Sorting & Grouping

The database performs analytical operations such as:

* Sorting products by price
* Counting orders per customer
* Calculating revenue by category
* Grouping and summarizing e-commerce data

---

## 5️⃣ 🧮 Aggregate Functions

The project demonstrates:

| Function  | Purpose                       |
| --------- | ----------------------------- |
| `SUM()`   | Calculate total revenue       |
| `AVG()`   | Calculate average order value |
| `MAX()`   | Find maximum values           |
| `MIN()`   | Find minimum values           |
| `COUNT()` | Count records                 |

Example business insights include:

* 💰 Total store revenue
* 🏆 Most purchased product
* 📊 Average order value

---

## 6️⃣ 🔗 SQL Joins

Multiple types of joins are demonstrated:

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* Simulated `FULL OUTER JOIN`

These queries connect related information across customers, products, orders, and shipping records.

Examples include:

* 📦 Products with category names
* 👤 Orders with customer details
* 🚚 Orders without shipping records
* 👥 Customers who never placed an order

---

## 7️⃣ 🔍 Subqueries

Subqueries are used to answer more advanced business questions.

Examples include:

* 👤 Orders from recently registered customers
* 🏆 Customer with the highest spending
* 📦 Products that have never been ordered

---

## 8️⃣ 📅 Date & Time Functions

The project demonstrates date-based analysis using functions for:

* Extracting months
* Counting monthly orders
* Calculating delivery duration
* Formatting order dates

This helps analyze **order trends and delivery performance**.

---

## 9️⃣ 🔤 String Manipulation

String functions are used for data cleaning and formatting.

Examples include:

* Converting product names to uppercase
* Removing unnecessary whitespace from customer names
* Handling missing email values

Functions demonstrated include:

* `UPPER()`
* `TRIM()`
* `COALESCE()`

---

# 🪟 1️⃣0️⃣ Window Functions

Advanced analytical queries are implemented using window functions.

### 🏆 Customer Spending Ranking

Customers can be ranked according to their total spending.

### 📈 Cumulative Revenue

Monthly revenue can be analyzed using cumulative totals.

### 🛍️ Running Order Statistics

The project calculates:

* Running order count
* Running revenue total

These techniques are useful for business dashboards and analytics systems.

---

# 🏷️ 1️⃣1️⃣ CASE Expressions

Conditional logic is used to categorize e-commerce data.

### 👑 Customer Loyalty

Customers are classified into:

* 🥇 Gold
* 🥈 Silver
* 🥉 Bronze

based on their spending.

### 📦 Product Performance

Products are classified as:

* ⭐ Best Seller
* 🔥 Popular
* 📦 Regular

based on units sold.

This demonstrates how SQL can transform raw database information into meaningful business categories.

---

# 💼 Business Questions Answered

This project can help answer questions such as:

* 💰 What is the total store revenue?
* 🏆 Which customer spends the most?
* 📦 Which product has sold the most units?
* 🏷️ Which category generates the highest revenue?
* 👤 Which customers have placed the most orders?
* 🚚 Which orders have not been shipped?
* 📦 Which products have never been ordered?
* 📅 How many orders are placed each month?
* ⏱️ How long does delivery take?
* 🥇 Which customers are Gold-level customers?
* 📈 How does revenue accumulate over time?

---

# 🧠 SQL Concepts Demonstrated

### Basic SQL

* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`
* `WHERE`
* `ORDER BY`
* `LIMIT`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `MAX()`
* `MIN()`
* `GROUP BY`
* `HAVING`

### Relationships

* Primary Keys
* Foreign Keys
* Referential Integrity
* Cascading actions

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* Full Outer Join simulation

### Advanced SQL

* Subqueries
* Window Functions
* Common Table Expressions
* `CASE`
* Date & Time Functions
* String Functions
* `COALESCE()`

---

# 🛠️ Technology Stack

| Technology              | Purpose                           |
| ----------------------- | --------------------------------- |
| 🐬 **MySQL**            | Relational Database               |
| 💻 **SQL**              | Database Query Language           |
| 🗃️ **MySQL Workbench** | Database Development & Testing    |
| 🐙 **GitHub**           | Version Control & Project Hosting |

---

# 🚀 Getting Started

## 1. Install MySQL

Install **MySQL Server** and optionally **MySQL Workbench**.

## 2. Open the SQL Project

Open the provided SQL project in your MySQL environment.

## 3. Execute the Database Setup

Run the SQL script to:

* Create the database
* Create all required tables
* Establish relationships
* Insert sample data
* Execute the project tasks

## 4. Explore the Queries

Run the individual queries to explore the different SQL concepts and business analyses demonstrated in the project.

---

# 🎓 Learning Outcomes

This project helped demonstrate practical knowledge of:

* 🗄️ Relational database design
* 🔗 Database relationships
* 🔑 Primary and foreign keys
* ✏️ CRUD operations
* 🔎 Data filtering
* 📊 Data aggregation
* 🔗 SQL joins
* 🧠 Subqueries
* 📅 Date manipulation
* 🔤 String manipulation
* 🪟 Window functions
* 🏷️ Conditional logic
* 📈 Business-oriented data analysis

---

# 🔮 Future Improvements

Possible future enhancements include:

* 🌐 Build a web-based e-commerce application
* 🔐 Add customer authentication
* 💳 Integrate real payment processing
* 📊 Create a sales analytics dashboard
* 📦 Add automated inventory management
* 🚚 Implement advanced shipment tracking
* 📧 Add order confirmation notifications
* 📈 Add more advanced business analytics
* ⚡ Optimize database performance with indexes

---

# ⭐ Why This Project?

This project goes beyond basic SQL syntax and demonstrates how relational databases can be used to model and analyze a **real-world e-commerce workflow**.

It showcases practical SQL skills that are useful for:

* 💻 Database Development
* 📊 Data Analytics
* 🧑‍💻 Backend Development
* 📈 Business Intelligence
* 🗄️ Database Administration

---

# 👨‍💻 Author

**Kush Bhatt**

⭐ If you found this project useful, consider giving the repository a star!

---

## 📄 License

This project is created for **educational and learning purposes**.
