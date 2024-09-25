
# E-commerce Data Warehouse - README

## Introduction
This project is an implementation of a **Data Warehouse** for an e-commerce platform using the **Star Schema** approach. The data warehouse contains five dimension tables and a fact table, designed to support extensive data mining queries for sales analysis.

---

## 📁 Project Structure

1. **Supplier Dimension**  
   ↳ Contains information about the suppliers of products.
   
2. **Product Dimension**  
   ↳ Holds details of each product, including price, category, and supplier information.
   
3. **Customer Dimension**  
   ↳ Stores customer demographics like name, age, and location.
   
4. **Date Dimension**  
   ↳ Captures the date and time-related details of sales transactions.
   
5. **Store Dimension**  
   ↳ Contains data about the stores where transactions occurred.

6. **Sales Fact Table**  
   ↳ Records transactional data, including product, customer, and store information along with sales amount, discount, and revenue.

---

## 📋 Steps to Set Up the Database

### ➡️ **Step 1: Create the Database**

```sql
CREATE DATABASE E_Commerce_DataWarehouse;
USE E_Commerce_DataWarehouse;
```

### ➡️ **Step 2: Create Dimension and Fact Tables**

Create tables for Supplier, Product, Customer, Date, Store dimensions, and the Sales Fact table:

```sql
CREATE TABLE Supplier_Dimension (...);  -- Create Supplier Table
CREATE TABLE Product_Dimension (...);   -- Create Product Table
CREATE TABLE Customer_Dimension (...);  -- Create Customer Table
CREATE TABLE Date_Dimension (...);      -- Create Date Table
CREATE TABLE Store_Dimension (...);     -- Create Store Table
CREATE TABLE Sales_Fact (...);          -- Create Sales Fact Table
```

---

## 🔄 **Step 3: Insert Sample Data**

Once the tables are created, insert sample data to test the data warehouse:

```sql
INSERT INTO Supplier_Dimension (...) VALUES (...);  -- Insert Supplier Data
INSERT INTO Product_Dimension (...) VALUES (...);   -- Insert Product Data
INSERT INTO Customer_Dimension (...) VALUES (...);  -- Insert Customer Data
INSERT INTO Date_Dimension (...) VALUES (...);      -- Insert Date Data
INSERT INTO Store_Dimension (...) VALUES (...);     -- Insert Store Data
INSERT INTO Sales_Fact (...) VALUES (...);          -- Insert Sales Data
```

---

## 🔍 **Step 4: Data Mining and Analysis Queries**

You can now run various SQL queries to analyze the data and extract insights.

### ➡️ **Query 1: Retrieve All Sales Transactions**

```sql
SELECT * FROM Sales_Fact;
```

### ➡️ **Query 2: Product Details for Each Transaction**

```sql
SELECT 
    sf.Transaction_ID, 
    p.Product_Name, 
    sf.Quantity, 
    sf.Sales_Amount, 
    sf.Discount, 
    sf.Revenue 
FROM 
    Sales_Fact sf 
JOIN 
    Product_Dimension p ON sf.Product_ID = p.Product_ID;
```

### ➡️ **Query 3: Total Revenue by Customer**

```sql
SELECT 
    c.Customer_Name, 
    SUM(sf.Revenue) AS Total_Revenue 
FROM 
    Sales_Fact sf 
JOIN 
    Customer_Dimension c ON sf.Customer_ID = c.Customer_ID 
GROUP BY 
    c.Customer_Name;
```

### ➡️ **Query 4: Sales with Date Details**

```sql
SELECT 
    d.Date, 
    sf.Transaction_ID, 
    sf.Revenue 
FROM 
    Sales_Fact sf 
JOIN 
    Date_Dimension d ON sf.Date_ID = d.Date_ID;
```

### ➡️ **Query 5: Top-Selling Products**

```sql
SELECT 
    p.Product_Name, 
    SUM(sf.Quantity) AS Total_Quantity_Sold 
FROM 
    Sales_Fact sf 
JOIN 
    Product_Dimension p ON sf.Product_ID = p.Product_ID 
GROUP BY 
    p.Product_Name 
ORDER BY 
    Total_Quantity_Sold DESC;
```

### ➡️ **Query 6: Total Sales, Discounts, and Net Revenue by Store**

```sql
SELECT 
    s.Store_Name, 
    SUM(sf.Sales_Amount) AS Total_Sales, 
    SUM(sf.Discount) AS Total_Discount, 
    SUM(sf.Revenue) AS Net_Revenue 
FROM 
    Sales_Fact sf 
JOIN 
    Store_Dimension s ON sf.Store_ID = s.Store_ID 
GROUP BY 
    s.Store_Name;
```

---

## 📉 **Step 5: Data Mining Process**

**1. Data Extraction:**  
   ↳ Use the queries to extract meaningful insights from the data.

**2. Aggregation:**  
   ↳ Use `SUM()`, `AVG()`, and `COUNT()` functions to aggregate sales, revenue, and customer information.

**3. Joining Tables:**  
   ↳ Join fact and dimension tables to combine product, customer, date, and store data with sales transactions.

**4. Filtering Data:**  
   ↳ Add `WHERE` conditions to filter data based on specific requirements, such as time periods, stores, or products.

**5. Sorting and Grouping:**  
   ↳ Use `ORDER BY` and `GROUP BY` clauses to sort and group the results for better understanding.

---

## ⚠️ **Step 6: Dropping the Database**

You can drop the entire database if needed (caution: this action is irreversible and will delete all data).

```sql
DROP DATABASE IF EXISTS E_Commerce_DataWarehouse;
```

---
