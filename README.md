**Pizzeria Sales SQL Analysis**
This repository contains an SQL-based data analysis project focused on exploring sales patterns and performance metrics from a fictional pizzeria's order data. The goal is to extract actionable insights using structured queries across multiple related tables.

**Project Overview**
Using SQL, this project analyzes pizza order data to answer key business questions.

**Dataset Schema**
The database consists of four main tables:

orders – Contains order_id, date, and time
order_details – Contains order_details_id, order_id, pizza_id, and quantity
pizzas – Contains pizza_id, pizza_type_id, size, and price
pizza_types – Contains pizza_type_id, name, category, and ingredients

**SQL Concepts Applied**
Joins across multiple tables
Aggregate functions: SUM, COUNT, AVG, ROUND
Grouping and filtering (GROUP BY, WHERE, ORDER BY)
Window functions: RANK, SUM() OVER
Common Table Expressions (CTEs) using WITH
Time-based analysis using DATE() and HOUR()

**Key Analyses**
Total revenue and order count
Most and least ordered pizzas
Category-wise top 3 pizzas by revenue
Hourly order distribution
Daily average pizzas ordered
Cumulative revenue tracking
