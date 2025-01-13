-- CREATE DATABASE sql_project;

CREATE TABLE retail_sales(
transaction_id int primary KEY,
sale_date DATE,
sale_time TIME,
customer_id int,
gender varchar(15),
age int,
category varchar(25),
quantity int,
price_per_unit float,
cogs float,
total_sale float
);

-- Data Cleaning--------------------------------------------------------------
select * from retail_sales;
-- -----------------------------------------------------
select COUNT(*) from retail_sales;
-- -----------------------------------------------------------------------
ALTER TABLE retail_sales
CHANGE ï»¿transactions_id transactions_id int;

-- ---------------------------------------------------------------
ALTER TABLE retail_Sales
CHANGE quantiy quantity int;
-- ------------------------------------------------------------------

select * from retail_Sales
 WHERE 
 customer_id IS NULL
 or
 transactions_id IS NULL
 OR
  sale_date IS NULL
  or
   sale_time IS NULL
   or
   gender IS NULL
   or
   age IS NULL
   or
   category IS NULL
   or
   quantity IS NULL
   or 
   price_per_unit IS NULL
  or
  cogs IS NULL
  or
  total_sale IS NULL;
-- ----------------------------------------------------------------------------
DELETE FROM retail_sales
WHERE customer_id IS NULL 
or transactions_id IS NULL
OR sale_date IS NULL
or sale_time IS NULL
or gender IS NULL
or age IS NULL
or category IS NULL
or quantity IS NULL
or price_per_unit IS NULL
or cogs IS NULL
or total_sale IS NULL;

-- -----------------------------Data Exploration----------------------------------------------
 
 -- Total number of sales-------------------------------
-- select COUNT(*) as Total_Sales from retail_sales;

-- Total customers---------------------
-- Select COUNT(customer_id) as Total_customer from retail_sales;

-- Total unique customer---------------------
-- Select COUNT(distinct customer_id) as Total_customer from retail_sales;

-- Total number of category-------------
-- SELECT COUNT(distinct category) as Total_category from retail_sales;

-- Q.1Total number of sales in date 2022-11-05------------
SELECT COUNT(*)
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 all transactions where category is clothing and quantity is more than or equal to 4-----------------
SELECT *
FROM retail_sales
WHERE category = 'clothing' and 
sale_date >= '2022-11-01'  and quantity >= 4;

-- Q.3 Calculate total sales and total order for each category--------------------
SELECT category,
 SUM(total_sale) as net_sales,
 COUNT(*) as total_order
FROM retail_sales
group by 1;

-- Q.4 find average age of customers who purchased items from Beauty category-------------------
SELECT 
avg(age) as average_customers
FROM retail_sales
WHERE category = 'Beauty'; 

-- Q.5 find all the transactions where the total sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 find total number of transaction (transaction id) made by each gender in each category-----------------
SELECT 
category,
gender,
COUNT(*) as number_of_transaction
FROM retail_sales
GROUP BY category, gender 
ORDER BY 1

-- Q.7 find out average sale for each month. Find out best selling month in each year-------------
SELECT  
  extract(YEAR from sale_date) as year,
  extract(MONTH from sale_date) as month,
  avg(total_sale) as avg_sale,
  RANK() OVER(PARTITION BY extract(YEAR from sale_date) ORDER BY avg(total_sale) DESC)
FROM retail_sales
GROUP BY 1,2 

-- Q.8 find top 5 customers based on the highest total sales
SELECT customer_id, 
sum(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
order by 2 DESC
LIMIT 5

-- Q.9 find the number of unique customers who purchased items from each category----------------

SELECT category,
count(DISTINCT customer_id)
FROM retail_sales
GROUP BY 1

-- Q10 create each shift and number of orders 
WITH hourly_sale
as 
(
SELECT *, 
	CASE 
	  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
 	  ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT shift,
 count(*) as total_orders
FROM hourly_sale
GROUP BY 1 







