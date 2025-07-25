-- SQL Retail Sales Analysis - P1
CREATE database sql_proj_01;
USE sql_proj_01;
-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
SELECT * FROM retail_sales
LIMIT 10;

SELECT 
    COUNT(transaction_id) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    -- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select count(total_sale) as all_sales
From  retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select count(transaction_id) as all_transcations 
from retail_sales
where category = 'Clothing'
   and quantity >= 3
   and sale_date >= '2022-11-01'
   and sale_date < '2022-12-01';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, 
sum(total_sale) as total_sales,
count(*) as Total_Orders
from retail_sales
group by category
order by total_sales;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as average_age
from retail_sales
where category = 'Beauty' ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select count(transaction_id) as total_sales
from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,
gender,
count(transaction_id) as total_transactions
from retail_sales
group by category, gender
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year,month,Average_sales
from(

select year(sale_date) as year,
       month(sale_date) as month,
       avg(total_sale) as Average_sales,
       RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) DESC) as ranks
from retail_sales
group by year, month
order by year, Average_sales desc) as t1
where ranks = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,
sum(total_sale) as Total_sales
from retail_sales
group by customer_id
order by Total_sales desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct customer_id) as unique_customers
from retail_sales
group by category
order by unique_customers;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)

SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;

-- End of project
