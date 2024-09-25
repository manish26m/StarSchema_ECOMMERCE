-- Step 1: Create the E-commerce Database
CREATE DATABASE E_Commerce_DataWarehouse;

-- Use the newly created database
USE E_Commerce_DataWarehouse;

-- Step 2: Create the Supplier Dimension Table
CREATE TABLE Supplier_Dimension (
    Supplier_ID INT PRIMARY KEY,                  -- Primary Key: Unique identifier for each supplier
    Supplier_Name VARCHAR(255),                   -- Name of the supplier
    Contact_Number VARCHAR(20),                   -- Supplier's contact number
    Email VARCHAR(255),                           -- Supplier's email address
    Location VARCHAR(255)                         -- Location of the supplier
);

-- Create the Product Dimension Table
CREATE TABLE Product_Dimension (
    Product_ID INT PRIMARY KEY,                   -- Primary Key: Unique identifier for each product
    Product_Name VARCHAR(255),                    -- Name of the product
    Category VARCHAR(255),                        -- Category of the product (e.g., Electronics)
    Brand VARCHAR(255),                           -- Brand of the product
    Supplier_ID INT,                              -- Foreign Key: Links to Supplier Dimension
    Price DECIMAL(10, 2),                         -- Price of the product
    Product_Description TEXT,                     -- Description of the product
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier_Dimension(Supplier_ID) -- Links to Supplier Table
);

-- Create the Customer Dimension Table
CREATE TABLE Customer_Dimension (
    Customer_ID INT PRIMARY KEY,                  -- Primary Key: Unique identifier for each customer
    Customer_Name VARCHAR(255),                   -- Name of the customer
    Gender VARCHAR(10),                           -- Gender of the customer
    Age INT,                                      -- Age of the customer
    Location VARCHAR(255),                        -- Customer's location
    Email VARCHAR(255),                           -- Customer's email address
    Phone VARCHAR(20)                             -- Customer's phone number
);

-- Create the Date Dimension Table
CREATE TABLE Date_Dimension (
    Date_ID INT PRIMARY KEY,                      -- Primary Key: Unique identifier for each date
    Date DATE,                                    -- Actual date
    Day INT,                                      -- Day of the month
    Month VARCHAR(20),                            -- Month name
    Quarter VARCHAR(10),                          -- Quarter of the year (e.g., Q1, Q2)
    Year INT,                                     -- Year
    Day_of_Week VARCHAR(20)                       -- Name of the day of the week (e.g., Monday)
);

-- Create the Store Dimension Table
CREATE TABLE Store_Dimension (
    Store_ID INT PRIMARY KEY,                     -- Primary Key: Unique identifier for each store
    Store_Name VARCHAR(255),                      -- Name of the store
    Location VARCHAR(255),                        -- Location of the store
    Manager_Name VARCHAR(255),                    -- Store manager's name
    Store_Type VARCHAR(50)                        -- Type of store (e.g., Retail, Warehouse)
);

-- Create the Sales Fact Table
CREATE TABLE Sales_Fact (
    Transaction_ID INT PRIMARY KEY,               -- Primary Key: Unique identifier for each transaction
    Product_ID INT,                               -- Foreign Key: Links to Product Dimension
    Customer_ID INT,                              -- Foreign Key: Links to Customer Dimension
    Date_ID INT,                                  -- Foreign Key: Links to Date Dimension
    Store_ID INT,                                 -- Foreign Key: Links to Store Dimension
    Quantity INT,                                 -- Number of units sold
    Sales_Amount DECIMAL(10, 2),                  -- Total price of the sale before discount
    Discount DECIMAL(10, 2),                      -- Discount applied to the sale
    Revenue DECIMAL(10, 2),                       -- Final revenue after discount
    FOREIGN KEY (Product_ID) REFERENCES Product_Dimension(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer_Dimension(Customer_ID),
    FOREIGN KEY (Date_ID) REFERENCES Date_Dimension(Date_ID),
    FOREIGN KEY (Store_ID) REFERENCES Store_Dimension(Store_ID)
);
-- Step 3: Insert Sample Data
-- Insert Data into Supplier Dimension
INSERT INTO Supplier_Dimension (Supplier_ID, Supplier_Name, Contact_Number, Email, Location) VALUES
(1, 'TechSupply', '123-456-7890', 'contact@techsupply.com', 'New York'),
(2, 'GadgetWorld', '234-567-8901', 'info@gadgetworld.com', 'California'),
(3, 'ElectronicPlus', '345-678-9012', 'sales@electronicplus.com', 'Texas'),
(4, 'HomeAppliances', '456-789-0123', 'support@homeappliances.com', 'Florida');

-- Insert Data into Product Dimension
INSERT INTO Product_Dimension (Product_ID, Product_Name, Category, Brand, Supplier_ID, Price, Product_Description) VALUES
(1, 'Laptop', 'Electronics', 'Dell', 1, 1200.00, 'High-performance laptop'),
(2, 'Smartphone', 'Electronics', 'Samsung', 2, 800.00, 'Latest model smartphone'),
(3, 'Headphones', 'Accessories', 'Sony', 2, 150.00, 'Noise-cancelling headphones'),
(4, 'Smartwatch', 'Wearables', 'Apple', 3, 400.00, 'Latest model smartwatch'),
(5, 'Tablet', 'Electronics', 'Lenovo', 1, 600.00, 'Portable tablet with a powerful processor');

-- Insert Data into Customer Dimension
INSERT INTO Customer_Dimension (Customer_ID, Customer_Name, Gender, Age, Location, Email, Phone) VALUES
(1, 'John Doe', 'Male', 28, 'New York', 'john.doe@example.com', '123-123-1234'),
(2, 'Jane Smith', 'Female', 34, 'California', 'jane.smith@example.com', '321-321-4321'),
(3, 'Michael Johnson', 'Male', 45, 'Texas', 'michael.johnson@example.com', '987-654-3210'),
(4, 'Emily Davis', 'Female', 29, 'Florida', 'emily.davis@example.com', '567-890-1234'),
(5, 'Robert Brown', 'Male', 37, 'New Jersey', 'robert.brown@example.com', '789-012-3456');


-- Insert Data into Date Dimension
INSERT INTO Date_Dimension (Date_ID, Date, Day, Month, Quarter, Year, Day_of_Week) VALUES
(1, '2024-09-20', 20, 'September', 'Q3', 2024, 'Friday'),
(2, '2024-09-21', 21, 'September', 'Q3', 2024, 'Saturday'),
(3, '2024-09-22', 22, 'September', 'Q3', 2024, 'Sunday'),
(4, '2024-09-23', 23, 'September', 'Q3', 2024, 'Monday');

-- Insert Data into Store Dimension
INSERT INTO Store_Dimension (Store_ID, Store_Name, Location, Manager_Name, Store_Type) VALUES
(1, 'Main Store', 'New York', 'Alice Johnson', 'Retail'),
(2, 'Warehouse', 'California', 'Bob Brown', 'Warehouse'),
(3, 'Outlet Store', 'Texas', 'Charlie White', 'Retail');
-- Insert Data into Sales Fact Table
INSERT INTO Sales_Fact (Transaction_ID, Product_ID, Customer_ID, Date_ID, Store_ID, Quantity, Sales_Amount, Discount, Revenue) VALUES
(1, 1, 1, 1, 1, 2, 2400.00, 200.00, 2200.00),
(2, 2, 2, 2, 2, 1, 800.00, 50.00, 750.00),
(3, 3, 3, 3, 3, 3, 450.00, 30.00, 420.00),
(4, 5, 4, 4, 1, 1, 120.00, 10.00, 110.00);


-- Step 4: Extensive Queries for Data Analysis
-- Retrieve All Sales Transactions

-- Query 1: Retrieve all sales transactions from the Sales Fact table
SELECT * FROM Sales_Fact;

-- Query 2: Join Sales Fact with Product Dimension to get product details for each transaction
SELECT 
    sf.Transaction_ID,                          -- Transaction ID from Sales Fact
    p.Product_Name,                            -- Product Name from Product Dimension
    sf.Quantity,                               -- Quantity sold in each transaction
    sf.Sales_Amount,                           -- Sales amount before discount
    sf.Discount,                               -- Discount applied to the transaction
    sf.Revenue                                 -- Final revenue after discount
FROM 
    Sales_Fact sf
JOIN 
    Product_Dimension p ON sf.Product_ID = p.Product_ID;


-- Query 3: Calculate total revenue generated by each customer
SELECT 
    c.Customer_Name,                           -- Customer's Name
    SUM(sf.Revenue) AS Total_Revenue           -- Total Revenue generated by the customer
FROM 
    Sales_Fact sf
JOIN 
    Customer_Dimension c ON sf.Customer_ID = c.Customer_ID
GROUP BY 
    c.Customer_Name;                           -- Group by Customer Name to aggregate revenue

-- Query 4: Retrieve sales transactions along with the date details
SELECT 
    d.Date,                                    -- Date of the transaction
    sf.Transaction_ID,                         -- Transaction ID
    sf.Revenue                                 -- Revenue from the transaction
FROM 
    Sales_Fact sf
JOIN 
    Date_Dimension d ON sf.Date_ID = d.Date_ID;


-- Query 5: Find top-selling products by the total quantity sold	
SELECT 
    p.Product_Name,                            -- Product Name
    SUM(sf.Quantity) AS Total_Quantity_Sold    -- Total quantity of the product sold
FROM 
    Sales_Fact sf
JOIN 
    Product_Dimension p ON sf.Product_ID = p.Product_ID
GROUP BY 
    p.Product_Name                            -- Group by Product Name
ORDER BY 
    Total_Quantity_Sold DESC;                  -- Order by Total Quantity Sold in descending order

-- Query 6: Calculate total sales, discounts, and net revenue by each store
-- Query 6: Calculate total sales, discounts, and net revenue by each store
SELECT 
    s.Store_Name,                              -- Store Name
    SUM(sf.Sales_Amount) AS Total_Sales,       -- Total Sales amount before discount
    SUM(sf.Discount) AS Total_Discount,        -- Total Discount applied
    SUM(sf.Revenue) AS Net_Revenue             -- Net Revenue after discounts
FROM 
    Sales_Fact sf
JOIN 
    Store_Dimension s ON sf.Store_ID = s.Store_ID
GROUP BY 
    s.Store_Name;                              -- Group by Store Name to aggregate sales data
    
    
-- Step: Drop the E-commerce Database
-- Make sure no one else is connected to the database before dropping it

-- Use this command to drop the database
## DROP DATABASE IF EXISTS E_Commerce_DataWarehouse;

-- This command will permanently delete the database along with all tables and data
-- Make sure to backup any important data before running this command
