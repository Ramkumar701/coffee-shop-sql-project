# Coffee Shop Sales SQL Project

This project contains SQL queries used to analyze sales performance data from a coffee shop database. The data includes transactions with details such as product types, prices, quantities, dates, and times.

## Database Schema

Below is the schema for the coffee_shop_sales table used in this project:

```sql
CREATE TABLE coffee_shop_sales (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    transaction_time TIME,
    product_category VARCHAR(50),
    product_type VARCHAR(50),
    unit_price DECIMAL(5,2),
    transaction_qty INT,
    store_location VARCHAR(50)
);
```

## Key Features

- *Data Cleaning & Formatting*  
  - Convert transaction_date and transaction_time to proper SQL formats  
  - Fix encoding issues and rename columns

- *Sales KPIs*  
  - Total Sales  
  - Total Orders  
  - Total Quantity Sold  
  - MoM (Month-over-Month) Growth and Differences

### 1.Total Sales

```sql
SELECT ROUND(SUM(unit_price * transaction_qty)) as Total_Sales 
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5 -- for month of (CM-May)

```
![image](https://github.com/user-attachments/assets/969334ba-737c-44f4-815f-4594ae8e3a66)

### 2.Total Orders

```sql
SELECT COUNT(transaction_id) as Total_Orders
FROM coffee_shop_sales 
WHERE MONTH (transaction_date)= 5 -- for month of (CM-May)

```
![image](https://github.com/user-attachments/assets/7a0d6ca0-a0ca-409f-ab21-075e328aea49)

### 3.Total Quantity Sold

```sql
SELECT SUM(transaction_qty) as Total_Quantity_Sold
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5 -- for month of (CM-May)

```
![image](https://github.com/user-attachments/assets/427a720b-f8d0-4d30-89d9-ef7e7e6d6252)

### 3.MoM (Month-over-Month) Growth and Differences

```sql
SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for months of April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);

```
![image](https://github.com/user-attachments/assets/9dd1de0b-fdaa-489a-97ba-e9560f4df7af)





