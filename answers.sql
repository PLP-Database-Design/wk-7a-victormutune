-- ============================================
-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- ============================================

-- Original Table: ProductDetail
-- | OrderID | CustomerName  | Products                      |
-- | 101     | John Doe      | Laptop, Mouse                 |
-- | 102     | Jane Smith    | Tablet, Keyboard, Mouse       |
-- | 103     | Emily Clark   | Phone                         |

-- To achieve 1NF, we need to split the 'Products' column into individual products.
-- Each row should represent a single product for each order.

-- SQL Query:
-- Create a new table to store individual products for each order:
-- Example data to insert into the normalized table.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into the normalized table by splitting products
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Now each row represents a single product for an order, achieving 1NF.
-- Example output for ProductDetail_1NF:
-- | OrderID | CustomerName  | Product    |
-- | 101     | John Doe      | Laptop     |
-- | 101     | John Doe      | Mouse      |
-- | 102     | Jane Smith    | Tablet     |
-- | 102     | Jane Smith    | Keyboard   |
-- | 102     | Jane Smith    | Mouse      |
-- | 103     | Emily Clark   | Phone      |


-- ============================================
-- Question 2: Achieving 2NF (Second Normal Form) 🧩
-- ============================================

-- Original Table: OrderDetails (Already in 1NF but with partial dependencies)
-- | OrderID | CustomerName  | Product   | Quantity |
-- | 101     | John Doe      | Laptop    | 2        |
-- | 101     | John Doe      | Mouse     | 1        |
-- | 102     | Jane Smith    | Tablet    | 3        |
-- | 102     | Jane Smith    | Keyboard  | 1        |
-- | 102     | Jane Smith    | Mouse     | 2        |
-- | 103     | Emily Clark   | Phone     | 1        |

-- To achieve 2NF, we need to remove partial dependencies.
-- CustomerName depends on OrderID, but OrderID + Product should be the full primary key.
-- We need to create two tables:
-- 1. A table for OrderDetails that only includes the primary key and product-related data.
-- 2. A table for Customer information, which relates OrderID to CustomerName.

-- SQL Queries:

-- Create a table for customer information (CustomerName should only depend on OrderID):
CREATE TABLE CustomerDetails (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert customer information into the new table:
INSERT INTO CustomerDetails (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Create a table for order details:
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES CustomerDetails(OrderID)
);

-- Insert order details into the new table:
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Now the database is in 2NF:
-- Customer details are stored in CustomerDetails table.
-- Order details (Product and Quantity) are stored in OrderDetails_2NF table, where the full primary key is OrderID + Product.

-- Final Tables:
-- CustomerDetails
-- | OrderID | CustomerName  |
-- | 101     | John Doe      |
-- | 102     | Jane Smith    |
-- | 103     | Emily Clark   |

-- OrderDetails_2NF
-- | OrderID | Product   | Quantity |
-- | 101     | Laptop    | 2        |
-- | 101     | Mouse     | 1        |
-- | 102     | Tablet    | 3        |
-- | 102     | Keyboard  | 1        |
-- | 102     | Mouse     | 2        |
-- | 103     | Phone     | 1        |
