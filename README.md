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

### Total Sales

```sql
SELECT ROUND(SUM(unit_price * transaction_qty)) as Total_Sales 
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5 -- for month of (CM-May)

```
