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
  - Fix encoding issues and rename column

- *Sales Analysis KPIs*  
  - Total Sales  
  - Total Orders  
  - Total Quantity Sold  
  - Month-over-Month (MoM) growth and differences

- *Daily and Weekly Insights*  
  - Sales trends by day  
  - Comparison with average daily sales  
  - Weekday vs Weekend sales patterns

- *Category & Location Insights*  
  - Sales by Store Location  
  - Sales by Product Category  
  - Top 10 Product Sales

- *Time-based Trends*  
  - Sales by Day of the Week  
  - Sales by Hour of the Day

## Purpose

The goal of this project is to demonstrate practical SQL skills in real-world business analytics scenarios using transactional data.

## File

- coffee_shop_queries.docx: Contains all SQL queries with explanations.
