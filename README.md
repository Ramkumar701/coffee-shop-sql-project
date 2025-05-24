# Coffee Shop Sales SQL Project

This project contains SQL queries used to analyze sales performance data from a coffee shop database. The data includes transactions with details such as product types, prices, quantities, dates, and times.

## Dataset Description

The dataset simulates a coffee shop's point-of-sale system, and includes the following columns:

- transaction_id: Unique ID for each transaction
- transaction_date: Date of purchase
- transaction_time: Time of purchase
- product_category: Category (e.g., Coffee, Tea, Snacks)
- product_type: Specific product name
- unit_price: Price per unit
- transaction_qty: Quantity purchased
- store_location: Location of the store

This dataset allows for time-based, product-based, and location-based sales analysis.

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
