-- Customer Cohort Analysis using SQL

-- Overview

-- This project performs customer cohort analysis using SQL to evaluate user retention and behavior over time.
-- Customers are grouped based on their first purchase month, and their activity is tracked across subsequent months.

-- Objective

-- Analyze customer retention patterns
-- Identify churn trends over time
-- Understand long-term customer engagement

-- Tech Stack

-- SQL (PostgreSQL)
-- Data Cleaning and Transformation
-- Analytical Queries

-- Dataset

-- The dataset includes:
-- Order details (Order ID, Date, Quantity, Price)
-- Customer information (Customer ID, Name, Location)
-- Product details (SKU, Category)

-- Process Workflow

-- 1. Data Cleaning
-- Renamed columns and corrected data types
-- Converted inconsistent date formats
-- Removed duplicate records
-- Validated null values

-- 2. Cohort Creation

-- Identified each customer's first purchase date
-- Grouped customers into monthly cohorts

-- 3. Cohort Index Calculation

-- Calculated the time difference in months between first purchase and subsequent transactions

-- 4. Retention Analysis

-- Counted active customers per cohort over time
-- Calculated retention percentage

-- 5. Cohort Matrix

-- Transformed data into matrix format (M0, M1, M2...)
-- Enabled comparison of retention trends across cohorts

-- Output Example

-- Cohort Month | M0 | M1 | M2 | M3
-- Jan 2023     |100| 45 | 30 | 20
-- Feb 2023     |100| 50 | 35 | 25

-- Key Insights

-- Retention declines after the first month
-- Some cohorts show stronger repeat behavior
-- Useful for identifying engagement and churn patterns

-- Future Improvements

-- Add revenue-based cohort analysis
-- Build visualization using Python (Pandas/Seaborn)
-- Perform RFM analysis for deeper insights
