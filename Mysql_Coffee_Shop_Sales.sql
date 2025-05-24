SELECT *  FROM coffee_shop_sales;
SELECT CONCAT((ROUND(SUM(transaction_qty * unit_price)))/1000, 'K') AS Total_Sales
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 3; -- March Month
DESCRIBE  coffee_shop_sales;

-- TOTAL SALES

SELECT 
MONTH(transaction_date),
ROUND(SUM(transaction_qty * unit_price)) AS Total_Sales,
(SUM(transaction_qty * unit_price) - LAG(SUM(transaction_qty * unit_price),1)
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty * unit_price),1)
OVER(ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- TOTAL ORDER
SELECT MONTH(transaction_date) AS MONTH,
Round(COUNT(transaction_id)) AS Total_Order,
(COUNT(transaction_id) - LAG(COUNT(transaction_id))
OVER(ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id))
OVER(ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM coffee_shop_sales
WHERE month(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- TOTAL QUANTITY
SELECT MONTH(transaction_date) AS month,
ROUND(SUM(transaction_qty)) AS Total_Sales,
(SUM(transaction_qty)- LAG(SUM(transaction_qty)) 
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty))
OVER(ORDER BY MONTH(transaction_date)) * 100 AS mon_increase_percentage
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (4,5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

SELECT 
	concat(ROUND((SUM(transaction_qty * unit_price))/1000,1), 'K') AS Total_Sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000,1), 'K') AS Total_Qty_Sold,
    CONCAT(ROUND(COUNT(transaction_id)/1000,1), 'K') AS Total_Order
FROM coffee_shop_sales
WHERE transaction_date = '2023-03-27';

-- Sales Analysis by Weekdays and Weekends 
SELECT
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'weekends'
    ELSE 'weekdays'
    END AS day_type,
    CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1), 'K') AS Total_Sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = '2'
    GROUP BY CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'weekends'
    ELSE 'weekdays'
    END;
    
   -- Sales Analysis by Store Location
    SELECT 
		store_location,
        CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,2), 'K') AS Total_Sales
        FROM coffee_shop_sales
        WHERE MONTH(transaction_date) = '6'  -- June
        GROUP BY store_location
        ORDER BY SUM(transaction_qty * unit_price) DESC;
        
	SELECT CONCAT(ROUND(AVG(Total_Sales)/1000,1), 'K') AS Avg_Sales
    FROM
		(SELECT SUM(transaction_qty * unit_price) AS Total_Sales
        FROM coffee_shop_sales
        WHERE MONTH(transaction_date) = '3'
        GROUP BY transaction_date
        ) AS INTERNAL_QYERIES;
        
	-- Daily Sales Analysis with Average line
	SELECT 
		day_of_month,
        CASE 
        WHEN Total_Sales > Avg_Sales THEN 'Above averge'
        WHEN Total_Sales < Avg_Sales THEN 'Below average'
        ELSE 'Average'
        END AS Sales_Status,
        Total_Sales
	FROM
    (SELECT 
		DAY(transaction_date) AS day_of_month,
		SUM(transaction_qty * unit_price) AS Total_Sales,
        SUM(AVG(transaction_qty * unit_price)) over() AS Avg_Sales
	FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = '5'
    GROUP BY DAY(transaction_date)
    ) AS Sales_data
    ORDER BY day_of_month;
    
    -- Top 10 products by Sales
    SELECT
		product_category,
        SUM(transaction_qty * unit_price) AS Total_Sales
	FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = '5'
    GROUP BY product_category 
    ORDER BY SUM(transaction_qty * unit_price) DESC
    limit 10;
    
    
    
    SELECT 
		SUM(transaction_qty * unit_price) AS Total_Sales,
        SUM(transaction_qty) AS Total_qty_sold,
        COUNT(*) AS Total_orders
	FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = '5'
    AND DAYOFWEEK(transaction_date) = '1'
    AND HOUR(transaction_time) = '14';
    
    -- Sales Analysis by Days and Hours
    
    SELECT 
		CASE
			WHEN DAYOFWEEK(transaction_date) = '2' THEN 'Monday'
            WHEN DAYOFWEEK(transaction_date) = '3' THEN 'Tuesday'
            WHEN DAYOFWEEK(transaction_date) = '4' THEN 'Wednesday'
            WHEN DAYOFWEEK(transaction_date) = '5' THEN 'Thursday'
            WHEN DAYOFWEEK(transaction_date) = '6' THEN 'Friday'
            WHEN DAYOFWEEK(transaction_date) = '7' THEN 'Saturday'
            ELSE 'Sunday'
		END AS Day_of_Week,
        ROUND(SUM(transaction_qty * unit_price)) AS Total_Sales
	FROM coffee_shop_sales
    WHERE
        MONTH(transaction_date) = '5'
	GROUP BY 
    CASE
			WHEN DAYOFWEEK(transaction_date) = '2' THEN 'Monday'
            WHEN DAYOFWEEK(transaction_date) = '3' THEN 'Tuesday'
            WHEN DAYOFWEEK(transaction_date) = '4' THEN 'Wednesday'
            WHEN DAYOFWEEK(transaction_date) = '5' THEN 'Thursday'
            WHEN DAYOFWEEK(transaction_date) = '6' THEN 'Friday'
            WHEN DAYOFWEEK(transaction_date) = '7' THEN 'Saturday'
            ELSE 'Sunday'
            END;