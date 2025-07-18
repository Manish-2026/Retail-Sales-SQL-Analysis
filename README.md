# 🛒 Retail Sales SQL Analysis Project

## 📊 Project Overview

**Project Title**: Retail Sales SQL Analysis  
**Level**: Beginner to Intermediate  
**Database**: `sql_proj_01`  

This project showcases practical SQL skills used by data analysts to clean, explore, and analyze retail sales data.  
It covers database creation, data cleaning, EDA, and answering real business questions — helping understand customer behavior, sales trends, and product performance.

---

## 🎯 Objectives

1. **Set up a retail sales database**: Create & populate a database with transaction-level retail data.
2. **Data Cleaning**: Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploration to understand data patterns.
4. **Business Analysis**: Answer key business questions using SQL queries.

---

## 📁 Project Structure

Retail-Sales-SQL-Analysis/
├── data/
│ └── SQL - Retail Sales Analysis_utf .csv
└── sql/
└── sql_based_proj_01.sql

---

## 🛠 Database & Table Setup

- **Database**: `sql_proj_01`
- **Table**: `retail_sales`

```sql
CREATE DATABASE sql_proj_01;
USE sql_proj_01;

CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
); 
```
🔍 Data Exploration & Cleaning
Count total records, unique customers, and categories.

Check & delete rows with null values.
```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

📊 Data Analysis & Key Questions
1️⃣ Sales on '2022-11-05'
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2️⃣ Transactions for 'Clothing' category with quantity > 3 in Nov-2022
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND sale_date >= '2022-11-01' AND sale_date < '2022-12-01';
```

3️⃣ Total sales & order count per category
```sql
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

4️⃣ Average age of customers who purchased 'Beauty' items
```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

5️⃣ Transactions where total_sale > 1000
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

6️⃣ Transaction counts by gender and category
```sql
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender;
```

7️⃣ Best selling month (highest avg sale) each year
```sql
SELECT year, month, Average_sales
FROM (
    SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month,
           AVG(total_sale) AS Average_sales,
           RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
) t
WHERE rank = 1;
```

8️⃣ Top 5 customers by total sales
```sql
SELECT customer_id, SUM(total_sale) AS Total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_sales DESC
LIMIT 5;
```

9️⃣ Unique customer count per category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

🔟 Order count by shift (Morning <12, Afternoon 12–17, Evening >17)
```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```

🧠 Findings
Peak Sales: Identified best-selling months each year.
Top Customers: Found highest spending customers.
Customer Demographics: Average age by category.
High-Value Orders: Transactions >1000.
Sales Patterns: More sales in Morning/Afternoon shifts; category trends.

📌 Conclusion
This project demonstrates practical SQL techniques for data analysis — covering database setup, data cleaning, EDA, and answering business questions.
It helps understand retail sales trends, customer behavior, and category performance.



