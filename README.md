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

### Data Cleaning & Formatting  
  - Convert transaction_date and transaction_time to proper SQL formats  
  - Fix encoding issues and rename columns

### Sales KPIs  
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
### 4.MoM (Month-over-Month) Growth and Differences
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
## Differences

### Trends & Insights
 - Daily Sales and Average Sales  
 - Above/Below Average Day Classification  
 - Sales by Weekday vs Weekend

### 1.Daily Sales
```sql
SELECT 
    DAY(transaction_date) AS day_of_month,
    ROUND(SUM(unit_price * transaction_qty),1) AS total_sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5  -- Filter for May
GROUP BY 
    DAY(transaction_date)
ORDER BY 
    DAY(transaction_date);
```
![image](https://github.com/user-attachments/assets/7ccb6bad-f163-4f62-aa85-896f8077d23c)  ![image](https://github.com/user-attachments/assets/f26545c5-6252-479c-8170-c241f16f5e71)
### Average Sales
```sql
SELECT 
SELECT AVG(total_sales) AS average_sales
FROM (
    SELECT 
        SUM(unit_price * transaction_qty) AS total_sales
    FROM 
        coffee_shop_sales
	WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        transaction_date
) AS internal_query;

```
![image](https://github.com/user-attachments/assets/8a60d676-edf5-4b10-baae-6b0ed77bb564)
### 2.Above/Below Average Day Classification
```sql
SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;
```
![image](https://github.com/user-attachments/assets/0da522be-9d5a-40a7-bf1e-1689e66981f2) ![image](https://github.com/user-attachments/assets/b0680ce9-431a-4256-9d96-17f92fee8d49)
### 3.Sales by Weekday vs Weekend
```sql
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END AS day_type,
    ROUND(SUM(unit_price * transaction_qty),2) AS total_sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5  -- Filter for May
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END;
```
![image](https://github.com/user-attachments/assets/35323f29-d824-4f08-af6c-751d9b8f5b2f)
### Product & Store Performance 
  - Sales by Store Location  
  - Sales by Product Category  
  - Top 10 Products by Sales

### 1.Sales by Store Location
```sql
SELECT 
	store_location,
	SUM(unit_price * transaction_qty) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(transaction_date) =5 
GROUP BY store_location
ORDER BY 	SUM(unit_price * transaction_qty) DESC
```
![image](https://github.com/user-attachments/assets/adaeba45-fbad-4af2-8bce-15b2bd4e76da)
### 2.Sales by Product Category
```sql
SELECT 
	product_category,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(transaction_date) = 5 
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC
```
![image](https://github.com/user-attachments/assets/7ced8c4f-bd4d-4977-92e3-16bafef60fb8)
### 3.Top 10 Products By Sales
```sql
SELECT 
	product_type,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(transaction_date) = 5 
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10
```
![image](https://github.com/user-attachments/assets/1b3becb5-bfc8-47a2-8d48-b4a7fd76b715)
### Time-of-Day Analysis 
  - Sales by Hour  
  - Sales by Day of the Week

### 1.Sales by Hour
```sql
SELECT 
    HOUR(transaction_time) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    HOUR(transaction_time)
ORDER BY 
    HOUR(transaction_time);
```
![image](https://github.com/user-attachments/assets/60183df5-3b34-4690-8e28-a21ce8fcd69c)
### 2.Sales by Day of the Week
```sql
SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;
```
![image](https://github.com/user-attachments/assets/c1fc3ed4-ade7-4f48-8298-204377cb802a)

## Conclusion

This SQL project demonstrates how structured queries can be used to extract valuable insights from raw transactional data. By cleaning and transforming the dataset, and calculating key performance metrics such as sales, orders, and growth trends, we gain a deeper understanding of the coffee shop’s business performance. 

These insights can be used to support data-driven decisions related to inventory, staffing, marketing, and operational efficiency. This project also lays a strong foundation for building interactive dashboards using tools like Power BI or Tableau in future stages.






















