-- ========================================================
-- Project: E-Commerce Order Management System
-- ========================================================

DROP DATABASE IF EXISTS ecommerce_db;
-- Query OK, 0 rows affected, 1 warning (0.106 sec)
CREATE DATABASE ecommerce_db;
-- Query OK, 1 row affected (0.070 sec)
USE ecommerce_db;
-- Database changed

-- --------------------------------------------------------
-- DATABASE SCHEMA DEFINITION
-- --------------------------------------------------------

-- 1. Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);
-- Query OK, 0 rows affected (0.322 sec)

-- 2. Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    added_date DATE NOT NULL,
    CONSTRAINT fk_products_category 
        FOREIGN KEY (category_id) REFERENCES Categories(category_id) 
        ON DELETE SET NULL ON UPDATE CASCADE
);
-- Query OK, 0 rows affected (0.459 sec)

-- 3. Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone_number VARCHAR(20),
    address TEXT,
    registration_date DATE NOT NULL
);
-- Query OK, 0 rows affected (0.242 sec)

-- 4. Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) DEFAULT 0.00,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
        ON DELETE SET NULL ON UPDATE CASCADE
);
-- Query OK, 0 rows affected (0.282 sec)

-- 5. Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    CONSTRAINT fk_items_order 
        FOREIGN KEY (order_id) REFERENCES Orders(order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_items_product 
        FOREIGN KEY (product_id) REFERENCES Products(product_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Query OK, 0 rows affected (0.300 sec)

-- 6. Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'UPI') NOT NULL,
    payment_status ENUM('Paid', 'Pending', 'Failed') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_payments_order 
        FOREIGN KEY (order_id) REFERENCES Orders(order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- Query OK, 0 rows affected (0.233 sec)

-- 7. Shipping Table
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    shipping_date DATE,
    delivery_date DATE,
    shipping_status ENUM('Dispatched', 'In Transit', 'Delivered') NOT NULL,
    CONSTRAINT fk_shipping_order 
        FOREIGN KEY (order_id) REFERENCES Orders(order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- Query OK, 0 rows affected (0.262 sec)


-- ---------------------
-- SAMPLE DATA INSERTION 
-- ---------------------

-- Insert Categories (10 records)
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Footwear'),
(3, 'Apparel'),
(4, 'Home & Kitchen'),
(5, 'Books'),
(6, 'Sports & Fitness'),
(7, 'Beauty & Personal Care'),
(8, 'Toys & Games'),
(9, 'Automotive'),
(10, 'Office Supplies');
-- Query OK, 10 rows affected (0.226 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

-- Insert Products
INSERT INTO Products (product_id, name, category_id, price, stock_quantity, added_date) VALUES
(1, 'Flagship Smartphone Pro', 1, 65000.00, 120, '2023-01-15'),
(2, 'Wireless Noise Cancelling Headphones', 1, 14999.00, 45, '2023-02-10'),
(3, '4K Ultra HD Smart TV 55-inch', 1, 52000.00, 18, '2023-03-05'),
(4, 'Air Cushion Running Shoes', 2, 4500.00, 200, '2023-01-20'),
(5, 'Leather Formal Oxford Shoes', 2, 3800.00, 0, '2023-04-12'), 
(6, '100% Egyptian Cotton Shirt', 3, 2499.00, 350, '2023-02-18'),
(7, 'Stainless Steel Air Fryer', 4, 8500.00, 80, '2023-05-01'),
(8, 'Database System Concepts 7th Edition', 5, 1200.00, 600, '2022-11-10'),
(9, 'Adjustable Dumbbells Set 20kg', 6, 6999.00, 50, '2023-03-22'),
(10, 'Matte Finish Liquid Lipstick', 7, 799.00, 150, '2023-06-15'),
(11, 'Ergonomic Executive Mesh Chair', 10, 11500.00, 30, '2023-07-01'),
(12, 'High-End Mechanical Gaming Keyboard', 1, 8999.00, 75, '2023-08-10');
-- Query OK, 12 rows affected (0.151 sec)
-- Records: 12  Duplicates: 0  Warnings: 0

-- Insert Customers
INSERT INTO Customers (customer_id, name, email, phone_number, address, registration_date) VALUES
(1, '  Aarav Sharma  ', 'aarav.sharma@example.com', '9876543210', '42 MG Road, Bengaluru', '2023-01-10'),
(2, 'Pooja Patel', 'pooja.patel@example.com', '9876543211', '12 SG Highway, Ahmedabad', '2022-11-15'),
(3, '  Rohan Verma', 'rohan.verma@example.com', '9876543212', '78 Park Street, Kolkata', '2023-02-20'),
(4, 'Sneha Iyer  ', NULL, '9876543213', '15 Anna Salai, Chennai', '2023-03-12'),
(5, 'Vikram Singh', 'vikram.singh@example.com', '9876543214', '90 Civil Lines, Jaipur', '2021-08-05'),
(6, 'Neha Kulkarni', 'neha.kulkarni@example.com', '9876543215', '23 FC Road, Pune', '2023-04-18'),
(7, 'Kabir Mehta', 'kabir.mehta@example.com', '9876543216', '5 Marine Drive, Mumbai', '2023-05-22'),
(8, 'Ananya Das', NULL, '9876543217', '34 GS Road, Guwahati', '2022-09-30'),
(9, 'Karan Malhotra', 'karan.m@example.com', '9876543218', '88 Connaught Place, New Delhi', '2023-06-01'),
(10, 'Divya Nair', 'divya.nair@example.com', '9876543219', '19 Panampilly Nagar, Kochi', '2023-06-25'),
(11, 'Rajesh Kumar', 'rajesh.kumar@example.com', '9876543220', '101 VIP Road, Surat', '2023-07-15');
-- Query OK, 11 rows affected (0.149 sec)
-- Records: 11  Duplicates: 0  Warnings: 0

-- Insert Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(101, 1, '2024-01-15', 65000.00, 'Delivered'),
(102, 2, '2024-01-20', 14999.00, 'Delivered'),
(103, 1, '2024-02-10', 4500.00, 'Delivered'),
(104, 3, '2024-02-14', 52000.00, 'Delivered'),
(105, 4, '2024-03-01', 8500.00, 'Shipped'),
(106, 5, '2024-03-05', 2499.00, 'Delivered'),
(107, 1, '2024-03-15', 8500.00, 'Pending'),
(108, 6, '2024-03-20', 6999.00, 'Delivered'),
(109, 7, '2024-04-02', 1200.00, 'Shipped'),
(110, 1, '2024-04-10', 14999.00, 'Delivered'),
(111, 8, '2023-11-05', 799.00, 'Cancelled'),  
(112, 9, '2024-04-12', 11500.00, 'Pending');   
-- Query OK, 12 rows affected (0.141 sec)
-- Records: 12  Duplicates: 0  Warnings: 0

-- Insert Order_Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES
(1, 101, 1, 1, 65000.00),
(2, 102, 2, 1, 14999.00),
(3, 103, 4, 1, 4500.00),
(4, 104, 3, 1, 52000.00),
(5, 105, 7, 1, 8500.00),
(6, 106, 6, 1, 2499.00),
(7, 107, 7, 1, 8500.00),
(8, 108, 9, 1, 6999.00),
(9, 109, 8, 1, 1200.00),
(10, 110, 2, 1, 14999.00),
(11, 111, 10, 1, 799.00),
(12, 112, 11, 1, 11500.00),
(13, 101, 8, 250, 300000.00), 
(14, 102, 4, 210, 945000.00); 
-- Query OK, 14 rows affected (0.165 sec)
-- Records: 14  Duplicates: 0  Warnings: 0

-- Insert Payments 
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status) VALUES
(1, 101, '2024-01-15', 'Credit Card', 'Paid'),
(2, 102, '2024-01-20', 'UPI', 'Paid'),
(3, 103, '2024-02-10', 'PayPal', 'Paid'),
(4, 104, '2024-02-14', 'Credit Card', 'Paid'),
(5, 105, '2024-03-01', 'UPI', 'Paid'),
(6, 106, '2024-03-05', 'PayPal', 'Paid'),
(7, 107, '2024-03-15', 'Credit Card', 'Pending'),
(8, 108, '2024-03-20', 'UPI', 'Paid'),
(9, 109, '2024-04-02', 'Credit Card', 'Paid'),
(10, 110, '2024-04-10', 'UPI', 'Paid'),
(11, 112, '2024-04-12', 'UPI', 'Paid');
-- Query OK, 11 rows affected (0.159 sec)
-- Records: 11  Duplicates: 0  Warnings: 0

-- Insert Shipping 
INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_status) VALUES
(1, 101, '2024-01-16', '2024-01-19', 'Delivered'),
(2, 102, '2024-01-21', '2024-01-24', 'Delivered'),
(3, 103, '2024-02-11', '2024-02-13', 'Delivered'),
(4, 104, '2024-02-15', '2024-02-20', 'Delivered'),
(5, 105, '2024-03-02', NULL, 'In Transit'),
(6, 106, '2024-03-06', '2024-03-09', 'Delivered'),
(7, 108, '2024-03-21', '2024-03-25', 'Delivered'),
(8, 109, '2024-04-03', NULL, 'Dispatched'),
(9, 110, '2024-04-11', '2024-04-14', 'Delivered'),
(10, 111, NULL, NULL, 'Dispatched');
-- Query OK, 10 rows affected (0.138 sec)
-- Records: 10  Duplicates: 0  Warnings: 0


-- ========================
-- TASKS & FUNCTIONALITIES 
-- ========================

-- --------------------------------------------------------
-- Task 1: Implement CRUD Operations
-- --------------------------------------------------------

-- 1.1 Insert new products, customers, and orders
INSERT INTO Products (name, category_id, price, stock_quantity, added_date)
VALUES ('Noise Cancelling Wireless Earbuds', 1, 3999.00, 80, '2024-04-15');
-- Query OK, 1 row affected (0.103 sec)

INSERT INTO Customers (name, email, phone_number, address, registration_date)
VALUES ('Ritu Sen', 'ritu.sen@example.com', '9876543230', '14 Salt Lake, Kolkata', '2024-04-15');
-- Query OK, 1 row affected (0.031 sec)

INSERT INTO Orders (customer_id, order_date, total_amount, status)
VALUES (1, '2024-04-15', 3999.00, 'Pending');
-- Query OK, 1 row affected (0.151 sec)

-- 1.2 Update stock when an order is placed (e.g. order for product_id = 1, quantity = 2)
UPDATE Products 
SET stock_quantity = stock_quantity - 2 
WHERE product_id = 1 AND stock_quantity >= 2;
-- Query OK, 1 row affected (0.064 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

-- 1.3 Delete orders that were cancelled more than 30 days ago
DELETE FROM Orders 
WHERE status = 'Cancelled' 
  AND order_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
-- Query OK, 1 row affected (0.178 sec)


-- --------------------------------------------------------
-- Task 2: Use SQL Clauses (WHERE, HAVING, LIMIT)
-- --------------------------------------------------------

-- 2.1 Find all orders placed in the last 6 months
SELECT * 
FROM Orders 
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
-- Empty set (0.144 sec)

-- 2.2 Get the top 5 highest-priced products
SELECT product_id, name, price 
FROM Products 
ORDER BY price DESC 
LIMIT 5;
+------------+--------------------------------------+----------+
| product_id | name                                 | price    |
+------------+--------------------------------------+----------+
|          1 | Flagship Smartphone Pro              | 65000.00 |
|          3 | 4K Ultra HD Smart TV 55-inch         | 52000.00 |
|          2 | Wireless Noise Cancelling Headphones | 14999.00 |
|         11 | Ergonomic Executive Mesh Chair       | 11500.00 |
|         12 | High-End Mechanical Gaming Keyboard  |  8999.00 |
+------------+--------------------------------------+----------+
-- 5 rows in set (0.143 sec)

-- 2.3 Find customers who have placed more than 3 orders
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 3;
+-------------+------------------+--------------+
| customer_id | name             | total_orders |
+-------------+------------------+--------------+
|           1 |   Aarav Sharma   |            5 |
+-------------+------------------+--------------+
-- 1 row in set (0.167 sec)


-- --------------------------------------------------------
-- Task 3: Apply SQL Operators (AND, OR, NOT)
-- --------------------------------------------------------

-- 3.1 Get all orders where status = 'Pending' AND payment_status = 'Paid'
SELECT o.order_id, o.order_date, o.total_amount, o.status, p.payment_status
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
WHERE o.status = 'Pending' 
  AND p.payment_status = 'Paid';
  +----------+------------+--------------+---------+----------------+
| order_id | order_date | total_amount | status  | payment_status |
+----------+------------+--------------+---------+----------------+
|      112 | 2024-04-12 |     11500.00 | Pending | Paid           |
+----------+------------+--------------+---------+----------------+
-- 1 row in set (0.009 sec)

-- 3.2 Find all products that are NOT out of stock
SELECT product_id, name, stock_quantity, price
FROM Products
WHERE NOT (stock_quantity = 0);
+------------+--------------------------------------+----------------+----------+
| product_id | name                                 | stock_quantity | price    |
+------------+--------------------------------------+----------------+----------+
|          1 | Flagship Smartphone Pro              |            118 | 65000.00 |
|          2 | Wireless Noise Cancelling Headphones |             45 | 14999.00 |
|          3 | 4K Ultra HD Smart TV 55-inch         |             18 | 52000.00 |
|          4 | Air Cushion Running Shoes            |            200 |  4500.00 |
|          6 | 100% Egyptian Cotton Shirt           |            350 |  2499.00 |
|          7 | Stainless Steel Air Fryer            |             80 |  8500.00 |
|          8 | Database System Concepts 7th Edition |            600 |  1200.00 |
|          9 | Adjustable Dumbbells Set 20kg        |             50 |  6999.00 |
|         10 | Matte Finish Liquid Lipstick         |            150 |   799.00 |
|         11 | Ergonomic Executive Mesh Chair       |             30 | 11500.00 |
|         12 | High-End Mechanical Gaming Keyboard  |             75 |  8999.00 |
|         13 | Noise Cancelling Wireless Earbuds    |             80 |  3999.00 |
+------------+--------------------------------------+----------------+----------+
-- 12 rows in set (0.007 sec)

-- 3.3 Retrieve customers who registered after 2022 OR have made purchases above ₹10,000
SELECT DISTINCT c.customer_id, c.name, c.registration_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.registration_date > '2022-12-31' 
   OR o.total_amount > 10000;
+-------------+------------------+-------------------+
| customer_id | name             | registration_date |
+-------------+------------------+-------------------+
|           1 |   Aarav Sharma   | 2023-01-10        |
|           2 | Pooja Patel      | 2022-11-15        |
|           3 |   Rohan Verma    | 2023-02-20        |
|           4 | Sneha Iyer       | 2023-03-12        |
|           6 | Neha Kulkarni    | 2023-04-18        |
|           7 | Kabir Mehta      | 2023-05-22        |
|           9 | Karan Malhotra   | 2023-06-01        |
|          10 | Divya Nair       | 2023-06-25        |
|          11 | Rajesh Kumar     | 2023-07-15        |
|          12 | Ritu Sen         | 2024-04-15        |
+-------------+------------------+-------------------+
-- 10 rows in set (0.137 sec)

-- --------------------------------------------------------
-- Task 4: Sorting & Grouping Data (ORDER BY, GROUP BY)
-- --------------------------------------------------------

-- 4.1 List all products sorted by price in descending order
SELECT product_id, name, price, stock_quantity
FROM Products
ORDER BY price DESC;
+------------+--------------------------------------+----------+----------------+
| product_id | name                                 | price    | stock_quantity |
+------------+--------------------------------------+----------+----------------+
|          1 | Flagship Smartphone Pro              | 65000.00 |            118 |
|          3 | 4K Ultra HD Smart TV 55-inch         | 52000.00 |             18 |
|          2 | Wireless Noise Cancelling Headphones | 14999.00 |             45 |
|         11 | Ergonomic Executive Mesh Chair       | 11500.00 |             30 |
|         12 | High-End Mechanical Gaming Keyboard  |  8999.00 |             75 |
|          7 | Stainless Steel Air Fryer            |  8500.00 |             80 |
|          9 | Adjustable Dumbbells Set 20kg        |  6999.00 |             50 |
|          4 | Air Cushion Running Shoes            |  4500.00 |            200 |
|         13 | Noise Cancelling Wireless Earbuds    |  3999.00 |             80 |
|          5 | Leather Formal Oxford Shoes          |  3800.00 |              0 |
|          6 | 100% Egyptian Cotton Shirt           |  2499.00 |            350 |
|          8 | Database System Concepts 7th Edition |  1200.00 |            600 |
|         10 | Matte Finish Liquid Lipstick         |   799.00 |            150 |
+------------+--------------------------------------+----------+----------------+
-- 13 rows in set (0.007 sec)

-- 4.2 Display the number of orders placed by each customer
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
+-------------+------------------+-------------+
| customer_id | name             | order_count |
+-------------+------------------+-------------+
|           1 |   Aarav Sharma   |           5 |
|           2 | Pooja Patel      |           1 |
|           3 |   Rohan Verma    |           1 |
|           4 | Sneha Iyer       |           1 |
|           5 | Vikram Singh     |           1 |
|           6 | Neha Kulkarni    |           1 |
|           7 | Kabir Mehta      |           1 |
|           8 | Ananya Das       |           0 |
|           9 | Karan Malhotra   |           1 |
|          10 | Divya Nair       |           0 |
|          11 | Rajesh Kumar     |           0 |
|          12 | Ritu Sen         |           0 |
+-------------+------------------+-------------+
-- 12 rows in set (0.009 sec)

-- 4.3 Show total revenue generated per category
SELECT cat.category_id, cat.category_name, COALESCE(SUM(oi.subtotal), 0) AS total_revenue
FROM Categories cat
LEFT JOIN Products p ON cat.category_id = p.category_id
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY cat.category_id, cat.category_name
ORDER BY total_revenue DESC;
+-------------+------------------------+---------------+
| category_id | category_name          | total_revenue |
+-------------+------------------------+---------------+
|           2 | Footwear               |     949500.00 |
|           5 | Books                  |     301200.00 |
|           1 | Electronics            |     146998.00 |
|           4 | Home & Kitchen         |      17000.00 |
|          10 | Office Supplies        |      11500.00 |
|           6 | Sports & Fitness       |       6999.00 |
|           3 | Apparel                |       2499.00 |
|           9 | Automotive             |          0.00 |
|           7 | Beauty & Personal Care |          0.00 |
|           8 | Toys & Games           |          0.00 |
+-------------+------------------------+---------------+
-- 10 rows in set (0.119 sec)

-- --------------------------------------------------------
-- Task 5: Use Aggregate Functions (SUM, AVG, MAX, MIN, COUNT)
-- --------------------------------------------------------

-- 5.1 Find the total revenue generated by the store
SELECT SUM(total_amount) AS total_store_revenue 
FROM Orders 
WHERE status != 'Cancelled';
+---------------------+
| total_store_revenue |
+---------------------+
|           194695.00 |
+---------------------+
-- 1 row in set (0.109 sec)

-- 5.2 Identify the most purchased product (by total quantity sold)
SELECT p.product_id, p.name, SUM(oi.quantity) AS total_units_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_units_sold DESC
LIMIT 1;
+------------+--------------------------------------+------------------+
| product_id | name                                 | total_units_sold |
+------------+--------------------------------------+------------------+
|          8 | Database System Concepts 7th Edition |              251 |
+------------+--------------------------------------+------------------+
-- 1 row in set (0.099 sec)

-- 5.3 Calculate the average order value
SELECT AVG(total_amount) AS average_order_value 
FROM Orders 
WHERE status != 'Cancelled';
+---------------------+
| average_order_value |
+---------------------+
|        16224.583333 |
+---------------------+
-- 1 row in set (0.140 sec)

-- --------------------------------------------------------
-- Task 6: Establish Primary & Foreign Key Relationships
-- --------------------------------------------------------
-- (Explicitly embedded within CREATE TABLE statements above with standard integrity rules:
-- Orders -> Customers, Order_Items -> Orders & Products, Payments -> Orders, Shipping -> Orders)


-- --------------------------------------------------------
-- Task 7: Implement Joins
-- --------------------------------------------------------

-- 7.1 Retrieve a list of products along with their category names using INNER JOIN
SELECT p.product_id, p.name AS product_name, c.category_name, p.price
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id;
+------------+--------------------------------------+------------------------+----------+
| product_id | product_name                         | category_name          | price    |
+------------+--------------------------------------+------------------------+----------+
|          1 | Flagship Smartphone Pro              | Electronics            | 65000.00 |
|          2 | Wireless Noise Cancelling Headphones | Electronics            | 14999.00 |
|          3 | 4K Ultra HD Smart TV 55-inch         | Electronics            | 52000.00 |
|          4 | Air Cushion Running Shoes            | Footwear               |  4500.00 |
|          5 | Leather Formal Oxford Shoes          | Footwear               |  3800.00 |
|          6 | 100% Egyptian Cotton Shirt           | Apparel                |  2499.00 |
|          7 | Stainless Steel Air Fryer            | Home & Kitchen         |  8500.00 |
|          8 | Database System Concepts 7th Edition | Books                  |  1200.00 |
|          9 | Adjustable Dumbbells Set 20kg        | Sports & Fitness       |  6999.00 |
|         10 | Matte Finish Liquid Lipstick         | Beauty & Personal Care |   799.00 |
|         11 | Ergonomic Executive Mesh Chair       | Office Supplies        | 11500.00 |
|         12 | High-End Mechanical Gaming Keyboard  | Electronics            |  8999.00 |
|         13 | Noise Cancelling Wireless Earbuds    | Electronics            |  3999.00 |
+------------+--------------------------------------+------------------------+----------+
-- 13 rows in set (0.010 sec)

-- 7.2 Get all orders with customer details using LEFT JOIN
SELECT o.order_id, o.order_date, o.total_amount, o.status, c.customer_id, c.name, c.email, c.phone_number
FROM Orders o
LEFT JOIN Customers c ON o.customer_id = c.customer_id;
+----------+------------+--------------+-----------+-------------+------------------+---------------------------+--------------+
| order_id | order_date | total_amount | status    | customer_id | name             | email                     | phone_number |
+----------+------------+--------------+-----------+-------------+------------------+---------------------------+--------------+
|      101 | 2024-01-15 |     65000.00 | Delivered |           1 |   Aarav Sharma   | aarav.sharma@example.com  | 9876543210   |
|      102 | 2024-01-20 |     14999.00 | Delivered |           2 | Pooja Patel      | pooja.patel@example.com   | 9876543211   |
|      103 | 2024-02-10 |      4500.00 | Delivered |           1 |   Aarav Sharma   | aarav.sharma@example.com  | 9876543210   |
|      104 | 2024-02-14 |     52000.00 | Delivered |           3 |   Rohan Verma    | rohan.verma@example.com   | 9876543212   |
|      105 | 2024-03-01 |      8500.00 | Shipped   |           4 | Sneha Iyer       | NULL                      | 9876543213   |
|      106 | 2024-03-05 |      2499.00 | Delivered |           5 | Vikram Singh     | vikram.singh@example.com  | 9876543214   |
|      107 | 2024-03-15 |      8500.00 | Pending   |           1 |   Aarav Sharma   | aarav.sharma@example.com  | 9876543210   |
|      108 | 2024-03-20 |      6999.00 | Delivered |           6 | Neha Kulkarni    | neha.kulkarni@example.com | 9876543215   |
|      109 | 2024-04-02 |      1200.00 | Shipped   |           7 | Kabir Mehta      | kabir.mehta@example.com   | 9876543216   |
|      110 | 2024-04-10 |     14999.00 | Delivered |           1 |   Aarav Sharma   | aarav.sharma@example.com  | 9876543210   |
|      112 | 2024-04-12 |     11500.00 | Pending   |           9 | Karan Malhotra   | karan.m@example.com       | 9876543218   |
|      113 | 2024-04-15 |      3999.00 | Pending   |           1 |   Aarav Sharma   | aarav.sharma@example.com  | 9876543210   |
+----------+------------+--------------+-----------+-------------+------------------+---------------------------+--------------+
-- 12 rows in set (0.009 sec)

-- 7.3 Find orders that haven't been shipped using RIGHT JOIN
SELECT o.order_id, o.order_date, o.status, s.shipping_id, s.shipping_status
FROM Shipping s
RIGHT JOIN Orders o ON s.order_id = o.order_id
WHERE s.shipping_id IS NULL;
+----------+------------+---------+-------------+-----------------+
| order_id | order_date | status  | shipping_id | shipping_status |
+----------+------------+---------+-------------+-----------------+
|      107 | 2024-03-15 | Pending |        NULL | NULL            |
|      112 | 2024-04-12 | Pending |        NULL | NULL            |
|      113 | 2024-04-15 | Pending |        NULL | NULL            |
+----------+------------+---------+-------------+-----------------+
-- 3 rows in set (0.136 sec)

-- 7.4 Show customers who have never placed an order using FULL OUTER JOIN
SELECT c.customer_id, c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT c.customer_id, c.name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;
+-------------+--------------+----------+
| customer_id | name         | order_id |
+-------------+--------------+----------+
|           8 | Ananya Das   |     NULL |
|          10 | Divya Nair   |     NULL |
|          11 | Rajesh Kumar |     NULL |
|          12 | Ritu Sen     |     NULL |
+-------------+--------------+----------+
-- 4 rows in set (0.106 sec)

-- --------------------------------------------------------
-- Task 8: Use Subqueries
-- --------------------------------------------------------

-- 8.1 Find orders placed by customers who registered after 2022
SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE customer_id IN (
    SELECT customer_id 
    FROM Customers 
    WHERE registration_date > '2022-12-31'
);
+----------+-------------+------------+--------------+
| order_id | customer_id | order_date | total_amount |
+----------+-------------+------------+--------------+
|      101 |           1 | 2024-01-15 |     65000.00 |
|      103 |           1 | 2024-02-10 |      4500.00 |
|      107 |           1 | 2024-03-15 |      8500.00 |
|      110 |           1 | 2024-04-10 |     14999.00 |
|      113 |           1 | 2024-04-15 |      3999.00 |
|      104 |           3 | 2024-02-14 |     52000.00 |
|      105 |           4 | 2024-03-01 |      8500.00 |
|      108 |           6 | 2024-03-20 |      6999.00 |
|      109 |           7 | 2024-04-02 |      1200.00 |
|      112 |           9 | 2024-04-12 |     11500.00 |
+----------+-------------+------------+--------------+
-- 10 rows in set (0.142 sec)

-- 8.2 Identify the customer who has spent the most
SELECT customer_id, name, email
FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM Orders
    WHERE status != 'Cancelled'
    GROUP BY customer_id
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
);
+-------------+------------------+--------------------------+
| customer_id | name             | email                    |
+-------------+------------------+--------------------------+
|           1 |   Aarav Sharma   | aarav.sharma@example.com |
+-------------+------------------+--------------------------+
-- 1 row in set (0.117 sec)

-- 8.3 Get products that have never been ordered
SELECT product_id, name, price
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM Order_Items 
    WHERE product_id IS NOT NULL
);
+------------+-------------------------------------+---------+
| product_id | name                                | price   |
+------------+-------------------------------------+---------+
|          5 | Leather Formal Oxford Shoes         | 3800.00 |
|         10 | Matte Finish Liquid Lipstick        |  799.00 |
|         12 | High-End Mechanical Gaming Keyboard | 8999.00 |
|         13 | Noise Cancelling Wireless Earbuds   | 3999.00 |
+------------+-------------------------------------+---------+
-- 4 rows in set (0.110 sec)


-- --------------------------------------------------------
-- Task 9: Implement Date & Time Functions
-- --------------------------------------------------------

-- 9.1 Extract the month from order_date to count orders per month
SELECT MONTH(order_date) AS order_month, MONTHNAME(order_date) AS month_name, COUNT(*) AS orders_count
FROM Orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY order_month;
+-------------+------------+--------------+
| order_month | month_name | orders_count |
+-------------+------------+--------------+
|           1 | January    |            2 |
|           2 | February   |            2 |
|           3 | March      |            4 |
|           4 | April      |            4 |
+-------------+------------+--------------+
-- 4 rows in set (0.164 sec)

-- 9.2 Calculate delivery time by finding the difference between shipping_date and delivery_date
SELECT shipping_id, order_id, shipping_date, delivery_date,
       DATEDIFF(delivery_date, shipping_date) AS delivery_time_days
FROM Shipping
WHERE shipping_date IS NOT NULL AND delivery_date IS NOT NULL;
+-------------+----------+---------------+---------------+--------------------+
| shipping_id | order_id | shipping_date | delivery_date | delivery_time_days |
+-------------+----------+---------------+---------------+--------------------+
|           1 |      101 | 2024-01-16    | 2024-01-19    |                  3 |
|           2 |      102 | 2024-01-21    | 2024-01-24    |                  3 |
|           3 |      103 | 2024-02-11    | 2024-02-13    |                  2 |
|           4 |      104 | 2024-02-15    | 2024-02-20    |                  5 |
|           6 |      106 | 2024-03-06    | 2024-03-09    |                  3 |
|           7 |      108 | 2024-03-21    | 2024-03-25    |                  4 |
|           9 |      110 | 2024-04-11    | 2024-04-14    |                  3 |
+-------------+----------+---------------+---------------+--------------------+
-- 7 rows in set (0.112 sec)

-- 9.3 Format order_date as DD-MM-YYYY
SELECT order_id, DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_order_date, total_amount, status
FROM Orders;
+----------+----------------------+--------------+-----------+
| order_id | formatted_order_date | total_amount | status    |
+----------+----------------------+--------------+-----------+
|      101 | 15-01-2024           |     65000.00 | Delivered |
|      102 | 20-01-2024           |     14999.00 | Delivered |
|      103 | 10-02-2024           |      4500.00 | Delivered |
|      104 | 14-02-2024           |     52000.00 | Delivered |
|      105 | 01-03-2024           |      8500.00 | Shipped   |
|      106 | 05-03-2024           |      2499.00 | Delivered |
|      107 | 15-03-2024           |      8500.00 | Pending   |
|      108 | 20-03-2024           |      6999.00 | Delivered |
|      109 | 02-04-2024           |      1200.00 | Shipped   |
|      110 | 10-04-2024           |     14999.00 | Delivered |
|      112 | 12-04-2024           |     11500.00 | Pending   |
|      113 | 15-04-2024           |      3999.00 | Pending   |
+----------+----------------------+--------------+-----------+
-- 12 rows in set (0.117 sec)

-- --------------------------------------------------------
-- Task 10: Use String Manipulation Functions
-- --------------------------------------------------------

-- 10.1 Convert all product names to uppercase
SELECT product_id, UPPER(name) AS uppercase_product_name, price
FROM Products;
+------------+--------------------------------------+----------+
| product_id | uppercase_product_name               | price    |
+------------+--------------------------------------+----------+
|          1 | FLAGSHIP SMARTPHONE PRO              | 65000.00 |
|          2 | WIRELESS NOISE CANCELLING HEADPHONES | 14999.00 |
|          3 | 4K ULTRA HD SMART TV 55-INCH         | 52000.00 |
|          4 | AIR CUSHION RUNNING SHOES            |  4500.00 |
|          5 | LEATHER FORMAL OXFORD SHOES          |  3800.00 |
|          6 | 100% EGYPTIAN COTTON SHIRT           |  2499.00 |
|          7 | STAINLESS STEEL AIR FRYER            |  8500.00 |
|          8 | DATABASE SYSTEM CONCEPTS 7TH EDITION |  1200.00 |
|          9 | ADJUSTABLE DUMBBELLS SET 20KG        |  6999.00 |
|         10 | MATTE FINISH LIQUID LIPSTICK         |   799.00 |
|         11 | ERGONOMIC EXECUTIVE MESH CHAIR       | 11500.00 |
|         12 | HIGH-END MECHANICAL GAMING KEYBOARD  |  8999.00 |
|         13 | NOISE CANCELLING WIRELESS EARBUDS    |  3999.00 |
+------------+--------------------------------------+----------+
-- 13 rows in set (0.034 sec)

-- 10.2 Trim whitespace from customer names
SELECT customer_id, TRIM(name) AS cleaned_customer_name, email
FROM Customers;
+-------------+-----------------------+---------------------------+
| customer_id | cleaned_customer_name | email                     |
+-------------+-----------------------+---------------------------+
|           1 | Aarav Sharma          | aarav.sharma@example.com  |
|           2 | Pooja Patel           | pooja.patel@example.com   |
|           3 | Rohan Verma           | rohan.verma@example.com   |
|           4 | Sneha Iyer            | NULL                      |
|           5 | Vikram Singh          | vikram.singh@example.com  |
|           6 | Neha Kulkarni         | neha.kulkarni@example.com |
|           7 | Kabir Mehta           | kabir.mehta@example.com   |
|           8 | Ananya Das            | NULL                      |
|           9 | Karan Malhotra        | karan.m@example.com       |
|          10 | Divya Nair            | divya.nair@example.com    |
|          11 | Rajesh Kumar          | rajesh.kumar@example.com  |
|          12 | Ritu Sen              | ritu.sen@example.com      |
+-------------+-----------------------+---------------------------+
-- 12 rows in set (0.061 sec)

-- 10.3 Replace missing email values with "Not Provided"
SELECT customer_id, name, COALESCE(email, 'Not Provided') AS display_email
FROM Customers;
+-------------+------------------+---------------------------+
| customer_id | name             | display_email             |
+-------------+------------------+---------------------------+
|           1 |   Aarav Sharma   | aarav.sharma@example.com  |
|           2 | Pooja Patel      | pooja.patel@example.com   |
|           3 |   Rohan Verma    | rohan.verma@example.com   |
|           4 | Sneha Iyer       | Not Provided              |
|           5 | Vikram Singh     | vikram.singh@example.com  |
|           6 | Neha Kulkarni    | neha.kulkarni@example.com |
|           7 | Kabir Mehta      | kabir.mehta@example.com   |
|           8 | Ananya Das       | Not Provided              |
|           9 | Karan Malhotra   | karan.m@example.com       |
|          10 | Divya Nair       | divya.nair@example.com    |
|          11 | Rajesh Kumar     | rajesh.kumar@example.com  |
|          12 | Ritu Sen         | ritu.sen@example.com      |
+-------------+------------------+---------------------------+
-- 12 rows in set (0.007 sec)


-- --------------------------------------------------------
-- Task 11: Implement Window Functions
-- --------------------------------------------------------

-- 11.1 Rank customers based on total spending
SELECT 
    c.customer_id, 
    c.name, 
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(o.total_amount), 0) DESC) AS spending_rank
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
GROUP BY c.customer_id, c.name;
+-------------+------------------+-------------+---------------+
| customer_id | name             | total_spent | spending_rank |
+-------------+------------------+-------------+---------------+
|           1 |   Aarav Sharma   |    96998.00 |             1 |
|           3 |   Rohan Verma    |    52000.00 |             2 |
|           2 | Pooja Patel      |    14999.00 |             3 |
|           9 | Karan Malhotra   |    11500.00 |             4 |
|           4 | Sneha Iyer       |     8500.00 |             5 |
|           6 | Neha Kulkarni    |     6999.00 |             6 |
|           5 | Vikram Singh     |     2499.00 |             7 |
|           7 | Kabir Mehta      |     1200.00 |             8 |
|           8 | Ananya Das       |        0.00 |             9 |
|          10 | Divya Nair       |        0.00 |             9 |
|          11 | Rajesh Kumar     |        0.00 |             9 |
|          12 | Ritu Sen         |        0.00 |             9 |
+-------------+------------------+-------------+---------------+
-- 12 rows in set (0.010 sec)

-- 11.2 Show the cumulative total revenue per month
WITH MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(total_amount) AS monthly_revenue
    FROM Orders
    WHERE status != 'Cancelled'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    order_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY order_month) AS cumulative_revenue
FROM MonthlyRevenue;
+-------------+-----------------+--------------------+
| order_month | monthly_revenue | cumulative_revenue |
+-------------+-----------------+--------------------+
| 2024-01     |        79999.00 |           79999.00 |
| 2024-02     |        56500.00 |          136499.00 |
| 2024-03     |        26498.00 |          162997.00 |
| 2024-04     |        31698.00 |          194695.00 |
+-------------+-----------------+--------------------+
-- 4 rows in set (0.155 sec)

-- 11.3 Display the running total of orders placed
SELECT 
    order_id,
    order_date,
    total_amount,
    COUNT(order_id) OVER (ORDER BY order_date, order_id) AS running_order_count,
    SUM(total_amount) OVER (ORDER BY order_date, order_id) AS running_revenue_total
FROM Orders;
+----------+------------+--------------+---------------------+-----------------------+
| order_id | order_date | total_amount | running_order_count | running_revenue_total |
+----------+------------+--------------+---------------------+-----------------------+
|      101 | 2024-01-15 |     65000.00 |                   1 |              65000.00 |
|      102 | 2024-01-20 |     14999.00 |                   2 |              79999.00 |
|      103 | 2024-02-10 |      4500.00 |                   3 |              84499.00 |
|      104 | 2024-02-14 |     52000.00 |                   4 |             136499.00 |
|      105 | 2024-03-01 |      8500.00 |                   5 |             144999.00 |
|      106 | 2024-03-05 |      2499.00 |                   6 |             147498.00 |
|      107 | 2024-03-15 |      8500.00 |                   7 |             155998.00 |
|      108 | 2024-03-20 |      6999.00 |                   8 |             162997.00 |
|      109 | 2024-04-02 |      1200.00 |                   9 |             164197.00 |
|      110 | 2024-04-10 |     14999.00 |                  10 |             179196.00 |
|      112 | 2024-04-12 |     11500.00 |                  11 |             190696.00 |
|      113 | 2024-04-15 |      3999.00 |                  12 |             194695.00 |
+----------+------------+--------------+---------------------+-----------------------+
-- 12 rows in set (0.010 sec)


-- --------------------------------------------------------
-- Task 12: Apply SQL CASE Expressions
-- --------------------------------------------------------

-- 12.1 Assign a Loyalty_Status to customers:
-- "Gold" if spent > 50,000 | "Silver" if 20,000 - 50,000 | "Bronze" otherwise
SELECT 
    c.customer_id,
    c.name,
    COALESCE(SUM(o.total_amount), 0) AS total_spending,
    CASE 
        WHEN COALESCE(SUM(o.total_amount), 0) > 50000 THEN 'Gold'
        WHEN COALESCE(SUM(o.total_amount), 0) BETWEEN 20000 AND 50000 THEN 'Silver'
        ELSE 'Bronze'
    END AS Loyalty_Status
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id AND o.status != 'Cancelled'
GROUP BY c.customer_id, c.name;
+-------------+------------------+----------------+----------------+
| customer_id | name             | total_spending | Loyalty_Status |
+-------------+------------------+----------------+----------------+
|           1 |   Aarav Sharma   |       96998.00 | Gold           |
|           2 | Pooja Patel      |       14999.00 | Bronze         |
|           3 |   Rohan Verma    |       52000.00 | Gold           |
|           4 | Sneha Iyer       |        8500.00 | Bronze         |
|           5 | Vikram Singh     |        2499.00 | Bronze         |
|           6 | Neha Kulkarni    |        6999.00 | Bronze         |
|           7 | Kabir Mehta      |        1200.00 | Bronze         |
|           8 | Ananya Das       |           0.00 | Bronze         |
|           9 | Karan Malhotra   |       11500.00 | Bronze         |
|          10 | Divya Nair       |           0.00 | Bronze         |
|          11 | Rajesh Kumar     |           0.00 | Bronze         |
|          12 | Ritu Sen         |           0.00 | Bronze         |
+-------------+------------------+----------------+----------------+
-- 12 rows in set (0.103 sec)

-- 12.2 Categorize products:
-- "Best Seller" if sold > 500 units | "Popular" if sold between 200-500 units | "Regular" otherwise
SELECT 
    p.product_id,
    p.name,
    COALESCE(SUM(oi.quantity), 0) AS units_sold,
    CASE 
        WHEN COALESCE(SUM(oi.quantity), 0) > 500 THEN 'Best Seller'
        WHEN COALESCE(SUM(oi.quantity), 0) BETWEEN 200 AND 500 THEN 'Popular'
        ELSE 'Regular'
    END AS Product_Category
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;
+------------+--------------------------------------+------------+------------------+
| product_id | name                                 | units_sold | Product_Category |
+------------+--------------------------------------+------------+------------------+
|          1 | Flagship Smartphone Pro              |          1 | Regular          |
|          2 | Wireless Noise Cancelling Headphones |          2 | Regular          |
|          3 | 4K Ultra HD Smart TV 55-inch         |          1 | Regular          |
|          4 | Air Cushion Running Shoes            |        211 | Popular          |
|          5 | Leather Formal Oxford Shoes          |          0 | Regular          |
|          6 | 100% Egyptian Cotton Shirt           |          1 | Regular          |
|          7 | Stainless Steel Air Fryer            |          2 | Regular          |
|          8 | Database System Concepts 7th Edition |        251 | Popular          |
|          9 | Adjustable Dumbbells Set 20kg        |          1 | Regular          |
|         10 | Matte Finish Liquid Lipstick         |          0 | Regular          |
|         11 | Ergonomic Executive Mesh Chair       |          1 | Regular          |
|         12 | High-End Mechanical Gaming Keyboard  |          0 | Regular          |
|         13 | Noise Cancelling Wireless Earbuds    |          0 | Regular          |
+------------+--------------------------------------+------------+------------------+
-- 13 rows in set (0.011 sec)