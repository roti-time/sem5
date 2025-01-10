-- Seller Table
CREATE TABLE Seller (
    seller_id INT PRIMARY KEY
);

-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY
);

-- Product Table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    seller_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_number VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- OrderItem Table
CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Review Table
CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5), -- Constraint added
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Address Table
CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_line VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(10), -- Changed CHAR(10) to VARCHAR(10)
    country VARCHAR(100) NOT NULL,
    billing_flag INT DEFAULT 0, -- Using INT (0 for FALSE, 1 for TRUE)
    shipping_flag INT DEFAULT 0, -- Using INT (0 for FALSE, 1 for TRUE)
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);



-- Inventory Table
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity_in_stock INT NOT NULL,
    reorder_threshold INT,
    unit_cost NUMERIC(10, 2),
    last_stock_update DATE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- DUMMY DATA INSETION

INSERT INTO Seller (seller_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
                                       (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

INSERT INTO Customer (customer_id) VALUES (101), (102), (103), (104), (105), 
                                           (106), (107), (108), (109), (110),
                                           (111), (112), (113), (114), (115),
                                           (116), (117), (118), (119), (120);
INSERT INTO Product (product_id, product_name, price, category, seller_id) 
VALUES 
(1001, 'Laptop', 999.99, 'Electronics', 1),
(1002, 'Smartphone', 699.99, 'Electronics', 2),
(1003, 'Headphones', 59.99, 'Electronics', 3),
(1004, 'TV', 499.99, 'Electronics', 4),
(1005, 'Camera', 299.99, 'Electronics', 5),
(1006, 'Refrigerator', 799.99, 'Appliances', 6),
(1007, 'Washing Machine', 499.99, 'Appliances', 7),
(1008, 'Microwave', 199.99, 'Appliances', 8),
(1009, 'Blender', 49.99, 'Appliances', 9),
(1010, 'Vacuum Cleaner', 149.99, 'Appliances', 10),
(1011, 'Sneakers', 89.99, 'Clothing', 11),
(1012, 'Jacket', 129.99, 'Clothing', 12),
(1013, 'T-shirt', 19.99, 'Clothing', 13),
(1014, 'Jeans', 49.99, 'Clothing', 14),
(1015, 'Hat', 15.99, 'Clothing', 15),
(1016, 'Notebook', 2.99, 'Stationery', 16),
(1017, 'Pen', 0.99, 'Stationery', 17),
(1018, 'Printer', 199.99, 'Electronics', 18),
(1019, 'Tablet', 399.99, 'Electronics', 19),
(1020, 'Monitor', 179.99, 'Electronics', 20);

INSERT INTO Orders (order_id, order_number, customer_id, total_amount, order_date)
VALUES 
(5001, 'ORD001', 101, 1299.99, '2023-10-01'),
(5002, 'ORD002', 102, 699.99, '2023-10-02'),
(5003, 'ORD003', 103, 59.99, '2023-10-03'),
(5004, 'ORD004', 104, 499.99, '2023-10-04'),
(5005, 'ORD005', 105, 129.99, '2023-10-05'),
(5006, 'ORD006', 106, 199.99, '2023-10-06'),
(5007, 'ORD007', 107, 99.99, '2023-10-07'),
(5008, 'ORD008', 108, 799.99, '2023-10-08'),
(5009, 'ORD009', 109, 299.99, '2023-10-09'),
(5010, 'ORD010', 110, 999.99, '2023-10-10'),
(5011, 'ORD011', 111, 49.99, '2023-10-11'),
(5012, 'ORD012', 112, 129.99, '2023-10-12'),
(5013, 'ORD013', 113, 19.99, '2023-10-13'),
(5014, 'ORD014', 114, 179.99, '2023-10-14'),
(5015, 'ORD015', 115, 799.99, '2023-10-15'),
(5016, 'ORD016', 116, 1299.99, '2023-10-16'),
(5017, 'ORD017', 117, 399.99, '2023-10-17'),
(5018, 'ORD018', 118, 49.99, '2023-10-18'),
(5019, 'ORD019', 119, 15.99, '2023-10-19'),
(5020, 'ORD020', 120, 149.99, '2023-10-20');

INSERT INTO OrderItem (order_item_id, order_id, product_id, quantity, price)
VALUES 
(6001, 5001, 1001, 1, 999.99),
(6002, 5002, 1002, 1, 699.99),
(6003, 5003, 1003, 1, 59.99),
(6004, 5004, 1004, 1, 499.99),
(6005, 5005, 1012, 1, 129.99),
(6006, 5006, 1008, 1, 199.99),
(6007, 5007, 1010, 1, 99.99),
(6008, 5008, 1006, 1, 799.99),
(6009, 5009, 1005, 1, 299.99),
(6010, 5010, 1019, 1, 999.99),
(6011, 5011, 1013, 2, 49.99),
(6012, 5012, 1011, 1, 129.99),
(6013, 5013, 1015, 3, 19.99),
(6014, 5014, 1020, 1, 179.99),
(6015, 5015, 1007, 1, 799.99),
(6016, 5016, 1001, 1, 1299.99),
(6017, 5017, 1018, 1, 399.99),
(6018, 5018, 1009, 1, 49.99),
(6019, 5019, 1016, 5, 15.99),
(6020, 5020, 1017, 10, 149.99);

INSERT INTO Review (review_id, customer_id, product_id, review_text, rating)
VALUES 
(7001, 101, 1001, 'Great laptop, highly recommend!', 5),
(7002, 102, 1002, 'Excellent smartphone, very fast.', 5),
(7003, 103, 1003, 'Good value for money.', 4),
(7004, 104, 1004, 'Picture quality could be better.', 3),
(7005, 105, 1012, 'The jacket is warm and comfortable.', 4),
(7006, 106, 1008, 'Works well, no complaints.', 4),
(7007, 107, 1010, 'A bit overpriced for what it offers.', 2),
(7008, 108, 1006, 'Fantastic appliance, energy-efficient.', 5),
(7009, 109, 1005, 'Good camera for beginners.', 4),
(7010, 110, 1019, 'Best tablet I have used so far.', 5),
(7011, 111, 1013, 'Comfortable and cheap.', 5),
(7012, 112, 1011, 'Great design but expensive.', 4),
(7013, 113, 1015, 'Not worth the price.', 2),
(7014, 114, 1020, 'Clear display and decent price.', 4),
(7015, 115, 1007, 'Average washing machine.', 3),
(7016, 116, 1001, 'Highly satisfied, performs well.', 5),
(7017, 117, 1018, 'Good quality and reliable.', 4),
(7018, 118, 1009, 'Affordable but not durable.', 3),
(7019, 119, 1016, 'Works as expected.', 4),
(7020, 120, 1017, 'Cheap but functional.', 3);

INSERT INTO Payment (payment_id, order_id, payment_method, amount, payment_date)
VALUES 
(8001, 5001, 'Credit Card', 1299.99, '2023-10-01'),
(8002, 5002, 'PayPal', 699.99, '2023-10-02'),
(8003, 5003, 'Credit Card', 59.99, '2023-10-03'),
(8004, 5004, 'Debit Card', 499.99, '2023-10-04'),
(8005, 5005, 'Credit Card', 129.99, '2023-10-05'),
(8006, 5006, 'Bank Transfer', 199.99, '2023-10-06'),
(8007, 5007, 'PayPal', 99.99, '2023-10-07'),
(8008, 5008, 'Credit Card', 799.99, '2023-10-08'),
(8009, 5009, 'Credit Card', 299.99, '2023-10-09'),
(8010, 5010, 'PayPal', 999.99, '2023-10-10'),
(8011, 5011, 'Credit Card', 49.99, '2023-10-11'),
(8012, 5012, 'Credit Card', 129.99, '2023-10-12'),
(8013, 5013, 'PayPal', 19.99, '2023-10-13'),
(8014, 5014, 'Debit Card', 179.99, '2023-10-14'),
(8015, 5015, 'Bank Transfer', 799.99, '2023-10-15'),
(8016, 5016, 'Credit Card', 1299.99, '2023-10-16'),
(8017, 5017, 'Credit Card', 399.99, '2023-10-17'),
(8018, 5018, 'PayPal', 49.99, '2023-10-18'),
(8019, 5019, 'Credit Card', 15.99, '2023-10-19'),
(8020, 5020, 'Debit Card', 149.99, '2023-10-20');

INSERT INTO Address (address_id, customer_id, address_line, city, state, zip_code, country, billing_flag, shipping_flag)
VALUES 
(9001, 101, '123 Main St', 'New York', 'NY', '10001', 'USA', 1, 1),
(9002, 102, '456 Maple Ave', 'Los Angeles', 'CA', '90001', 'USA', 1, 1),
(9003, 103, '789 Oak St', 'Chicago', 'IL', '60601', 'USA', 1, 1),
(9004, 104, '321 Pine St', 'Houston', 'TX', '77001', 'USA', 1, 1),
(9005, 105, '654 Cedar Ave', 'Phoenix', 'AZ', '85001', 'USA', 1, 1),
(9006, 106, '987 Spruce St', 'Philadelphia', 'PA', '19019', 'USA', 1, 1),
(9007, 107, '321 Birch Rd', 'San Antonio', 'TX', '78201', 'USA', 1, 1),
(9008, 108, '123 Elm St', 'San Diego', 'CA', '92101', 'USA', 1, 1),
(9009, 109, '456 Walnut Ave', 'Dallas', 'TX', '75201', 'USA', 1, 1),
(9010, 110, '789 Hickory St', 'San Jose', 'CA', '95101', 'USA', 1, 1),
(9011, 111, '321 Palm St', 'Austin', 'TX', '73301', 'USA', 1, 1),
(9012, 112, '654 Cherry Ave', 'Jacksonville', 'FL', '32099', 'USA', 1, 1),
(9013, 113, '987 Ash St', 'Fort Worth', 'TX', '76101', 'USA', 1, 1),
(9014, 114, '321 Redwood Rd', 'Columbus', 'OH', '43004', 'USA', 1, 1),
(9015, 115, '123 Fir St', 'Indianapolis', 'IN', '46201', 'USA', 1, 1),
(9016, 116, '456 Beech Ave', 'Charlotte', 'NC', '28201', 'USA', 1, 1),
(9017, 117, '789 Maple St', 'San Francisco', 'CA', '94101', 'USA', 1, 1),
(9018, 118, '321 Pine Ave', 'Detroit', 'MI', '48201', 'USA', 1, 1),
(9019, 119, '654 Cedar St', 'Memphis', 'TN', '38101', 'USA', 1, 1),
(9020, 120, '987 Spruce Ave', 'Nashville', 'TN', '37201', 'USA', 1, 1);

INSERT INTO Inventory (inventory_id, product_id, quantity_in_stock, reorder_threshold, unit_cost, last_stock_update)
VALUES 
(10001, 1001, 100, 10, 900.00, '2023-09-01'),
(10002, 1002, 150, 15, 600.00, '2023-09-02'),
(10003, 1003, 200, 20, 50.00, '2023-09-03'),
(10004, 1004, 75, 7, 400.00, '2023-09-04'),
(10005, 1012, 50, 5, 100.00, '2023-09-05'),
(10006, 1008, 30, 3, 175.00, '2023-09-06'),
(10007, 1010, 125, 12, 75.00, '2023-09-07'),
(10008, 1006, 80, 8, 700.00, '2023-09-08'),
(10009, 1005, 60, 6, 250.00, '2023-09-09'),
(10010, 1019, 90, 9, 900.00, '2023-09-10'),
(10011, 1013, 200, 20, 15.00, '2023-09-11'),
(10012, 1011, 60, 6, 110.00, '2023-09-12'),
(10013, 1015, 150, 15, 10.00, '2023-09-13'),
(10014, 1020, 100, 10, 150.00, '2023-09-14'),
(10015, 1007, 45, 4, 600.00, '2023-09-15'),
(10016, 1001, 120, 12, 1100.00, '2023-09-16'),
(10017, 1018, 80, 8, 350.00, '2023-09-17'),
(10018, 1009, 75, 7, 45.00, '2023-09-18'),
(10019, 1016, 500, 50, 2.50, '2023-09-19'),
(10020, 1017, 300, 30, 0.75, '2023-09-20');



--Question 3

--Query 1

SELECT COUNT(*) AS total_customers
FROM Customer;

-- Query very significant to understand how many customers you have.

--Query 2

SELECT SUM(total_amount) AS total_spent_by_customers
FROM Orders;

-- Query helps to understand how much paisa you kamai'd

--Query 3

SELECT product_name, category, price, COUNT(*) AS product_count
FROM Product
GROUP BY product_name, category, price;

-- query helps to count inventory

--Query 4

SELECT SUM(price * quantity_in_stock) AS total_value_of_products
FROM Product
JOIN Inventory ON Product.product_id = Inventory.product_id;

-- query tells total value of inventory


--Question 4

SELECT TOP 5 c.customer_id, SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

--Question 5

SELECT TOP 5 p.product_name, AVG(r.rating) AS avg_rating
FROM Product p
JOIN Review r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;


--Question 6

SELECT c.customer_id, COUNT(o.order_id) AS number_of_orders, o.order_date
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, o.order_date
HAVING COUNT(o.order_id) > 1;

--(Q7) Total Revenue for Each Product
SELECT p.product_name, SUM(oi.quantity * oi.price) AS total_revenue
FROM OrderItem oi
JOIN Product p ON oi.product_id = p.product_id
GROUP BY p.product_name;

--Question 8

--Customers Who Have Not Reviewed Any Products
SELECT c.customer_id
FROM Customer c
LEFT JOIN Review r ON c.customer_id = r.customer_id
WHERE r.review_id IS NULL;

--Question 9

--Products with Quantities Below Average Stock
SELECT p.product_name, i.quantity_in_stock
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
WHERE i.quantity_in_stock < (SELECT AVG(quantity_in_stock) FROM Inventory);


--Question 10

--Customers with More Than 5 Orders
SELECT c.customer_id, COUNT(o.order_id) AS number_of_orders
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 5;

--Question 11

--Retrieve the 3 most recent orders for a specific customer:
SELECT TOP 3 o.order_id, o.order_number, o.order_date
FROM Orders o
WHERE o.customer_id = 101
ORDER BY o.order_date DESC;

--Question 12

--Customers Who Purchased from Multiple Sellers
SELECT c.customer_id
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.seller_id) >= 2;

--Question 13

--Customers Who Made Purchases in the Last 30 Days
SELECT c.customer_id
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATEADD(DAY, -30, GETDATE())


--Question 14

--Customers Who Purchased Products in Every Category
SELECT c.customer_id
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.category) = (SELECT COUNT(DISTINCT category) FROM Product);


--Question 15

--Products Sold by Each Seller
SELECT s.seller_id, SUM(oi.quantity) AS total_products_sold
FROM Seller s
JOIN Product p ON s.seller_id = p.seller_id
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY s.seller_id;

--Question 16

--Top 5 Products with Highest Sales in Last Month
SELECT TOP 5 p.product_name, SUM(oi.quantity) AS total_sold
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY p.product_name
ORDER BY total_sold DESC;


--Question 17

--Retrieve the Latest 5 Orders Along with Customer Details and Order Items
SELECT TOP 5 o.order_id, o.order_number, c.customer_id, oi.product_id, oi.quantity, oi.price
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
ORDER BY o.order_date DESC;


--Question 18

--Customers Who Made Purchases in Every Product Category 
--Along with Total Number of Categories

SELECT c.customer_id, COUNT(DISTINCT p.category) AS categories_purchased
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.category) = (SELECT COUNT(DISTINCT category) FROM Product);


--Question 19

--List Products That Have Never Been Reviewed and Have 
--Quantities in Stock Greater than Zero

SELECT p.product_name, i.quantity_in_stock
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
LEFT JOIN Review r ON p.product_id = r.product_id
WHERE r.review_id IS NULL AND i.quantity_in_stock > 0;


--Question 20

--Top 3 Products with Highest Total Sales Including Review Details

SELECT TOP 3 p.product_name, 
       SUM(oi.quantity * oi.price) AS total_sales, 
       COALESCE(CAST(r.review_text AS VARCHAR(MAX)), '') AS review_text, 
       COALESCE(r.rating, 0) AS rating
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
LEFT JOIN Review r ON p.product_id = r.product_id
GROUP BY p.product_name, COALESCE(CAST(r.review_text AS VARCHAR(MAX)), ''), r.rating
ORDER BY total_sales DESC;


--Question 21

--Retrieve All Customers Who Have Placed Orders, Including Orders with 
--No Associated Customers, and Shipping Address Information

SELECT c.customer_id, o.order_id, o.order_number, a.address_line, a.city, a.state
FROM Customer c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Address a ON c.customer_id = a.customer_id
WHERE a.shipping_flag = 1;

--Question 22

--Retrieve the Total Number of Products and Total Revenue
--for Each Product Category, Including Products Not Sold

SELECT p.category, COUNT(p.product_id) AS total_products, COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue
FROM Product p
LEFT JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


--Question 23

--Detailed Information About Products and 
--Their Associated Orders, Filtering by Quantity and Category

SELECT p.product_id, p.product_name, p.category, oi.quantity, oi.price, (oi.quantity * oi.price) AS total_revenue
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE p.category = 'Electronics' AND oi.quantity BETWEEN 5 AND 10
ORDER BY total_revenue DESC;


--Question 24

-- Product Categories with More Than 10 Products Sold, Ordered by Total Sales

SELECT p.category, SUM(oi.quantity) AS total_products_sold
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.category
HAVING SUM(oi.quantity) > 10
ORDER BY total_products_sold DESC;


--Question 25

--Customers with More Than 5 Orders, Ordered by Total Orders

SELECT c.customer_id, COUNT(o.order_id) AS total_orders
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;


