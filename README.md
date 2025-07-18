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

🔍 Data Exploration & Cleaning
Count total records, unique customers, and categories.

Check & delete rows with null values.

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



