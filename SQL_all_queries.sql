SELECT * FROM pizza_sales.pizza_sales;

-- converted text to datetype
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, "%d/%m/%Y");

-- Total Revenue
SELECT FORMAT(SUM(total_price), 2) as Total_Revenue FROM pizza_sales;


--  Average Order Value
SELECT format(SUM(total_price) / COUNT(DISTINCT order_id) , 2) AS Avg_order_Value FROM pizza_sales;


-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas Per Order
SELECT sum(quantity) / count(DISTINCT order_id)
AS Avg_Pizzas_per_order
FROM pizza_sales;




-- sales by days in week / weekend trends
SELECT dayname(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- sales by month in year / seasonal trends 
SELECT MONTHNAME(order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date);

-- percentage of sales by pizza category 
select 
	pizza_category , 
    round(sum(total_price)) , 
	round(sum(total_price)*100/(select sum(total_price) from pizza_sales) , 2)  as "% of sales category "
from pizza_sales
group by pizza_category
with ROLLUP;

-- percentage of sales by pizza size 
select 
	pizza_size , 
    round(sum(total_price)) , 
    round(sum(total_price)*100/(select sum(total_price) from pizza_sales) , 2)  as "% of sales Size "
from pizza_sales
group by pizza_size
with ROLLUP;

-- total pizzas sold by pizza category 
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;



-- top 5 pizza WRT total revenue
SELECT
    pizza_name, -- Select the pizza name
    SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC
LimiT 5; 

-- bottom 5 wrt revenue 
-- top 5 pizza WRT total revenue
SELECT
    pizza_name, -- Select the pizza name
    SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue
LimiT 5; 


-- Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold
LIMIT 5;


-- top Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- bottom Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;























